import 'package:flutter/material.dart';

class DifficultyInfo {
  static var _difficultyColors = <MaterialColor>[
  Colors.green,
  Colors.orange,
  Colors.red
  ];

  static String getColoredAssetKey(int level) {
    return 'assets/difficulty_icons/level$level.png';
  }

  static String getWhiteAssetKey(int level) {
    return 'assets/difficulty_icons/level${level}white.png';
  }

  static Color getDifficultyColor(int level) {
    return _difficultyColors[level - 1];
  }

}