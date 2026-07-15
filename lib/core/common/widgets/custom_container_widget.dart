import 'package:flutter/material.dart';

class CustomContainerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Color bgColor;
  final double borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Widget childWidget;
  const CustomContainerWidget({
    super.key,
    this.verticalPadding,
    this.horizontalPadding,
    required this.bgColor,
    required this.borderRadius,
    this.borderWidth,
    this.borderColor,
    required this.childWidget,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding ?? 10,
        horizontal: horizontalPadding ?? 10,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          width: borderWidth ?? 1,
          color: borderColor ?? Colors.transparent,
        ),
      ),
      child: childWidget,
    );
  }
}
