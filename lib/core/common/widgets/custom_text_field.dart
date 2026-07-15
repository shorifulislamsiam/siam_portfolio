import 'package:flutter/material.dart';
import 'package:siam_portfolio/core/common/styles/global_text_style.dart';

class CustomTextField extends StatelessWidget {
  final String? fieldTitle;
  final Color? fieldTitleColor;
  final double? fieldFontSize;
  final double? fieldHeight;
  //this for hint text
  final String hintText;
  final double? hintLineHeight;
  final double? hintFontSize;
  final Color? hintFontColor;
  final TextEditingController? textEditingController;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final double? enableBorderRadius;
  final int? maxLine;
  final Color? fillColor;
  final bool? isFilled;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTapFunction;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  //this for text when want to go writing
  final Color? textColor;
  final double? textFontSize;
  final double? cursorHeight;
  final Color? cursorColor;
  final Color? borderSideColor;
  final Color? focusBorderSideColor;
  final Color? enableBorderSideColor;
  final double? enableBorderWidth;
  const CustomTextField({
    super.key,
    this.fieldTitle,
    this.fieldFontSize,
    this.fieldHeight,
    required this.hintText,
    this.hintLineHeight,
    this.textEditingController,
    this.contentPaddingHorizontal,
    this.contentPaddingVertical,
    this.enableBorderRadius,
    this.maxLine,
    this.fieldTitleColor,
    this.hintFontSize,
    this.hintFontColor,
    this.fillColor,
    this.isFilled,
    this.readOnly,
    this.suffixIcon,
    this.prefixIcon,
    this.onTapFunction,
    this.keyboardType,
    this.textInputAction,
    this.obscureText,
    this.textColor,
    this.textFontSize,
    this.cursorHeight,
    this.cursorColor,
    this.borderSideColor,
    this.focusBorderSideColor,
    this.enableBorderSideColor,
    this.enableBorderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fieldTitle != null && fieldTitle!.isNotEmpty) ...[
          Text(
            fieldTitle!,
            style: getTextStyle(
              fontSize: fieldFontSize ?? 14,
              fontWeight: FontWeight.w500,
              color: fieldTitleColor ?? const Color(0XFF475569),
              lineHeight: 8,
            ),
          ),
        ],

        SizedBox(
          height: fieldHeight ?? 40,
          child: TextFormField(
            cursorColor: cursorColor,
            cursorHeight: cursorHeight ?? 20,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscureText ?? false,
            onTap: onTapFunction,
            readOnly: readOnly ?? false,
            maxLines: maxLine,
            controller: textEditingController,
            style: getTextStyle(
              fontSize: textFontSize ?? 14,
              fontWeight: FontWeight.w500,
              color: textColor ?? const Color(0XFFFFFFFF),
            ),
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              fillColor: fillColor ?? Colors.transparent,
              filled: isFilled,
              contentPadding: EdgeInsets.symmetric(
                horizontal: contentPaddingHorizontal ?? 5,
                vertical: contentPaddingVertical ?? 5,
              ),
              hintText: hintText,
              hintStyle: getTextStyle(
                fontSize: hintFontSize ?? 14,
                fontWeight: FontWeight.w500,
                color: hintFontColor ?? const Color(0XFF94A3B8),
                lineHeight: hintLineHeight ?? 20,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: borderSideColor ?? const Color(0XFFCBD5E1),
                ),
                //borderRadius: BorderRadius.all(Radius.zero),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: focusBorderSideColor ?? const Color(0XFFCBD5E1),
                ),
                //borderRadius: BorderRadius.all(Radius.zero),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: enableBorderWidth ?? 1,
                  color: enableBorderSideColor ?? const Color(0XFFCBD5E1),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(enableBorderRadius ?? 4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
