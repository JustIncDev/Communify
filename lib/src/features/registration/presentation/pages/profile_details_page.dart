import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/application/common/widgets/base_container.dart';
import '../../../../core/application/common/widgets/primary_app_bar.dart';
import '../../../../core/application/common/widgets/primary_button.dart';
import '../../../../core/application/common/widgets/primary_text_field.dart';
import '../../../../core/application/navigation/router.dart';
import '../../../../core/util/assets/colors/color_scheme.dart';
import '../../../../core/util/assets/colors/colors.dart';
import '../../../../core/util/assets/text/text_extention.dart';
import '../../../../core/util/enum.dart';
import '../../application/registration_bloc.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({
    Key? key,
    this.createGroup = false,
  }) : super(key: key);

  final bool? createGroup;

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    final appBar = PrimaryAppBar(
      title: S.current.already_have_account,
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
      actions: [
        Center(
          child: PrimaryButton(
            onPressed: _onLoginButtonPressed,
            child: Text(
              'LOGIN',
              style: textTheme.bold12.copyWith(
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Montserrat',
                  color: AppColors.pumpkin.value),
            ),
          ),
        ),
      ],
    );

    final body = SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 9),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: S.current.create_your_profile,
                        style: textTheme.bold30.copyWith(
                          fontFamily: 'Montserrat',
                          color: AppColors.whiteSmoke.value,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 9),
              _ProfileDetailsBodyWidget(
                textTheme: textTheme,
                onNext: _onAgreePressed,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColorScheme.of(context).primary,
      body: CustomScrollView(
        slivers: [
          appBar,
          body,
        ],
      ),
    );
  }

  void _onLoginButtonPressed() {
    AppRouter.instance().go('/login');
  }

  void _onAgreePressed() {
    if (widget.createGroup ?? false) {
      AppRouter.instance().go('/sign-up/group/choose-theme');
    } else {
      AppRouter.instance().go('/sign-up/success');
    }
  }

  void _onBackPressed() {
    AppRouter.instance().go('/sign-up/choose-network');
  }
}

class _ProfileDetailsBodyWidget extends StatefulWidget {
  const _ProfileDetailsBodyWidget({
    required this.textTheme,
    required this.onNext,
    super.key,
  });

  final AppTextTheme textTheme;
  final VoidCallback onNext;

  @override
  State<_ProfileDetailsBodyWidget> createState() => _ProfileDetailsBodyWidgetState();
}

class _ProfileDetailsBodyWidgetState extends State<_ProfileDetailsBodyWidget> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationAgreeSuccess) {
          widget.onNext.call();
        }
      },
      builder: (context, state) {
        return BaseContainerWidget(
          padding: const EdgeInsets.only(
            left: 17,
            right: 17,
            top: 38,
            bottom: 33,
          ),
          contentGradientColors: [
            AppColors.blueCharcoal.value.withOpacity(0.35),
            AppColors.blueCharcoal.value.withOpacity(0.35),
            AppColors.gainsboro.value.withOpacity(0),
          ],
          contentGradientStops: const [0.0, 0.65, 1.0],
          borderGradientColors: [AppColors.suvaGrey.value, AppColors.pumpkin.value],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: PrimaryTextField(
                      hintText: S.current.first_name_hint,
                      labelText: S.current.first_name,
                      controller: _firstNameController,
                      errorText: state is RegistrationInputError &&
                              state.errors.containsKey(FieldType.firstname)
                          ? state.errors[FieldType.firstname]
                          : null,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: PrimaryTextField(
                      hintText: S.current.last_name_hint,
                      labelText: S.current.last_name,
                      controller: _lastNameController,
                      errorText: state is RegistrationInputError &&
                              state.errors.containsKey(FieldType.lastname)
                          ? state.errors[FieldType.lastname]
                          : null,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              PrimaryTextField(
                hintText: S.current.username_hint,
                labelText: S.current.username,
                controller: _usernameController,
                errorText:
                    state is RegistrationInputError && state.errors.containsKey(FieldType.username)
                        ? state.errors[FieldType.username]
                        : null,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 30),
              PrimaryTextField(
                hintText: S.current.date_of_birth_hint,
                labelText: S.current.date_of_birth,
                controller: _dateOfBirthController,
                errorText: state is RegistrationInputError &&
                        state.errors.containsKey(FieldType.dateOfBirth)
                    ? state.errors[FieldType.dateOfBirth]
                    : null,
                keyboardType: TextInputType.datetime,
                suffixIcon: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(24),
                  child: Icon(
                    Icons.cancel_outlined,
                    size: 24,
                    color: AppColors.grey.value.withOpacity(0.5),
                    shadows: [
                      BoxShadow(
                        color: AppColors.grey.value,
                        blurRadius: 36,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 17),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${S.current.first_agreement_row}\n',
                      style: widget.textTheme.regular15.copyWith(
                        fontFamily: 'Karla',
                        color: AppColors.whiteSmoke.value,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: '${S.current.i_agree_to} ',
                      style: widget.textTheme.regular15.copyWith(
                        fontFamily: 'Karla',
                        color: AppColors.whiteSmoke.value,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: '${S.current.terms_of_services} ',
                      style: widget.textTheme.regular15.copyWith(
                        fontFamily: 'Karla',
                        color: AppColors.pumpkin.value,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: '${S.current.and} ',
                      style: widget.textTheme.regular15.copyWith(
                        fontFamily: 'Karla',
                        color: AppColors.whiteSmoke.value,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: '${S.current.privacy_policy} ',
                      style: widget.textTheme.regular15.copyWith(
                        fontFamily: 'Karla',
                        color: AppColors.pumpkin.value,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 17),
              LayoutBuilder(
                builder: (context, constraints) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pumpkin.value,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 33),
                      maximumSize: Size(
                        constraints.maxWidth - 120,
                        constraints.maxHeight,
                      ),
                    ),
                    onPressed: _onAgreePressed,
                    child: Center(
                      child: Text(
                        S.current.agree_and_continue.toUpperCase(),
                        style: widget.textTheme.medium15.copyWith(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteSmoke.value,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onAgreePressed() {
    context.read<RegistrationBloc>().add(
          RegistrationAgreeEvent(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            username: _usernameController.text,
            dateOfBirth: _dateOfBirthController.text,
          ),
        );
  }
}
