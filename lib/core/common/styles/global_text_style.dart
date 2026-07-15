import 'package:flutter/material.dart';

TextStyle getTextStyle({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.w400,
  double lineHeight = 21.0,
  Color color = Colors.black,
  TextDecoration textDecoration = TextDecoration.none,
}) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: lineHeight > 0 ? lineHeight / fontSize : null,
    color: color,
    decoration: textDecoration,
  );
}
