part of 'debug_widgets.dart';

class DebugSendReportButtonWidget extends StatelessWidget {
  static const kHeight = 32.0;

  final VoidCallback? onPressed;

  const DebugSendReportButtonWidget({Key? key, this.onPressed}) : super(key: key);

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
            Icons.report_problem,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}