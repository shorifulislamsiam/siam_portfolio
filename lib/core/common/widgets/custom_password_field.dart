import 'package:flutter/material.dart';
import 'package:siam_portfolio/core/common/widgets/custom_text_field.dart';
import 'package:siam_portfolio/core/utils/constants/colors.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    super.key,
    required this.title,
    required this.textController,
    required this.textInputAction,
    this.fillColor,
    this.enableBorderWidth,
    this.enableBorderSideColor,
  });

  final String title;
  final TextEditingController textController;
  final TextInputAction textInputAction;
  final Color? fillColor;
  final double? enableBorderWidth;
  final Color? enableBorderSideColor;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      fieldTitle: widget.title,
      fieldTitleColor: AppColors.textGreyColorE7E8EB,
      hintText: '********',
      hintFontColor: AppColors.textGrey300Color80868B,
      textColor: AppColors.whiteColor,
      textEditingController: widget.textController,
      fieldHeight: 40,
      fillColor: widget.fillColor ?? AppColors.containerColor1A1A2E,
      isFilled: true,
      enableBorderWidth: widget.enableBorderWidth ?? 0.7,
      enableBorderRadius: 10,
      borderSideColor:
          widget.enableBorderSideColor ?? AppColors.textGreyColorB3B8C2,
      enableBorderSideColor: AppColors.textGreyColorB3B8C2,
      focusBorderSideColor: AppColors.textGreyColorB3B8C2,
      textInputAction: widget.textInputAction,
      maxLine: 1,
      obscureText: _isHidden,
      suffixIcon: IconButton(
        onPressed: () => setState(() => _isHidden = !_isHidden),
        icon: Icon(
          _isHidden
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.textGrey300Color80868B,
          size: 20,
        ),
      ),
    );
  }
}
