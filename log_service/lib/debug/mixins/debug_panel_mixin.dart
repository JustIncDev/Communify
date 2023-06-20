part of 'debug_mixins.dart';

mixin DebugPanelMixin {
  late final OverlayEntry overlayEntry;
  late final OverlayState overlayState;

  ValueNotifier<bool> isOverlayVisible = ValueNotifier(false);

  void initDebugPanelOverlay(
    BuildContext context, {
    required VoidCallback shareLogsCallback,
    required VoidCallback openDebugServicesCallback,
  }) {
    overlayEntry = _initDebugOverlay(shareLogsCallback, openDebugServicesCallback);
    overlayState = Overlay.of(context);

    if (!kReleaseMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        overlayState.insert(overlayEntry);
        isOverlayVisible.value = true;
      });
    }
  }

  void showOverlay() {
    if (!isOverlayVisible.value) {
      overlayState.insert(overlayEntry);
      isOverlayVisible.value = true;
    }
  }

  void hideOverlay() {
    if (isOverlayVisible.value) {
      overlayEntry.remove();
      isOverlayVisible.value = false;
    }
  }

  OverlayEntry _initDebugOverlay(
    VoidCallback shareLogsCallback,
    VoidCallback openDebugServicesCallback,
  ) {
    return OverlayEntry(
      builder: (context) {
        final mediaQuery = MediaQuery.of(context);
        final viewHeight = mediaQuery.size.height - mediaQuery.viewInsets.bottom;
        const widgetHeight = DebugServiceButtonWidget.kHeight +
            DebugSendReportButtonWidget.kHeight +
            DebugCloseButtonWidget.kHeight;

        return Positioned(
          top: (viewHeight - widgetHeight) / 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!kDebugMode)
                DebugCloseButtonWidget(
                  onPressed: hideOverlay, // Hides the overlay when the close button is pressed
                ),
              const SizedBox(height: 4),
              DebugSendReportButtonWidget(
                onPressed: shareLogsCallback,
              ),
              const SizedBox(height: 4),
              DebugServiceButtonWidget(
                onPressed: () {
                  openDebugServicesCallback.call();
                  hideOverlay(); // Hides the overlay when the debug services button is pressed
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
