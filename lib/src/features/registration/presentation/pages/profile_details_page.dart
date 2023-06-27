import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../assets/colors/color_scheme.dart';
import '../../../../assets/colors/colors.dart';
import '../../../../assets/text/text_extention.dart';
import '../../../../global/common/widgets/base_container.dart';
import '../../../../global/common/widgets/primary_app_bar.dart';
import '../../../../global/common/widgets/primary_button.dart';
import '../../../../global/common/widgets/primary_text_field.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({
    required this.onNext,
    required this.onBack,
    Key? key,
  }) : super(key: key);

  final VoidCallback onNext;
  final VoidCallback onBack;

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
          onTap: widget.onBack,
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

    final body = SliverToBoxAdapter(
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
              onAgreePressed: widget.onNext,
            ),
            const SizedBox(height: 20),
          ],
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

  void _onLoginButtonPressed() {}
}

class _ProfileDetailsBodyWidget extends StatelessWidget {
  const _ProfileDetailsBodyWidget({
    super.key,
    required this.textTheme,
    required this.onAgreePressed,
  });

  final AppTextTheme textTheme;
  final VoidCallback onAgreePressed;

  @override
  Widget build(BuildContext context) {
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
                  controller: TextEditingController(),
                  onSubmitted: (value) {
                    print('User submitted: $value');
                  },
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: PrimaryTextField(
                  hintText: S.current.last_name_hint,
                  labelText: S.current.last_name,
                  controller: TextEditingController(),
                  onSubmitted: (value) {
                    print('User submitted: $value');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          PrimaryTextField(
            hintText: S.current.username_hint,
            labelText: S.current.username,
            controller: TextEditingController(),
            onSubmitted: (value) {
              print('User submitted: $value');
            },
          ),
          const SizedBox(height: 30),
          PrimaryTextField(
            hintText: S.current.date_of_birth_hint,
            labelText: S.current.date_of_birth,
            controller: TextEditingController(),
            onSubmitted: (value) {
              print('User submitted: $value');
            },
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
                  style: textTheme.regular15.copyWith(
                    fontFamily: 'Karla',
                    color: AppColors.whiteSmoke.value,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: '${S.current.i_agree_to} ',
                  style: textTheme.regular15.copyWith(
                    fontFamily: 'Karla',
                    color: AppColors.whiteSmoke.value,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: '${S.current.terms_of_services} ',
                  style: textTheme.regular15.copyWith(
                    fontFamily: 'Karla',
                    color: AppColors.pumpkin.value,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: '${S.current.and} ',
                  style: textTheme.regular15.copyWith(
                    fontFamily: 'Karla',
                    color: AppColors.whiteSmoke.value,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: '${S.current.privacy_policy} ',
                  style: textTheme.regular15.copyWith(
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
                onPressed: onAgreePressed,
                child: Center(
                  child: Text(
                    S.current.agree_and_continue.toUpperCase(),
                    style: textTheme.medium15.copyWith(
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
  }
}
