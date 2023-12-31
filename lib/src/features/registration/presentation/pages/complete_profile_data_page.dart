import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:log_service/lib.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/application/common/widgets/gradient/gradient_box_border.dart';
import '../../../../core/application/common/widgets/gradient/gradient_outline_input_border.dart';
import '../../../../core/application/common/widgets/primary_text_field.dart';
import '../../../../core/application/common/widgets/stories_indicator_widget.dart';
import '../../../../core/application/navigation/router.dart';
import '../../../../core/util/assets/colors/colors.dart';
import '../../../../core/util/assets/text/text_extention.dart';
import '../../../../core/util/enum.dart';
import '../../application/registration_bloc.dart';

class CompleteProfileDataPage extends StatefulWidget {
  const CompleteProfileDataPage({
    super.key,
  });

  @override
  State<CompleteProfileDataPage> createState() =>
      _CompleteProfileDataPageState();
}

class _CompleteProfileDataPageState extends State<CompleteProfileDataPage> {
  final _image = ValueNotifier<XFile?>(null);
  final ValueNotifier<bool> _isBottomSheetOpen = ValueNotifier(false);
  final _bioTextController = TextEditingController();
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _bioTextController.addListener(_updateButtonState);
    _image.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _bioTextController
      ..removeListener(_updateButtonState)
      ..dispose();
    super.dispose();
  }

  void _updateButtonState() {
    final enableButton =
        _bioTextController.text.isNotEmpty || _image.value != null;
    _isButtonEnabled.value = enableButton;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme =
        Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationFillFirstPageSuccessState) {
          AppRouter.instance().go('/sign-up/complete-profile/second');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Stack(
            alignment: Alignment.center,
            children: [
              if (state is RegistrationLoading)
                CircularProgressIndicator(
                  color: AppColors.pumpkin.value,
                  backgroundColor: AppColors.grape.value,
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                  const StoriesProgressIndicatorWidget(
                    currentIndex: 1,
                    storiesNumber: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: S.current.complete_your_profile,
                            style: textTheme.bold30.copyWith(
                              fontFamily: 'Montserrat',
                              color: AppColors.whiteSmoke.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.current.profile_picture,
                          style: textTheme.medium15.copyWith(
                            color: AppColors.pumpkin.value,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        const SizedBox(height: 7),
                        GestureDetector(
                          onTap: () => _showPicker(context),
                          child: ValueListenableBuilder<XFile?>(
                            valueListenable: _image,
                            builder: (context, value, child) {
                              return Container(
                                padding: EdgeInsets.all(value != null ? 0 : 55),
                                decoration: BoxDecoration(
                                  color: AppColors.swamp.value.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(15),
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        AppColors.gainsboro.value
                                            .withOpacity(0.5),
                                        AppColors.darkSlate.value,
                                      ],
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: value != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.file(
                                          File(value.path),
                                          width: 150,
                                          height: 150,
                                          fit:
                                              BoxFit.cover, // or BoxFit.contain
                                        ),
                                      )
                                    : AppAssets.images.photoIcon.image(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.current.your_bio,
                          style: textTheme.medium15.copyWith(
                            color: AppColors.pumpkin.value,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        const SizedBox(height: 7),
                        PrimaryTextField(
                          hintText: S.current.tell_us_about_yourself,
                          controller: _bioTextController,
                          maxLength: 500,
                          minLines: 12,
                          maxLines: 15,
                          errorText: state is RegistrationInputError &&
                                  state.errors.containsKey(FieldType.bio)
                              ? state.errors[FieldType.bio]
                              : null,
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isButtonEnabled,
                    builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 34),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.pumpkin.value,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 33),
                                ),
                                onPressed: value ? _onContinuePressed : null,
                                child: Center(
                                  child: Text(
                                    S.current.continue_title.toUpperCase(),
                                    style: textTheme.medium15.copyWith(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.whiteSmoke.value,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blueCharcoal.value,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                    side: BorderSide(
                                      color: AppColors.whiteSmoke.value,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 33),
                                ),
                                onPressed: _onSkipPressed,
                                child: Center(
                                  child: Text(
                                    S.current.skip.toUpperCase(),
                                    style: textTheme.medium15.copyWith(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.whiteSmoke.value,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              ValueListenableBuilder(
                builder: (context, value, child) => _isBottomSheetOpen.value
                    ? Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color:
                                AppColors.blueCharcoal.value.withOpacity(0.8),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                valueListenable: _isBottomSheetOpen,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPicker(BuildContext context) {
    _isBottomSheetOpen.value = true;
    showModalBottomSheet<void>(
      backgroundColor: AppColors.blueCharcoal.value,
      context: context,
      barrierColor: Colors.transparent,
      shape: GradientInputBorder(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gainsboro.value.withOpacity(0.5),
            AppColors.darkSlate.value,
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        width: 1,
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.only(
          top: 12,
          left: 46,
          right: 46,
          bottom: 70,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 1,
                decoration: BoxDecoration(
                  color: AppColors.gainsboro.value,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 59),
            ListTile(
              leading: AppAssets.images.photoIcon.image(
                width: 25,
                height: 25,
              ),
              title: Text(S.current.choose_from_library),
              onTap: () async {
                await _getImageFromGallery();
              },
            ),
            ListTile(
              leading: AppAssets.images.cameraIcon.image(
                width: 25,
                height: 25,
              ),
              title: Text(S.current.take_photo),
              onTap: () async {
                await _getImageFromCamera();
              },
            ),
            if (_image.value != null)
              ListTile(
                leading: AppAssets.images.deleteIcon.image(),
                title: const Text('Remove current picture'),
                onTap: () {
                  _image.value = null;
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    ).then((_) {
      _isBottomSheetOpen.value = false;
    });
  }

  Future<void> _getImageFromGallery() async {
    if (Platform.isAndroid) {
      await _pickImage(ImageSource.gallery);
    } else {
      var status = await Permission.photos.status;
      if (!status.isGranted) {
        status = await Permission.photos.request();
      }
      if (status.isGranted) {
        await _pickImage(ImageSource.gallery);
      } else {
        logger.logError(message: 'Error upload file', error: '');
      }
    }
    Navigator.of(context).pop();
  }

  Future<void> _getImageFromCamera() async {
    if (Platform.isAndroid) {
      await _pickImage(ImageSource.camera);
    } else {
      var status = await Permission.photos.status;
      if (!status.isGranted) {
        status = await Permission.photos.request();
      }
      if (status.isGranted) {
        await _pickImage(ImageSource.camera);
      } else {
        logger.logError(message: 'Error upload file', error: '');
      }
    }
    Navigator.of(context).pop();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: source);
    if (image != null) {
      _image.value = image;
    }
  }

  void _onContinuePressed() {
    context.read<RegistrationBloc>().add(
          RegistrationFillFirstProfilePageEvent(
            profilePicture: _image.value!,
            bioDescription: _bioTextController.text,
          ),
        );
  }

  void _onSkipPressed() {
    AppRouter.instance().go('/sign-up/complete-profile/second');
  }
}
