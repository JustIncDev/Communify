import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../assets/colors/colors.dart';
import '../../../../assets/text/text_extention.dart';
import '../../../../global/common/widgets/gradient/gradient_box_border.dart';
import '../../../../global/common/widgets/gradient/gradient_outline_input_border.dart';
import '../widgets/social_button_widget.dart';

class EmailWalletConnectWidget extends StatelessWidget {
  const EmailWalletConnectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
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
                SocialWidget(),
                const SizedBox(height: 9),
                WalletWidget(),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ],
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

class SocialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return Container(
      padding: const EdgeInsets.only(
        left: 42,
        right: 42,
        top: 21,
        bottom: 13,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          transform: const GradientRotation(math.pi / 5),
          stops: const [0.0, 0.65, 1.0],
          colors: [
            AppColors.blueCharcoal.value.withOpacity(0.35),
            AppColors.blueCharcoal.value.withOpacity(0.35),
            AppColors.gainsboro.value.withOpacity(0),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [AppColors.suvaGrey.value, AppColors.pumpkin.value],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            style: textTheme.regular15.copyWith(
              color: AppColors.whiteSmoke.value,
              fontFamily: 'Karla',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: S.current.email,
              hintStyle: textTheme.regular15.copyWith(
                color: AppColors.grape.value,
                fontFamily: 'Karla',
              ),
              filled: true,
              fillColor: AppColors.swamp.value,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 30,
              ),
              border: GradientInputBorder(
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
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueCharcoal.value,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // set border radius here
                  side: BorderSide(
                    color: AppColors.pumpkin.value.withOpacity(0.5),
                    width: 2,
                  ), // set side color and thickness here
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
}

class WalletWidget extends StatefulWidget {
  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
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

    return Container(
      padding: const EdgeInsets.only(
        left: 42,
        right: 42,
        top: 21,
        bottom: 13,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          transform: const GradientRotation(math.pi / 5),
          stops: const [0.0, 0.65, 1.0],
          colors: [
            AppColors.blueCharcoal.value.withOpacity(0.35),
            AppColors.blueCharcoal.value.withOpacity(0.35),
            AppColors.gainsboro.value.withOpacity(0),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [AppColors.suvaGrey.value, AppColors.pumpkin.value],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          width: 1,
        ),
      ),
      child: AnimatedCrossFade(
        firstChild: initialContent,
        secondChild: expandedContent,
        crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }
}
