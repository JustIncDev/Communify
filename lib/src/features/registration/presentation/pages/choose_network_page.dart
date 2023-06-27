import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../assets/colors/colors.dart';
import '../../../../assets/text/text_extention.dart';
import '../../../../global/common/widgets/base_container.dart';

class ChooseNetworkPage extends StatelessWidget {
  const ChooseNetworkPage({
    required this.onNext,
    Key? key,
  }) : super(key: key);

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 9),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: S.current.choose_one,
                            style: textTheme.bold30.copyWith(
                              fontFamily: 'Montserrat',
                              color: AppColors.whiteSmoke.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _ChoosingWidget(
                          onPressed: onNext,
                          firstPart: S.current.start_a,
                          secondPart: S.current.communify,
                          thirdPart: S.current.group,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _ChoosingWidget(
                          onPressed: onNext,
                          firstPart: S.current.join_a,
                          secondPart: S.current.communify,
                          thirdPart: S.current.group,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChoosingWidget extends StatefulWidget {
  const _ChoosingWidget({
    required this.onPressed,
    required this.firstPart,
    required this.secondPart,
    required this.thirdPart,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String firstPart;
  final String secondPart;
  final String thirdPart;

  @override
  _ChoosingWidgetState createState() => _ChoosingWidgetState();
}

class _ChoosingWidgetState extends State<_ChoosingWidget> {
  final ValueNotifier<bool> _isPressed = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    final textChild = RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${widget.firstPart}\n',
            style: textTheme.regular20.copyWith(
              color: AppColors.whiteSmoke.value,
              fontWeight: FontWeight.w400,
              fontFamily: 'Karla',
            ),
          ),
          TextSpan(
            text: widget.secondPart,
            style: textTheme.bold20.copyWith(
              color: AppColors.pumpkin.value,
              fontFamily: 'Varyloop',
            ),
          ),
          TextSpan(
            text: '\n${widget.thirdPart.trimLeft()}',
            style: textTheme.regular20.copyWith(
              color: AppColors.whiteSmoke.value,
              fontWeight: FontWeight.w400,
              fontFamily: 'Karla',
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTapDown: (details) {
        _isPressed.value = true;
      },
      onTapCancel: () {
        _isPressed.value = false;
      },
      onTap: () {
        _isPressed.value = false;
        widget.onPressed();
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _isPressed,
        builder: (context, isPressed, child) {
          return BaseContainerWidget(
            padding: const EdgeInsets.symmetric(
              vertical: 33,
              horizontal: 36,
            ),
            boxShadow: isPressed
                ? const [
                    BoxShadow(
                      color: Color(0xFFFFFFFF),
                      blurRadius: 0.95,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Color(0xFFFFFFFF),
                      blurRadius: 1.91,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Color(0xFFFFFFFF),
                      blurRadius: 6.68,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Color(0xFFFFFFFF),
                      blurRadius: 22.90,
                      spreadRadius: 0,
                    )
                  ]
                : null,
            contentGradientColors: isPressed
                ? [
                    AppColors.blueCharcoal.value,
                    AppColors.blueCharcoal.value,
                    AppColors.pumpkin.value,
                  ]
                : [
                    AppColors.blueCharcoal.value,
                    AppColors.blueCharcoal.value,
                    AppColors.grey.value,
                  ],
            contentGradientStops: const [0.0, 0.65, 1.0],
            borderGradientColors: isPressed
                ? [Colors.blue, Colors.blueAccent]
                : [AppColors.suvaGrey.value, AppColors.pumpkin.value],
            child: textChild,
          );
        },
      ),
    );
  }
}
