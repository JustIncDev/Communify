import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/application/common/widgets/primary_app_bar.dart';
import '../../../../core/application/common/widgets/primary_text_field.dart';
import '../../../../core/application/navigation/router.dart';
import '../../../../core/util/assets/colors/color_scheme.dart';
import '../../../../core/util/assets/colors/colors.dart';
import '../../../../core/util/assets/text/text_extention.dart';
import '../../../../core/util/enum.dart';
import '../../application/registration_bloc.dart';

class GroupNamePage extends StatefulWidget {
  const GroupNamePage({
    super.key,
    this.groupTheme,
  });

  final String? groupTheme;

  @override
  State<GroupNamePage> createState() => _GroupNamePageState();
}

class _GroupNamePageState extends State<GroupNamePage> {
  final selectedOptionNotifier = ValueNotifier<bool?>(null);
  final _nameTextController = TextEditingController();

  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _nameTextController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    final enableButton = _nameTextController.text.isNotEmpty;
    _isButtonEnabled.value = enableButton;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    final appBar = PrimaryAppBar(
      leading: Center(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _onBackPressed,
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0x33D9D9D9),
              shape: BoxShape.circle,
            ),
            child: AppAssets.images.chevronLeft.image(),
          ),
        ),
      ),
    );

    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationFinishGroupCreateState) {
          AppRouter.instance().go('/sign-up/success', extra: state.groupName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColorScheme.of(context).primary,
          body: Stack(
            alignment: Alignment.center,
            children: [
              if (state is RegistrationLoading)
                CircularProgressIndicator(
                  color: AppColors.pumpkin.value,
                  backgroundColor: AppColors.grape.value,
                ),
              CustomScrollView(
                slivers: [
                  appBar,
                  SliverPadding(
                    padding: const EdgeInsets.all(23),
                    sliver: SliverToBoxAdapter(
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: S.current.choose_name_group,
                              style: textTheme.bold30.copyWith(
                                fontFamily: 'Montserrat',
                                color: AppColors.whiteSmoke.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 23,
                      right: 23,
                      top: 100,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PrimaryTextField(
                            hintText: S.current.your_network,
                            controller: _nameTextController,
                            errorText: state is RegistrationInputError &&
                                    state.errors.containsKey(FieldType.groupName)
                                ? state.errors[FieldType.groupName]
                                : null,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            S.current.you_can_always_change,
                            style: textTheme.medium15.copyWith(
                              color: AppColors.whiteSmoke.value,
                              fontFamily: 'Karla',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 61, right: 61),
                          child: Column(
                            children: [
                              CustomRadioOption(
                                groupValueNotifier: selectedOptionNotifier,
                                value: true,
                                label: S.current.activate_push_notifications,
                              ),
                              CustomRadioOption(
                                groupValueNotifier: selectedOptionNotifier,
                                value: false,
                                label: S.current.decide_later,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 34),
                        ValueListenableBuilder<bool>(
                          valueListenable: _isButtonEnabled,
                          builder: (context, value, child) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 80),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.pumpkin.value,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 33),
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
                            );
                          },
                        ),
                        const SizedBox(height: 34), // Add extra space at the bottom if needed
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _onContinuePressed() {
    context.read<RegistrationBloc>().add(
          RegistrationCreateGroupFinishEvent(
            groupName: _nameTextController.text,
            groupTheme: widget.groupTheme ?? '',
          ),
        );
  }

  void _onBackPressed() {
    AppRouter.instance().go('/sign-up/group/choose-theme');
  }
}

class CustomRadioOption extends StatelessWidget {
  final ValueNotifier<bool?> groupValueNotifier;
  final bool value;
  final String label;

  const CustomRadioOption({
    required this.groupValueNotifier,
    required this.value,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return ValueListenableBuilder<bool?>(
      valueListenable: groupValueNotifier,
      builder: (context, groupValue, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: AppColors.grey.value,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: textTheme.medium15.copyWith(
                    color: AppColors.whiteSmoke.value,
                    fontFamily: 'Karla',
                  ),
                ),
              ),
              Radio<bool>(
                value: value,
                groupValue: groupValue,
                onChanged: (bool? newValue) {
                  groupValueNotifier.value = newValue;
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: AppColors.whiteSmoke.value,
              ),
            ],
          ),
        );
      },
    );
  }
}
