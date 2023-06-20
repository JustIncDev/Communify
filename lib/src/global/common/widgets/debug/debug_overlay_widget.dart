import 'package:flutter/material.dart';
import 'package:log_service/lib.dart';

import '../../../di/app_scope.dart';
import '../../../storage/config_storage/config_storage_impl.dart';

class DebugOverlayWidget extends StatefulWidget {
  const DebugOverlayWidget({
    required this.scope,
    this.child,
    Key? key,
  }) : super(key: key);

  final IAppScope scope;
  final Widget? child;

  @override
  State<DebugOverlayWidget> createState() => _DebugOverlayWidgetState();
}

class _DebugOverlayWidgetState extends State<DebugOverlayWidget>
    with DebugControllerMixin, DebugPanelMixin {
  @override
  void initState() {
    super.initState();

    final configStorage = ConfigSettingsStorageImpl();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initDebugPanelOverlay(
        context,
        shareLogsCallback: shareLogs,
        openDebugServicesCallback: () async => openDebugServices(
          context,
          alice: widget.scope.alice,
          currentProxy: await configStorage.getProxyUrl(),
          onCloseButtonPressed: () {
            Navigator.of(context).pop();
            showOverlay();
          },
          proxyUpdateCallback: (String newProxy) {
            configStorage.setProxyUrl(proxy: newProxy);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}
