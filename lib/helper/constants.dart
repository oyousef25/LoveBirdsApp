import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  // Colours
  /// Light pink
  static const Color lightPrimary = Color(0xFFFFC9C9);
  /// Medium pink
  static const Color mediumPrimary = Color(0xffec8686);
  /// Dark pink
  static const Color darkPrimary = Color(0xFFFF8585);
  /// Light teal
  static const Color lightSecondary = Color(0xFFB5ECE6);
  /// Dark teal
  static const Color darkSecondary = Color(0xFF61D2C6);
  /// Golden yellow
  static const Color highlight = Color(0xFFFFCF3E);
  // Grey subtitle
  static const Color subtitleColor = Color(0xFF525252);

  // Styles
  /// AppBar title TextStyle
  static const appBarStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black);
  /// Card header TextStyle
  static const cardHeaderStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black);
  /// Card content TextStyle
  static const cardContentStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black);
  /// Card content greyed TextStyle
  static const detailStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black);
  /// Card content greyed TextStyle
  static const detailGreyedStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey);
  /// Chip selected TextStyle
  static const chipSelectedStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  /// Chip unselected TextStyle
  static const chipUnselectedStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkSecondary);
  /// List item title TextStyle
  static const listTitleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
  /// List item subtitle TextStyle
  static const listSubtitleStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: subtitleColor);
  ///Title TextStyle
  static const title = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
  ///Budget Expense TextStyle
  static const budgetExpense = TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Constants.darkSecondary);
}