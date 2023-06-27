import 'package:flutter/material.dart';

import '../../../assets/colors/color_scheme.dart';
import 'pages/choose_network_page.dart';
import 'pages/successful_page.dart';
import 'pages/email_wallet_connect_page.dart';
import 'pages/group_name_page.dart';
import 'pages/group_theme_page.dart';
import 'pages/profile_details_page.dart';
import 'pages/splash_login_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen();

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorScheme.of(context).primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          pageSnapping: true,
          children: [
            SplashLoginPage(onNext: _onNext),
            EmailWalletConnectPage(onNext: _onNext),
            ChooseNetworkPage(onNext: _onNext),
            ProfileDetailsPage(
              onNext: _onNext,
              onBack: _onPrevious,
            ),
            GroupThemePage(
              onNext: _onNext,
              onBack: _onPrevious,
            ),
            GroupNamePage(
              onNext: _onNext,
              onBack: _onPrevious,
            ),
            SuccessfulPage(
              onNext: _onNext,
            ),
          ],
        ),
      ),
    );
  }

  void _onNext() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _onPrevious() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
