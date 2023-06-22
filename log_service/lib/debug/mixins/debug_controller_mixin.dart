part of 'debug_mixins.dart';

mixin DebugControllerMixin {
  void openDebugServices(
    BuildContext context, {
    Alice? alice,
    String? currentProxy,
    VoidCallback? onCloseButtonPressed,
    ProxyUpdateCallback? proxyUpdateCallback,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DebugPanelScreen(
          alice: alice,
          currentProxy: currentProxy,
          onCloseButtonPressed: onCloseButtonPressed,
          proxyUpdateCallback: proxyUpdateCallback,
        ),
      ),
    );
  }

  Future<void> shareLogs() async {
    final logs = await FileLogService.getAllLogs('logs.txt');
    if (logs.isEmpty) {
      logger.logInfo(message: 'No logs to share.');
      return;
    }
    final logsAsString = logs.map(jsonEncode).join('\n');
    await Share.share(logsAsString, subject: 'App Logs');
  }
}
