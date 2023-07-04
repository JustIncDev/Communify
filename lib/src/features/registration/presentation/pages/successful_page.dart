import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/application/navigation/router.dart';
import '../../../../core/util/assets/colors/colors.dart';
import '../../../../core/util/assets/text/text_extention.dart';

class SuccessfulPage extends StatefulWidget {
  const SuccessfulPage({
    this.groupName,
    super.key,
  });

  final String? groupName;

  @override
  State<SuccessfulPage> createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {
  final selectedOptionNotifier = ValueNotifier<bool?>(null);

  late final RiveAnimationController _controller = SimpleAnimation('Success');
  final ValueNotifier<Artboard?> artboardNotifier = ValueNotifier<Artboard?>(null);

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    final data = await rootBundle.load(AppAssets.animations.successCheck.path);
    final riveFile = RiveFile.import(data);
    artboardNotifier.value = riveFile.mainArtboard;
    artboardNotifier.value?.addController(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
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
          ValueListenableBuilder<Artboard?>(
            valueListenable: artboardNotifier,
            builder: (context, artboard, child) {
              if (artboard != null) {
                return SizedBox(
                  width: 150,
                  height: 150,
                  child: Rive(
                    artboard: artboard,
                    fit: BoxFit.contain,
                  ),
                );
              } else {
                return const CircularProgressIndicator(); // Display loading indicator while artboard is null
              }
            },
          ),
          const SizedBox(height: 86),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.groupName != null ? '${S.current.welcome_to}\n' : S.current.welcome,
                  style: textTheme.bold30.copyWith(
                    fontFamily: 'Karle',
                    color: AppColors.whiteSmoke.value.withOpacity(0.5),
                  ),
                ),
                if (widget.groupName != null)
                  TextSpan(
                    text: widget.groupName,
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
      ),
    );
  }

  void _onContinuePressed() {
    AppRouter.instance().go('sign-up/complete-profile/first');
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
