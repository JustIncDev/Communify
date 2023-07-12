import 'package:dio/dio.dart';
import 'package:log_service/lib.dart';

import '../../../features/connect/application/connect_bloc.dart';
import '../../../features/registration/application/registration_bloc.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/group_repository_impl.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../data/repositories/storage_repository_impl.dart';

final class BlocFactory {
  BlocFactory(this.dio) {
    logger.logInfo(message: 'BlocFactory created!');
  }

  final Dio dio;

  ConnectBloc createConnectBloc() {
    return ConnectBloc(
      AuthRepositoryImpl(dio),
      ProfileRepositoryImpl(),
    );
  }

  RegistrationBloc createRegistrationBloc() {
    return RegistrationBloc(
      authRepository: AuthRepositoryImpl(dio),
      profileRepository: ProfileRepositoryImpl(),
      groupRepository: GroupRepositoryImpl(dio),
      storageRepository: StorageRepositoryImpl(),
    );
  }
}
