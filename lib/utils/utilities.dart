import 'dart:ui';

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
