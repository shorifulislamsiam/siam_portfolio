import 'package:flutter/material.dart';
import 'package:siam_portfolio/core/common/styles/global_text_style.dart';
import 'package:siam_portfolio/core/utils/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final Color? imageColor;
  final double? topPadding;
  final double? bottomPadding;
  final double? leftPadding;
  final double? rightPadding;
  final BorderRadius? borderRadius;
  final Color? iconColor;
  final IconData? icon;
  final Color? borderColor;
  final String text;
  final String? iconImagePath;
  final Color? color1;
  final Color? color2;
  final Color? textColor;
  final VoidCallback onTap;
  final bool isLoading;
  final Widget? loadingWidget;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? iconSize;
  final double? buttonHeight;
  final double? buttonWidth;
  final Widget? prefixIcon;
  final double? lineHeight;

  const CustomButton({
    this.topPadding,
    this.bottomPadding,
    this.leftPadding,
    this.rightPadding,
    this.imageColor,
    this.borderRadius,
    this.iconColor,
    super.key,
    required this.text,
    required this.onTap,
    this.iconImagePath,
    this.color1,
    this.color2,
    this.textColor,
    this.fontSize,
    this.borderColor,
    this.icon,
    this.width,
    this.height,
    this.iconSize,
    this.buttonHeight,
    this.buttonWidth,
    this.prefixIcon,
    this.lineHeight,
    this.isLoading = false,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        // width: buttonWidth,
        // height: buttonHeight,
        padding: EdgeInsets.symmetric(
          horizontal: leftPadding ?? 8,
          vertical: topPadding ?? 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: borderRadius ?? BorderRadius.circular(6),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              color1 ?? AppColors.buttonColor1,
              color2 ?? AppColors.buttonColor1,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 18,
                height: 18,
                child: loadingWidget ??
                    CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        textColor ?? Colors.white,
                      ),
                    ),
              ),
            if (!isLoading && prefixIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: prefixIcon,
              ),
            if (!isLoading && iconImagePath != null)
              Image.asset(
                iconImagePath!,
                height: height,
                width: width,
                color: imageColor,
              ),
            if (!isLoading && iconImagePath != null) const SizedBox(width: 8),
            if (!isLoading)
              Text(
                text,
                style: getTextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize ?? 14,
                  color: textColor ?? Colors.white,
                  lineHeight: lineHeight ?? 20,
                ),
              ),
            if (!isLoading && icon != null)
              Row(
                children: [
                  const SizedBox(width: 8),
                  Icon(icon!, color: iconColor ?? Colors.white, size: iconSize),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
