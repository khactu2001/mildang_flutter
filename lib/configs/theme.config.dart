import 'package:flutter/material.dart';
import 'package:flutter_mildang/utils/utilities.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF248BB0),
  // secondary: HexColor('00BCD4'),
  // secondary: Colors.amber,
  // secondaryContainer: Colors.amberAccent,
  error: const Color(0xFFE01839),
  onSurface: const Color(0xFFC4C6CD),
  // background: Colors.yellow,
  // onBackground: Colors.blue,
  // surface: Colors.blue,
);

Color textHeaderColor = HexColor('#383B45');
Color textLabelColor = HexColor('#090A0B');
Color textfieldDisabledBackgroundColor = HexColor('F1F2F3');
Color textfieldDisabledTextColor = HexColor('626576');
Color textWhite = Colors.white;
Color appBarColor = HexColor('00BCD4');
Color borderColor = HexColor('#A3A5AE');
Color itemSelectedColor = HexColor('#F0F7F9');
Color categoryUnselectedColor = HexColor('#F5F6F7');
Color categoryUnselectedBorderColor = HexColor('#E1E2E5');

TextTheme textTheme = ThemeData().textTheme.copyWith(
      titleLarge: TextStyle(
        color: textHeaderColor,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      titleMedium: TextStyle(
        color: textLabelColor,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: textfieldDisabledTextColor,
        fontSize: 24,
      ),
      bodySmall: const TextStyle(
        color: Color(0xFF090A0B),
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
    );
const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
