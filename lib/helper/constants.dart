import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  // Colours
  /// Light pink
  static const Color lightPrimary = Color(0xFFFFC9C9);
  /// Dark pink
  static const Color darkPrimary = Color(0xFFFF8585);
  /// Light teal
  static const Color lightSecondary = Color(0xFFB5ECE6);
  /// Dark teal
  static const Color darkSecondary = Color(0xFF61D2C6);
  /// Golden yellow
  static const Color highlight = Color(0xFFFFCF3E);

  // Styles
  /// Card header TextStyle
  static const cardHeaderStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black);
  /// Card content TextStyle
  static const cardContentStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black);
  /// Chip selected TextStyle
  static const chipSelectedStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  /// Chip unselected TextStyle
  static const chipUnselectedStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkSecondary);
}