part of 'debug_screens.dart';

typedef ProxyUpdateCallback = void Function(String newProxy);

class DebugPanelScreen extends StatefulWidget {
  const DebugPanelScreen({
    Key? key,
    Alice? alice,
    this.currentProxy,
    this.onCloseButtonPressed,
    this.proxyUpdateCallback,
  })  : _alice = alice,
        super(key: key);

  final Alice? _alice;
  final String? currentProxy;
  final VoidCallback? onCloseButtonPressed;
  final ProxyUpdateCallback? proxyUpdateCallback;

  @override
  State<DebugPanelScreen> createState() => _DebugPanelScreenState();
}

class _DebugPanelScreenState extends State<DebugPanelScreen> {
  late final TextEditingController _proxyTextController = TextEditingController();
  final _proxyValueNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    _proxyValueNotifier.value = widget.currentProxy ?? '';
  }

  @override
  void dispose() {
    _proxyTextController.dispose();
    _proxyValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Panel', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurpleAccent,
        leading: IconButton(
          onPressed: widget.onCloseButtonPressed,
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Enter Proxy',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _proxyTextController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Type your ip here',
                counterText: "",
              ),
            ),
            const SizedBox(height: 10.0),
            ValueListenableBuilder(
              valueListenable: _proxyValueNotifier,
              builder: (context, String value, _) => Text(
                'Current Proxy: $value',
                style: const TextStyle(color: Colors.deepPurpleAccent),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => _setProxy(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Set Proxy'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => _disableProxy(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Disable Proxy'),
            ),
            const SizedBox(height: 10.0),
            if (widget._alice != null)
              OutlinedButton(
                onPressed: () => widget._alice?.showInspector(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.deepPurpleAccent,
                  side: const BorderSide(color: Colors.deepPurpleAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Open Alice'),
              ),
          ],
        ),
      ),
    );
  }

  void _setProxy() {
    try {
      final proxy = _proxyTextController.text;
      if (proxy.isNotEmpty) {
        final customProxy = CustomProxy.fromString(proxy);
        widget.proxyUpdateCallback?.call(customProxy.toString());
        logger.logInfo(message: 'Proxy $proxy was enabled');
        _proxyTextController.text = '';
        _proxyValueNotifier.value = proxy;
      }
    } catch (e) {
      logger.logError(message: 'Failed to set proxy: $e', error: e);
    }
  }

  void _disableProxy() {
    try {
      final proxy = _proxyValueNotifier.value;
      if (proxy.isNotEmpty) {
        _proxyValueNotifier.value = '';
        widget.proxyUpdateCallback?.call('');
        logger.logInfo(message: 'Proxy $proxy was disabled');
      }
    } catch (e) {
      logger.logError(message: 'Failed to disable proxy: $e', error: e);
    }
  }
}
