import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:log_service/lib.dart';

import '../../../core/application/common/widgets/social_media_list_tile.dart';
import '../../../core/data/models/bad_words.dart';
import '../../../core/domain/entities/group.dart';
import '../../../core/domain/entities/user.dart';
import '../../../core/domain/repositories/auth_repository.dart';
import '../../../core/domain/repositories/group_repository.dart';
import '../../../core/domain/repositories/profile_repository.dart';
import '../../../core/domain/repositories/storage_repository.dart';
import '../../../core/util/enum.dart';
import '../../../core/util/util.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({
    required IAuthRepository authRepository,
    required IProfileRepository profileRepository,
    required IGroupRepository groupRepository,
    required IStorageRepository storageRepository,
  })  : _authRepository = authRepository,
        _profileRepository = profileRepository,
        _groupRepository = groupRepository,
        _storageRepository = storageRepository,
        super(RegistrationInitial()) {
    on<RegistrationGroupEvent>(_onGroupTypeSelected);
    on<RegistrationAgreeEvent>(_onAgreeEvent);
    on<RegistrationSelectThemeGroupEvent>(_onSelectGroupThemeEvent);
    on<RegistrationCreateGroupFinishEvent>(_onFinishCreateGroupEvent);
    on<RegistrationFillFirstProfilePageEvent>(_onFillFirstProfilePageEvent);
    on<RegistrationFillFirstProfilePageEvent>(_onFillSecondProfilePageEvent);
  }

  final IAuthRepository _authRepository;
  final IProfileRepository _profileRepository;
  final IGroupRepository _groupRepository;
  final IStorageRepository _storageRepository;

  void _onGroupTypeSelected(RegistrationGroupEvent event, Emitter<RegistrationState> emit) {
    if (event is RegistrationJoinGroupEvent) {
      emit(RegistrationChooseNetworkFinished(createGroup: false));
    } else if (event is RegistrationCreateGroupEvent) {
      emit(RegistrationChooseNetworkFinished(createGroup: true));
    }
  }

  Future<void> _onAgreeEvent(RegistrationAgreeEvent event, Emitter<RegistrationState> emit) async {
    try {
      final result = await _validateFields(event, emit);
      if (!result) {
        return;
      }
      emit(RegistrationLoading());
      final user = await _authRepository.getCurrentUser();
      if (user == null) throw Exception("User's not found");
      await _profileRepository.updateUserProfile(
        user.copyWith(
          firstName: event.firstName,
          lastName: event.lastName,
          username: event.username,
          dateOfBirth: event.dateOfBirth,
        ),
      );
      emit(RegistrationAgreeSuccess());
    } on Object catch (e, s) {
      logger.logError(message: e.toString(), error: e, stackTrace: s);
      emit(RegistrationFailure(e.toString()));
    }
  }

  Future<void> _onSelectGroupThemeEvent(
    RegistrationSelectThemeGroupEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      final groupTheme = event.groupTheme;
      if (event.other) {
        final validationGroupThemeMessage = validateGroupName(
          groupName: groupTheme,
          harmfulWord: await _authRepository.checkForBadWord(
            BadWordsRequest(
              body: groupTheme,
            ),
          ),
        );
        late final errorMessages = <FieldType, String>{};
        if (validationGroupThemeMessage != null) {
          errorMessages.addAll({FieldType.other: validationGroupThemeMessage});
        }
        if (errorMessages.isNotEmpty) {
          emit(RegistrationInputError(errors: errorMessages));
          return;
        }
      }
      emit(RegistrationSelectThemeGroupSuccessState(groupTheme));
    } on Object catch (e, s) {
      logger.logError(message: e.toString(), error: e, stackTrace: s);
      emit(RegistrationFailure(e.toString()));
    }
  }

  Future<void> _onFinishCreateGroupEvent(
    RegistrationCreateGroupFinishEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      final groupName = event.groupName;
      final validationGroupNameMessage = validateGroupName(
        groupName: groupName,
        harmfulWord: await _authRepository.checkForBadWord(
          BadWordsRequest(
            body: groupName,
          ),
        ),
      );
      late final errorMessages = <FieldType, String>{};
      if (validationGroupNameMessage != null) {
        errorMessages.addAll({FieldType.groupName: validationGroupNameMessage});
      }
      if (errorMessages.isNotEmpty) {
        emit(RegistrationInputError(errors: errorMessages));
        return;
      }
      final request =
          Group(groupName: event.groupName, groupTheme: event.groupTheme, description: '');
      await _groupRepository.createGroup(request);
      emit(RegistrationFinishGroupCreateState(event.groupName));
    } on Object catch (e, s) {
      logger.logError(message: e.toString(), error: e, stackTrace: s);
      emit(RegistrationFailure(e.toString()));
    }
  }

  Future<void> _onFillFirstProfilePageEvent(
    RegistrationFillFirstProfilePageEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      final bioDescription = event.bioDescription;
      String? validationMessage;
      final harmfulLanguage = await _authRepository.checkForBadWord(
        BadWordsRequest(
          body: bioDescription,
        ),
      );
      if (harmfulLanguage) {
        validationMessage = 'Harmful language!';
      }
      late final errorMessages = <FieldType, String>{};
      if (validationMessage != null) {
        errorMessages.addAll({FieldType.bio: validationMessage});
      }
      if (errorMessages.isNotEmpty) {
        emit(RegistrationInputError(errors: errorMessages));
        return;
      }
      final user = await _authRepository.getCurrentUser();
      if (user == null) throw Exception("User's not found");

      final data = await _storageRepository.uploadFile(event.profilePicture);
      if (data.isNotEmpty) {
        await _profileRepository.updateUserProfile(
          user.copyWith(
            avatar: data,
            bio: event.bioDescription,
          ),
        );
      }
      emit(RegistrationFillFirstPageSuccessState());
    } on Object catch (e, s) {
      logger.logError(message: e.toString(), error: e, stackTrace: s);
      emit(RegistrationFailure(e.toString()));
    }
  }

  Future<void> _onFillSecondProfilePageEvent(
    RegistrationFillSecondProfilePageEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      emit(RegistrationLoading());
      await _profileRepository.addSocialProviders(event.providers);
      emit(RegistrationFillSecondPageSuccessState());
    } on Object catch (e, s) {
      logger.logError(message: e.toString(), error: e, stackTrace: s);
      emit(RegistrationFailure(e.toString()));
    }
  }

  Future<bool> _validateFields(
    RegistrationAgreeEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    final validationFirstNameMessage = validateName(
      name: event.firstName,
      harmfulWord: await _authRepository.checkForBadWord(
        BadWordsRequest(body: event.firstName),
      ),
    );
    final validationLastNameMessage = validateName(
      name: event.lastName,
      harmfulWord: await _authRepository.checkForBadWord(
        BadWordsRequest(body: event.lastName),
      ),
    );
    final validationUsernameMessage = validateUsername(
      username: event.username,
      harmfulWord: await _authRepository.checkForBadWord(
        BadWordsRequest(body: event.username),
      ),
    );
    final validationBirthDateMessage = validateDateOfBirth(event.dateOfBirth);

    late final errorMessages = <FieldType, String>{};

    if (validationFirstNameMessage != null) {
      errorMessages.addAll({FieldType.firstname: validationFirstNameMessage});
    }

    if (validationLastNameMessage != null) {
      errorMessages.addAll({FieldType.lastname: validationLastNameMessage});
    }

    if (validationUsernameMessage != null) {
      errorMessages.addAll({FieldType.username: validationUsernameMessage});
    }

    if (validationBirthDateMessage != null) {
      errorMessages.addAll({FieldType.dateOfBirth: validationBirthDateMessage});
    }

    if (errorMessages.isNotEmpty) {
      emit(RegistrationInputError(errors: errorMessages));
      return false;
    }
    return true;
  }
}
