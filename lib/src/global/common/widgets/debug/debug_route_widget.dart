import 'package:flutter/material.dart';

import '../../../di/app_scope.dart';
import 'debug_overlay_widget.dart';

class DebugPanelRouteWidget extends StatelessWidget {
  const DebugPanelRouteWidget({
    required this.appScope,
    super.key,
    this.child,
  });

  final IAppScope appScope;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute<void>(
        builder: (_) => Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (_) {
                return DebugOverlayWidget(
                  scope: appScope,
                  child: child,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
