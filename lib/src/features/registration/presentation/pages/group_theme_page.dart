import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/application/common/widgets/primary_app_bar.dart';
import '../../../../core/application/common/widgets/primary_text_field.dart';
import '../../../../core/util/assets/colors/color_scheme.dart';
import '../../../../core/util/assets/colors/colors.dart';
import '../../../../core/util/assets/text/text_extention.dart';

class GroupThemePage extends StatefulWidget {
  const GroupThemePage({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  State<GroupThemePage> createState() => _GroupThemePageState();
}

class _GroupThemePageState extends State<GroupThemePage> {
  final options = <String>[
    S.current.entrepreneur,
    S.current.non_profit,
    S.current.teacher,
    S.current.filmmaker,
    S.current.content_creator,
    S.current.podcaster,
    S.current.nft_dao_blockchain,
    S.current.blogger,
    S.current.events,
    S.current.influencer,
    S.current.musician,
    S.current.gaming,
    S.current.other,
  ];
  final selectedOption = ValueNotifier<String?>(null);

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
                      text: S.current.tell_us_about_your_group,
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
              left: 60,
              right: 60,
              top: 7,
            ),
            sliver: ValueListenableBuilder<String?>(
              valueListenable: selectedOption,
              builder: (context, value, child) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: index == options.length - 1 ? 0 : 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _CheckBoxWidget(
                              onTap: () {
                                selectedOption.value = options[index];
                              },
                              selected: selectedOption.value == options[index],
                            ),
                            const SizedBox(width: 26),
                            Text(
                              options[index],
                              style: textTheme.medium15.copyWith(
                                color: AppColors.whiteSmoke.value,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Karla',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: options.length,
                  ),
                );
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(23),
            sliver: SliverToBoxAdapter(
              child: ValueListenableBuilder<String?>(
                valueListenable: selectedOption,
                builder: (context, value, child) {
                  if (value == S.current.other) {
                    return PrimaryTextField(
                      hintText: S.current.describe,
                      controller: TextEditingController(),
                      onSubmitted: (value) {
                        print('User submitted: $value');
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(23),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.pumpkin.value,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 33),
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
                  const SizedBox(width: 14),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueCharcoal.value,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                          side: BorderSide(
                            color: AppColors.whiteSmoke.value,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 33),
                      ),
                      onPressed: _onSkipPressed,
                      child: Center(
                        child: Text(
                          S.current.skip.toUpperCase(),
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

class _CheckBoxWidget extends StatelessWidget {
  const _CheckBoxWidget({
    super.key,
    required this.onTap,
    this.selected = false,
  });

  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            width: 2,
            color: AppColors.pumpkin.value,
          ),
        ),
        child: selected
            ? Icon(
                Icons.check,
                size: 20,
                color: AppColors.pumpkin.value,
              )
            : null,
      ),
    );
  }
}
