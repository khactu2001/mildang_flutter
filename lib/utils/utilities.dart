import 'dart:convert';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LocalKeyCustom {
  user,
  token,
}

void printObject(Object object) {
  // Map<String, dynamic> personMap = object.toMap();

  // personMap.forEach((key, value) {
  //   print('$key: $value');
  // });
}
bool validateEmail(String email) {
  // Implement your validation logic here (e.g., check for a valid email format)
  // Return true if email is valid, false otherwise
  // Example validation logic:
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Future<Map<String, dynamic>?> getLocalVariable(LocalKeyCustom key) async {
  print('key: $key');
  final prefs = await SharedPreferences.getInstance();
  String? localString = prefs.getString(key.toString());
  if (localString == null) return null;

  return jsonDecode(localString);
}

Future<bool> setLocalVariable(LocalKeyCustom key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  bool? isSet = await prefs.setString(key.toString(), value);
  return isSet;
}

String convertStringToFormattedDateTime(String utcString,
    {String format = 'ddMMyy'}) {
  if (utcString.isEmpty) return '';
  DateTime datetime = DateTime.parse(utcString);
  String datetimeString = DateFormat(format).format(datetime);
  return datetimeString;
}

Future<bool> removeLocalVariable(LocalKeyCustom key) async {
  final prefs = await SharedPreferences.getInstance();
  bool? isRemoved = await prefs.remove(key.toString());
  return isRemoved;
}
