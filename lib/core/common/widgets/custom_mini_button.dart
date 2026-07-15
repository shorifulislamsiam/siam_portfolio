import 'package:flutter/material.dart';
import 'package:siam_portfolio/core/common/styles/global_text_style.dart';

class CustomMiniButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final BoxBorder? buttonBorder;
  final double? borderRadius;
  final Color? textColor;
  const CustomMiniButton({
    super.key,
    required this.text,
    this.backgroundColor,
    this.buttonBorder,
    this.borderRadius,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        border: buttonBorder,
      ),
      child: Text(
        text, //"10 Weeks",
        style: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          lineHeight: 10,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
