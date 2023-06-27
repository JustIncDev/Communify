import 'package:flutter/material.dart';

import '../../../assets/colors/colors.dart';
import '../../../assets/text/text_extention.dart';
import 'gradient/gradient_outline_input_border.dart';

class PrimaryTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final ValueChanged<String> onSubmitted;
  final Widget? suffixIcon;

  const PrimaryTextField({
    required this.hintText,
    required this.onSubmitted,
    Key? key,
    this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 19),
            child: Text(
              labelText!,
              style: textTheme.regular20.copyWith(
                color: AppColors.whiteSmoke.value,
                fontFamily: 'Karla',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          style: textTheme.regular15.copyWith(
            color: AppColors.whiteSmoke.value,
            fontFamily: 'Karla',
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textTheme.regular15.copyWith(
              color: AppColors.grape.value,
              fontFamily: 'Karla',
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: AppColors.swamp.value,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 30,
            ),
            border: GradientInputBorder(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.gainsboro.value.withOpacity(0.5),
                  AppColors.darkSlate.value,
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              width: 1,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
