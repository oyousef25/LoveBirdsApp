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
  /// Grey subtitle
  static const Color subtitleColor = Color(0xFF525252);
  ///form field gray
  static const Color formfieldColor = Color(0xFFCECECE);

  /// Spouse Color Codes
  static const Color pinkSpouse = Color(0xFFFFADAD);
  static const Color blueSpouse = Color(0xFF92DFD8);

  /// Button red
  static const Color buttonRed = Color(0xFFFF8585);
  /// Button green
  static const Color buttonGreen = Color(0xFF95E28E);

  /// Material color
  static Map<int, Color> materialSwatchMap = {
    50: Color.fromRGBO(darkSecondary.red, darkSecondary.green, darkSecondary.blue, 0.05),
    100: Color.fromRGBO(darkSecondary.red, darkSecondary.green, darkSecondary.blue, 0.1),
    200: Color.fromRGBO(darkSecondary.red, darkSecondary.green, darkSecondary.blue, 0.2),
    300: Color.fromRGBO(darkSecondary.red, darkSecondary.green, darkSecondary.blue, 0.3),
    400: Color.fromRGBO(darkSecondary.red, darkSecondary.green, darkSecondary.blue, 0.4),
    500: Color.fromRGBO(darkSecondary.red, darkSecondary.green, darkSecondary.blue, 0.5),
    600: Color.fromRGBO(darkSecondary.red, darkSecondary.green, darkSecondary.blue, 0.6),
    700: Color.fromRGBO(darkSecondary.red, darkSecondary.green, darkSecondary.blue, 0.7),
    800: Color.fromRGBO(darkSecondary.red, darkSecondary.green, darkSecondary.blue, 0.8),
    900: Color.fromRGBO(darkSecondary.red, darkSecondary.green, darkSecondary.blue, 0.9),
  };
  static MaterialColor appMaterialSwatch = MaterialColor(darkSecondary.value, materialSwatchMap);

  // Styles
  /// AppBar title TextStyle
  static const appBarStyle = TextStyle(fontFamily: 'Roboto Slab', fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black);
  /// Card header TextStyle
  static const cardHeaderStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black);
  /// Card content TextStyle
  static const cardContentStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black,);
  static const cardContentStyle2 = TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey,);
  /// Card detail greyed TextStyle
  static const detailStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black);
  /// Card detail greyed TextStyle
  static const detailGreyedStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey);
  /// Dialog content TextStyle
  static const dialogContentStyle = TextStyle(fontSize: 23, fontWeight: FontWeight.normal, color: Colors.black);
  /// Chip selected TextStyle
  static const chipSelectedStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  /// Chip unselected TextStyle
  static const chipUnselectedStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkSecondary);
  /// List item title TextStyle
  static const listTitleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
  /// List item subtitle TextStyle
  static const listSubtitleStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: subtitleColor);
  /// Title TextStyle
  static const title = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
  /// Form label TextStyle
  static const formLabelStyle = TextStyle(fontSize: 23, fontWeight: FontWeight.normal, color: darkSecondary);
  /// Form hint TextStyle
  static const formHintStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black26);
  /// Form hint TextStyle
  static const formDropdownStyle = TextStyle(fontFamily: 'Roboto Slab', fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black);

  /// Tab label TextStyle
  static const tabLabelStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black);
  /// Big card title TextStyle
  static const bigListTitleStyle = TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black);
  /// Big card subtitle TextStyle
  static const bigListSubtitleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: subtitleColor);

  /// Homepage header TextStyle
  static const homeHeaderStyle = TextStyle(fontSize: 27, fontWeight: FontWeight.w700, color: Colors.white);
  /// Homepage subheader TextStyle
  static const homeSubheaderStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white,);

  ///Form task number style
  static const taskNumber = TextStyle(fontWeight: FontWeight.w500, fontSize: 23.0, color: Colors.black);


  /// Budget Expense TextStyle
  static const budgetExpense = TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.black);
  ///List item task price textStyle
  static const taskPrice = TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0, color: Colors.black);
  /// Button red TextStyle
  static const buttonRedStyle = TextStyle(fontFamily: 'Roboto', fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white);
  /// Button white TextStyle
  static const buttonWhiteStyle = TextStyle(fontFamily: 'Roboto', fontSize: 18, fontWeight: FontWeight.bold, color: buttonRed);
  /// Button green TextStyle

  //Form Field
  ///Form field TextStyle
  static const sectionHeading = TextStyle(fontFamily: 'Roboto Slab', fontSize: 18, color: darkSecondary);
  ///Border radius
  static const borderRadius = BorderRadius.all(Radius.circular(5));
  ///Padding
  static const formPadding = Padding(padding: EdgeInsets.only(top: 10));
  static const formPadding2 = Padding(padding: EdgeInsets.only(top: 5));
  static const sectionPadding = Padding(padding: EdgeInsets.only(top: 20));
  ///Elevation
  static const elevation = 3.0;
  ///Input Decoration
  static const floatingLabelBehaviour = FloatingLabelBehavior.never;
  ///Outline Input Border
  static const outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  //View Task
  ///Heading
  static const taskHeading = TextStyle(fontFamily: 'Roboto Slab', fontSize: 18, color: darkSecondary, fontWeight: FontWeight.w500);
  ///Padding
  static const taskPadding = Padding(padding: EdgeInsets.only(top: 30));

  // Explore vendor icon height
  static const exploreHeight = 90.0;
  static const exploreWidth = 150.0;
}