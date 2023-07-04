import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/application/common/widgets/primary_button.dart';
import '../../../core/application/navigation/router.dart';
import '../../../core/util/assets/colors/colors.dart';
import '../../../core/util/assets/text/text_extention.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home screen',
              style: textTheme.bold20.copyWith(
                color: AppColors.blueCharcoal.value,
              ),
            ),
            PrimaryButton(
              onPressed: _onSignOutPressed,
              child: Text(
                'Sign out',
                style: textTheme.bold20.copyWith(
                  color: AppColors.whiteSmoke.value,
                ),
              ),
            ),
            PrimaryButton(
              onPressed: _onDeleteAccountPressed,
              child: Text(
                'Delete account',
                style: textTheme.bold20.copyWith(
                  color: AppColors.whiteSmoke.value,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onSignOutPressed() {
    Supabase.instance.client.auth.signOut();
    AppRouter.instance().go('/login');
  }

  void _onDeleteAccountPressed() {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId != null) {
      Supabase.instance.client.auth.admin.deleteUser(userId);
      AppRouter.instance().go('/login');
    }
  }
}
