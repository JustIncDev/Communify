import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';

import '../../../core/application/common/widgets/base_container.dart';
import '../../../core/application/common/widgets/primary_text_field.dart';
import '../../../core/application/navigation/router.dart';
import '../../../core/util/assets/colors/colors.dart';
import '../../../core/util/assets/text/text_extention.dart';
import '../../../core/util/enum.dart';
import '../application/connect_bloc.dart';
import 'widgets/social_button_widget.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectBloc, ConnectState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Stack(
            alignment: Alignment.center,
            children: [
              if (state is ConnectLoading)
                CircularProgressIndicator(
                  color: AppColors.pumpkin.value,
                  backgroundColor: AppColors.grape.value,
                ),
              CustomScrollView(
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
            ],
          ),
        );
      },
    );
  }
}

class GreetingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme =
        Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();
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

class _SocialComponent extends StatefulWidget {
  const _SocialComponent();

  @override
  State<_SocialComponent> createState() => _SocialComponentState();
}

class _SocialComponentState extends State<_SocialComponent> {
  final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();

  ValueNotifier<bool> showPasswordField = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final textTheme =
        Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return BlocConsumer<ConnectBloc, ConnectState>(
      listener: (context, state) {
        if (state is ConnectLoginSuccess) {
          AppRouter.instance().go('/home');
        } else if (state is ConnectRegistrationSuccess) {
          AppRouter.instance().go('/sign-up/choose-network');
        } else if (state is ConnectFailure) {
          showCustomSnackBar(context, state.message);
        } else if (state is ConnectEmailLoginFailure) {
          showPasswordField.value = true;
        }
      },
      builder: (context, state) {
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
          borderGradientColors: [
            AppColors.suvaGrey.value,
            AppColors.pumpkin.value
          ],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryTextField(
                hintText: S.current.email,
                controller: _emailController,
                errorText: state is ConnectInputError &&
                        state.errors.containsKey(FieldType.email)
                    ? state.errors[FieldType.email]
                    : null,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder(
                valueListenable: showPasswordField,
                builder: (context, value, child) {
                  return AnimatedOpacity(
                    opacity: value ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: PrimaryTextField(
                        hintText: S.current.password,
                        controller: _passwordController,
                        errorText: state is ConnectInputError &&
                                state.errors.containsKey(FieldType.password)
                            ? state.errors[FieldType.password]
                            : null,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      state is ConnectLoading ? null : _onContinuePressed,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SocialButtonWidget(
                  //   type: SocialNetworkType.apple,
                  //   onPressed: () {},
                  // ),
                  // SocialButtonWidget(
                  //   type: SocialNetworkType.google,
                  //   onPressed: () {},
                  // ),
                  SocialButtonWidget(
                    type: SocialNetworkType.twitter,
                    onPressed: _onTwitterPressed,
                  ),
                  SocialButtonWidget(
                    type: SocialNetworkType.discord,
                    onPressed: _onDiscordPressed,
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
    context.read<ConnectBloc>().add(
          ConnectEmailEvent(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  void _onTwitterPressed() {
    context.read<ConnectBloc>().add(
          ConnectSocialNetworkEvent(
            SocialProviders.twitter,
          ),
        );
  }

  void _onDiscordPressed() {
    context.read<ConnectBloc>().add(
          ConnectSocialNetworkEvent(
            SocialProviders.discord,
          ),
        );
  }

  void showCustomSnackBar(BuildContext context, String message) {
    final textTheme =
        Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 23,
        right: 23,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF3A3E41),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            message,
            style: textTheme.regular15.copyWith(
              color: AppColors.whiteSmoke.value,
              fontFamily: 'Karla',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
    overlayState.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), overlayEntry.remove);
  }
}

class _WalletComponent extends StatefulWidget {
  @override
  State<_WalletComponent> createState() => _WalletComponentState();
}

class _WalletComponentState extends State<_WalletComponent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme =
        Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

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
                borderRadius:
                    BorderRadius.circular(25), // set border radius here
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
                borderRadius:
                    BorderRadius.circular(25), // set border radius here
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
        crossFadeState:
            _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }
}
