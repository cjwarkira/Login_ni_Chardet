import 'package:flutter/material.dart';

class AppConstants {
  // Colors (Updated from Figma design)
  static const Color primaryColor = Color(0xFF0ACF83); // Keep the same green
  static const Color backgroundColor = Color(0xFF111110);
  static const Color textFieldColor = Color(0xFFD8D8DD); // Primary/Grey/2
  static const Color hintTextColor = Color(0xFFA09F99); // sth-lightgrey
  static const Color whiteColor = Color(0xFFFFFFFF); // Primary/Grey/6
  static const Color socialButtonColor = Color(0xFF484848); // sth-darkgrey
  static const Color blackOverlay = Color(0x1A000000);
  static const Color darkOverlay = Color(0x80000000);
  static const Color linkColor = Color(
    0xFF11C986,
  ); // Updated link color from design

  // Text Styles (Updated from Figma design)
  static const TextStyle titleTextStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: whiteColor,
    height: 1.0, // Normal line height
  );

  static const TextStyle labelTextStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: whiteColor,
    height: 1.3, // 21px / 16px
  );

  static const TextStyle inputTextStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: backgroundColor, // Dark text on light background
    letterSpacing: 0.16,
    height: 1.625, // 26px / 16px
  );

  static const TextStyle hintTextStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: hintTextColor,
    letterSpacing: 0.16,
    height: 1.625, // 26px / 16px
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textFieldColor,
    letterSpacing: 0.16,
    height: 1.625, // 26px / 16px (LEGO/Regular / Text)
  );

  static const TextStyle linkTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: linkColor,
    letterSpacing: 0.16,
    height: 1.625, // 26px / 16px
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: whiteColor,
    height: 1.5, // 27px / 18px
  );

  static const TextStyle dividerTextStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textFieldColor,
    height: 1.3, // 21px / 16px
  );

  // Spacing (Updated from Figma design)
  static const double defaultPadding = 39.0;
  static const double sectionSpacing = 15.0; // Reduced for tighter layout
  static const double elementSpacing = 15.0; // Gap between form elements
  static const double smallSpacing = 8.0;
  static const double formFieldSpacing =
      84.0; // Height of each form field container

  // Sizes (Updated from Figma design)
  static const double inputFieldHeight = 55.0;
  static const double buttonHeight = 55.0;
  static const double borderRadius = 8.0;
  static const double socialButtonSize = 55.0;

  // Box Shadows (From Figma design)
  static const List<BoxShadow> defaultBoxShadow = [
    BoxShadow(
      color: Color(0x08000000), // rgba(0,0,0,0.035)
      offset: Offset(0, 12.52),
      blurRadius: 10.02,
    ),
    BoxShadow(
      color: Color(0x06000000), // rgba(0,0,0,0.027)
      offset: Offset(0, 6.65),
      blurRadius: 5.32,
    ),
    BoxShadow(
      color: Color(0x05000000), // rgba(0,0,0,0.02)
      offset: Offset(0, 2.77),
      blurRadius: 2.21,
    ),
  ];
}
