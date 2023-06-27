import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../assets/colors/colors.dart';
import '../../../../assets/text/text_extention.dart';

class SuccessfulPage extends StatefulWidget {
  const SuccessfulPage({
    required this.onNext,
    super.key,
  });

  final VoidCallback onNext;

  @override
  State<SuccessfulPage> createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {
  final selectedOptionNotifier = ValueNotifier<bool?>(null);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 4,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Name\n',
                style: textTheme.bold30.copyWith(
                  fontFamily: 'Montserrat',
                  color: AppColors.whiteSmoke.value,
                ),
              ),
              TextSpan(
                text: S.current.you_all_set,
                style: textTheme.bold30.copyWith(
                  fontFamily: 'Montserrat',
                  color: AppColors.whiteSmoke.value,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 75),
        AppAssets.images.checkmark.image(),
        const SizedBox(height: 86),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '${S.current.welcome_to}\n',
                style: textTheme.bold30.copyWith(
                  fontFamily: 'Karle',
                  color: AppColors.whiteSmoke.value.withOpacity(0.5),
                ),
              ),
              TextSpan(
                text: '(Your group)',
                style: textTheme.medium15.copyWith(
                  fontFamily: 'Karle',
                  color: AppColors.whiteSmoke.value.withOpacity(0.5),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 34),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pumpkin.value,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 33),
            ),
            onPressed: _onContinuePressed,
            child: Center(
              child: Text(
                S.current.continue_title.toUpperCase(),
                style: textTheme.medium15.copyWith(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteSmoke.value,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onContinuePressed() {
    widget.onNext.call();
  }
}

class CustomRadioOption extends StatelessWidget {
  final ValueNotifier<bool?> groupValueNotifier;
  final bool value;
  final String label;

  const CustomRadioOption({
    required this.groupValueNotifier,
    required this.value,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return ValueListenableBuilder<bool?>(
      valueListenable: groupValueNotifier,
      builder: (context, groupValue, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: AppColors.grey.value,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: textTheme.medium15.copyWith(
                    color: AppColors.whiteSmoke.value,
                    fontFamily: 'Karla',
                  ),
                ),
              ),
              Radio<bool>(
                value: value,
                groupValue: groupValue,
                onChanged: (bool? newValue) {
                  groupValueNotifier.value = newValue;
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: AppColors.whiteSmoke.value,
              ),
            ],
          ),
        );
      },
    );
  }
}
