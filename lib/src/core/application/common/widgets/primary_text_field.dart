import 'package:flutter/material.dart';

import '../../../util/assets/colors/colors.dart';
import '../../../util/assets/text/text_extention.dart';
import 'gradient/gradient_outline_input_border.dart';

class PrimaryTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final ValueChanged<String> onSubmitted;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final double? borderRadius;

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
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  late final TextEditingController _controller;
  final ValueNotifier<int> _currentLength = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    _controller.addListener(() {
      _currentLength.value = _controller.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 19),
            child: Text(
              widget.labelText!,
              style: textTheme.regular20.copyWith(
                color: AppColors.whiteSmoke.value,
                fontFamily: 'Karla',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        TextField(
          controller: _controller,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          onSubmitted: widget.onSubmitted,
          maxLength: widget.maxLength,
          style: textTheme.regular15.copyWith(
            color: AppColors.whiteSmoke.value,
            fontFamily: 'Karla',
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
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
            counterText: '',
            border: GradientInputBorder(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.gainsboro.value.withOpacity(0.5),
                  AppColors.darkSlate.value,
                ],
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 25),
              width: 1,
            ),
            suffixIcon: widget.suffixIcon,
          ),
          minLines: widget.minLines,
          maxLines: widget.maxLines,
        ),
        if (widget.maxLength != null)
          ValueListenableBuilder<int>(
            valueListenable: _currentLength,
            builder: (context, value, child) {
              return Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    '$value/${widget.maxLength} characters',
                    style: textTheme.regular15.copyWith(
                      color: AppColors.grape.value,
                      fontFamily: 'Karla',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
