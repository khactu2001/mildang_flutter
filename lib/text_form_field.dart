import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  bool isError = false;
  String errorMessage = "";
  bool isShowPassword = false;

  final tfController = TextEditingController();
  late FocusNode tfFocusNode;

  @override
  void initState() {
    super.initState();

    tfFocusNode = FocusNode();
    tfController.addListener(_handleTextField);
    tfFocusNode.addListener(_handleFocusTextField);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    tfController.removeListener(_handleTextField);
    tfController.dispose();

    tfFocusNode.removeListener(_handleFocusTextField);
    tfFocusNode.dispose();
    super.dispose();
  }

  bool isShowClearTextIcon = false;

  void _handleTextField() {
    if (tfFocusNode.hasFocus) {
      if (tfController.text.isEmpty) {
        setState(() {
          isShowClearTextIcon = false;
        });
      } else {
        setState(() {
          isShowClearTextIcon = true;
        });
      }
    } else {
      setState(() {
        isShowClearTextIcon = false;
      });
    }
  }

  void _handleFocusTextField() {
    if (!tfFocusNode.hasFocus) {
      setState(() {
        isShowClearTextIcon = false;
      });
    } else {
      if (tfController.text.isNotEmpty) {
        setState(() {
          isShowClearTextIcon = true;
        });
      }
    }
  }

  void onPressedShowPassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  void onClearText() {
    tfController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !isShowPassword,
      focusNode: tfFocusNode,
      controller: tfController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return value!.length < 8 ? 'not enough length' : null;
      },
      onTapOutside: (event) {
        tfFocusNode.unfocus();
      },
      style: const TextStyle(
        color: Color(0xff090A0B),
      ),
      decoration: InputDecoration(
        hintText: '비밀번호를 입력해주세요.',
        hintStyle: TextStyle(
          color: HexColor('#A3A5AE'),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#E1E2E5'),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isShowClearTextIcon == true
                ? IconButton(
                    onPressed: onClearText,
                    icon: Image.asset(
                      'assets/icons/clear.png',
                    ),
                  )
                : Container(),
            IconButton(
              onPressed: onPressedShowPassword,
              icon: isShowPassword
                  ? Image.asset('assets/icons/enabled_eye.png')
                  : Image.asset('assets/icons/disabled_eye.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

bool validateEmail(String email) {
  // Implement your validation logic here (e.g., check for a valid email format)
  // Return true if email is valid, false otherwise
  // Example validation logic:
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

class EmailInputColumn extends StatelessWidget {
  const EmailInputColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '휴대폰 번호',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff383B45),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 6),
          child: const TextField(
            style: TextStyle(
              color: Color(0xff090A0B),
            ),
            decoration: InputDecoration(
                hintText: '휴대폰 번호로 입력해주세요.',
                hintStyle: TextStyle(
                  color: Color(0xffA3A5AE),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffE1E2E5),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                )),
          ),
        ),
      ],
    );
  }
}

class PasswordInputColumn extends StatelessWidget {
  const PasswordInputColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          child: const Text(
            '비밀번호',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff383B45),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 6),
          child: const TextField(
            style: TextStyle(
              color: Color(0xff090A0B),
            ),
            decoration: InputDecoration(
              hintText: '비밀번호를 입력해주세요.',
              hintStyle: TextStyle(
                color: Color(0xffA3A5AE),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffE1E2E5),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
