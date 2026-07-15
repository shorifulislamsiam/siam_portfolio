import 'package:flutter/material.dart';

/// Data model for a skill item.
class SkillModel {
  final String name;
  final double percentage; // 0.0 – 1.0
  final Color color;
  final String? iconPath;
  final String category;

  const SkillModel({
    required this.name,
    required this.percentage,
    required this.color,
    this.iconPath,
    required this.category,
  });
}
