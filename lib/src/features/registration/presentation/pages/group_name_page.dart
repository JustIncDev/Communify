import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../assets/colors/color_scheme.dart';
import '../../../../assets/colors/colors.dart';
import '../../../../assets/text/text_extention.dart';
import '../../../../global/common/widgets/primary_app_bar.dart';
import '../../../../global/common/widgets/primary_text_field.dart';

class GroupNamePage extends StatefulWidget {
  const GroupNamePage({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  State<GroupNamePage> createState() => _GroupNamePageState();
}

class _GroupNamePageState extends State<GroupNamePage> {
  final selectedOptionNotifier = ValueNotifier<bool?>(null);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    final appBar = PrimaryAppBar(
      leading: Center(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: widget.onBack,
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0x33D9D9D9),
              shape: BoxShape.circle,
            ),
            child: AppAssets.images.chevronLeft.image(),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColorScheme.of(context).primary,
      body: CustomScrollView(
        slivers: [
          appBar,
          SliverPadding(
            padding: const EdgeInsets.all(23),
            sliver: SliverToBoxAdapter(
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: S.current.choose_name_group,
                      style: textTheme.bold30.copyWith(
                        fontFamily: 'Montserrat',
                        color: AppColors.whiteSmoke.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              left: 23,
              right: 23,
              top: 100,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PrimaryTextField(
                    hintText: S.current.your_network,
                    controller: TextEditingController(),
                    onSubmitted: (value) {
                      print('User submitted: $value');
                    },
                  ),
                  const SizedBox(height: 14),
                  Text(
                    S.current.you_can_always_change,
                    style: textTheme.medium15.copyWith(
                      color: AppColors.whiteSmoke.value,
                      fontFamily: 'Karla',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 61, right: 61),
                  child: Column(
                    children: [
                      CustomRadioOption(
                        groupValueNotifier: selectedOptionNotifier,
                        value: true,
                        label: S.current.activate_push_notifications,
                      ),
                      CustomRadioOption(
                        groupValueNotifier: selectedOptionNotifier,
                        value: false,
                        label: S.current.decide_later,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 34),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
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
                const SizedBox(height: 34), // Add extra space at the bottom if needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onContinuePressed() {
    widget.onNext.call();
  }

  void _onSkipPressed() {}
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
