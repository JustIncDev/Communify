part of 'debug_widgets.dart';

class DebugServiceButtonWidget extends StatelessWidget {
  static const kHeight = 100.0;

  final VoidCallback? onPressed;

  const DebugServiceButtonWidget({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: kHeight,
        width: 32,
        color: Colors.deepOrangeAccent,
        child: const Center(
          child: Icon(
            Icons.bug_report,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
