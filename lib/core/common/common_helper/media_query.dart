import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMediaQuery {
  AppMediaQuery._();

  static const double designWidth = 390;
  static const double designHeight = 844;

  // Example: SizedBox(height: 100.h, width: 100.w)
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double size(BuildContext context, double value) =>
      value * width(context) / designWidth;

  static double widthSize(BuildContext context, double value) =>
      value * width(context) / designWidth;

  static double heightSize(BuildContext context, double value) =>
      value * height(context) / designHeight;

  static double padding(BuildContext context, double value) =>
      size(context, value);

  static double radius(BuildContext context, double value) =>
      size(context, value);

  static double globalWidth(double value) {
    final context = Get.context;
    return context == null ? value : widthSize(context, value);
  }

  static double globalHeight(double value) {
    final context = Get.context;
    return context == null ? value : heightSize(context, value);
  }

  static double globalSize(double value) {
    final context = Get.context;
    return context == null ? value : size(context, value);
  }

  static double globalPadding(double value) => globalSize(value);

  static double globalRadius(double value) => globalSize(value);
}

extension AppMediaQueryExtension on BuildContext {
  double get screenWidth => AppMediaQuery.width(this);

  double get screenHeight => AppMediaQuery.height(this);

  double sp(double value) => AppMediaQuery.padding(this, value);

  double sr(double value) => AppMediaQuery.radius(this, value);

  double ss(double value) => AppMediaQuery.size(this, value);
}

extension AppSizeExtension on num {
  double get w => AppMediaQuery.globalWidth(toDouble());

  double get h => AppMediaQuery.globalHeight(toDouble());

  double get p => AppMediaQuery.globalPadding(toDouble());

  double get r => AppMediaQuery.globalRadius(toDouble());

  double get s => AppMediaQuery.globalSize(toDouble());
}
