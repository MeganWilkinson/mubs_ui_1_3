import 'package:flutter/material.dart';

class CategoryInfo {

  CategoryInfo._();

  static List<String> myActivities = [
    "Movement",
    "Work & Edu",
    "Sparetime",
    "Daily living",
    "Practical",
    "Social",
    "Other"
  ];

  static List<Color> myActCols = [
    Color(0xFFAFCA0B),
    Color(0xFFF8D100),
    Color(0xFFEA5B0C),
    Color(0xFF52AE32),
    Color(0xFFD6007A),
    Color(0xFF35B6B4),
    Color(0xFF662483),
  ];

  static Color getColor(String activity) {
    switch (activity.toLowerCase()) {
      case 'movement':
        return myActCols[0];
      case 'work & edu':
        return myActCols[1];
      case 'sparetime':
        return myActCols[2];
      case 'daily living':
        return myActCols[3];
      case 'practical':
        return myActCols[4];
      case 'social':
        return myActCols[5];
      case 'other':
        return myActCols[6];
    }
  }

  static IconData getIconData(String activity) {
    switch (activity.toLowerCase()) {
      case 'movement':
        return IconData(0xf106, fontFamily: 'flaticon');
      case 'work & edu':
        return IconData(0xf105, fontFamily: 'flaticon');
      case 'sparetime':
        return IconData(0xf101, fontFamily: 'flaticon');
      case 'daily living':
        return IconData(0xf102, fontFamily: 'flaticon');
      case 'practical':
        return IconData(0xf100, fontFamily: 'flaticon');
      case 'social':
        return IconData(0xf104, fontFamily: 'flaticon');
      case 'other':
        return IconData(0xf103, fontFamily: 'flaticon');
    }
  }
}