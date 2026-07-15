import 'package:flutter/material.dart';

/// Data model for an achievement entry.
class AchievementModel {
  final String title;
  final String description;
  final String year;
  final IconData icon;

  const AchievementModel({
    required this.title,
    required this.description,
    required this.year,
    required this.icon,
  });
}
