import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';

import '../../../core/application/common/widgets/base_container.dart';
import '../../../core/application/common/widgets/primary_text_field.dart';
import '../../../core/util/assets/colors/colors.dart';
import '../../../core/util/assets/text/text_extention.dart';
import 'widgets/social_button_widget.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    GreetingWidget(),
                    const SizedBox(height: 9),
                    const _SocialComponent(),
                    const SizedBox(height: 9),
                    _WalletComponent(),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GreetingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();
    return Container(
      margin: const EdgeInsets.only(left: 42),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          children: [
            TextSpan(
              text: S.current.hi,
              style: textTheme.bold30.copyWith(
                fontFamily: 'Montserrat',
                color: AppColors.whiteSmoke.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialComponent extends StatelessWidget {
  const _SocialComponent();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return BaseContainerWidget(
      padding: const EdgeInsets.only(
        left: 42,
        right: 42,
        top: 21,
        bottom: 13,
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
          PrimaryTextField(
            hintText: S.current.email,
            controller: TextEditingController(),
            onSubmitted: (value) {
              print("User submitted: $value");
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onContinuePressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueCharcoal.value,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(
                    color: AppColors.pumpkin.value.withOpacity(0.5),
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                S.current.continue_title.toUpperCase(),
                style: textTheme.medium15.copyWith(
                  color: AppColors.whiteSmoke.value,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            S.current.or,
            style: textTheme.regular15.copyWith(
              color: AppColors.suvaGrey.value.withOpacity(0.5),
              fontFamily: 'Karla',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SocialButtonWidget(
                type: SocialNetworkType.apple,
                onPressed: () {},
              ),
              SocialButtonWidget(
                type: SocialNetworkType.google,
                onPressed: () {},
              ),
              SocialButtonWidget(
                type: SocialNetworkType.twitter,
                onPressed: () {},
              ),
              SocialButtonWidget(
                type: SocialNetworkType.discord,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onContinuePressed() {}
}

class _WalletComponent extends StatefulWidget {
  @override
  State<_WalletComponent> createState() => _WalletComponentState();
}

class _WalletComponentState extends State<_WalletComponent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    final initialContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            S.current.external_wallet,
            style: textTheme.regular15.copyWith(
              fontFamily: 'Karla',
              fontWeight: FontWeight.w400,
              color: AppColors.whiteSmoke.value,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.black.value,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          onPressed: () {
            setState(() {
              _isExpanded = true;
            });
          },
          child: Center(
            child: Text(
              S.current.select_wallet.toUpperCase(),
              style: textTheme.medium15.copyWith(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                color: AppColors.whiteSmoke.value,
              ),
            ),
          ),
        ),
      ],
    );

    final expandedContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            S.current.select_wallet.toUpperCase(),
            style: textTheme.medium15.copyWith(
              color: AppColors.whiteSmoke.value,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        const SizedBox(
          height: 36,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pumpkin.value.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25), // set border radius here
                side: BorderSide(
                  color: AppColors.pumpkin.value.withOpacity(0.5),
                  width: 2,
                ), // set side color and thickness here
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppAssets.images.metamask.image(),
                const SizedBox(width: 10),
                Text(
                  S.current.metamask,
                  style: textTheme.medium15.copyWith(
                    color: AppColors.whiteSmoke.value,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.summerSky.value.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25), // set border radius here
                side: BorderSide(
                  color: AppColors.summerSky.value.withOpacity(0.5),
                  width: 2,
                ), // set side color and thickness here
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppAssets.images.walletConnect.image(),
                const SizedBox(width: 10),
                Text(
                  S.current.wallet_connect,
                  style: textTheme.medium15.copyWith(
                    color: AppColors.whiteSmoke.value,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    return BaseContainerWidget(
      padding: const EdgeInsets.only(
        left: 42,
        right: 42,
        top: 21,
        bottom: 24,
      ),
      contentGradientColors: [
        AppColors.blueCharcoal.value.withOpacity(0.35),
        AppColors.blueCharcoal.value.withOpacity(0.35),
        AppColors.gainsboro.value.withOpacity(0),
      ],
      contentGradientStops: const [0.0, 0.65, 1.0],
      borderGradientColors: [AppColors.suvaGrey.value, AppColors.pumpkin.value],
      child: AnimatedCrossFade(
        firstChild: initialContent,
        secondChild: expandedContent,
        crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }
}
