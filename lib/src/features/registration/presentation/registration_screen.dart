import 'package:flutter/material.dart';

import '../../../assets/colors/color_scheme.dart';
import 'pages/email_wallet_connect_widget.dart';
import 'pages/splash_widget.dart';

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
            SplashWidget(
              onNext: () => _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: EmailWalletConnectWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
