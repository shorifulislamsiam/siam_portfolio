import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siam_portfolio/app/app/siam_portfolio_app.dart';
import 'package:siam_portfolio/core/controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Register ThemeController before runApp so SiamPortfolioApp can read it
  Get.put(ThemeController(), permanent: true);
  runApp(const SiamPortfolioApp());
}
