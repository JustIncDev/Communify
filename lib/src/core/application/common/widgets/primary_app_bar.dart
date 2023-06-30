import 'package:flutter/material.dart';

import '../../../util/assets/colors/colors.dart';
import '../../../util/assets/text/text_extention.dart';

class PrimaryAppBar extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Function()? onLeadingPressed;
  final TextStyle? titleStyle;

  const PrimaryAppBar({
    this.title,
    Key? key,
    this.leading,
    this.actions,
    this.onLeadingPressed,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.blueCharcoal.value,
      title: title != null
          ? Text(
              title!,
              style: titleStyle ??
                  textTheme.regular15.copyWith(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Karla',
                    color: AppColors.whiteSmoke.value,
                  ),
            )
          : null,
      leading: leading != null
          ? Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: onLeadingPressed,
                child: leading,
              ),
            )
          : null,
      actions: actions,
    );
  }
}
