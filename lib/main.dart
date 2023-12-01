import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mildang/api.dart';
import 'package:flutter_mildang/widgets/textfields/custom_textfield.dart';
import 'package:flutter_mildang/screens/edit_profile_screen.dart';
import 'package:flutter_mildang/screens/home_screen.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF248BB0),
  error: const Color(0xFFE01839),
  onSurface: const Color(0xFFC4C6CD),
);
Color textHeaderColor = HexColor('#383B45');
Color textLabelColor = HexColor('#090A0B');
Color textfieldDisabledBackgroundColor = HexColor('F1F2F3');
Color textfieldDisabledTextColor = HexColor('626576');
// const Color
// const Color textErrorColor = Color(0xFFE01839);
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
    )
    // disabledTextfieldColor: const TextStyle(
    //   color: textfieldDisabledTextColor,

    // ),
    );

void main() {
  runApp(
    MaterialApp.router(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        textTheme: textTheme,
        buttonTheme: const ButtonThemeData(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(8)),
            // ),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primary,
            foregroundColor: kColorScheme.onPrimary,
            //background color when button is disabled
            disabledBackgroundColor: kColorScheme.onSurface,
            //text when button is disabled
            disabledForegroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        // button
        inputDecorationTheme: const InputDecorationTheme().copyWith(
          hintStyle: const TextStyle(
            color: Color(0xffA3A5AE),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffE1E2E5),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          fillColor: textfieldDisabledBackgroundColor,
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
        ),
      ),
      routerConfig: GoRouter(
        initialLocation: '/login',
        routes: [
          GoRoute(
            name: 'home_screen',
            path: '/',
            builder: (context, state) {
              final userString = state.extra as String?;
              Map<String, dynamic> object =
                  userString != null ? jsonDecode(userString) : null;
              UserModel? user = UserModel.fromJson(object);
              return HomeScreen(
                user: user,
              );
            },
          ),
          GoRoute(
            name: 'edit_profile_screen',
            path: '/edit',
            builder: (context, state) {
              print("${state.extra}");
              final userString = state.extra as String?;
              Map<String, dynamic> object =
                  userString != null ? jsonDecode(userString) : null;
              UserModel? user = UserModel.fromJson(object);
              return EditProfileScreen(
                user: user,
              );
            },
          ),
          GoRoute(
            name: 'login_screen',
            path: '/login',
            builder: (context, state) => const LoginScreen(),
          ),
        ],
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  double defaultPadding = 20.0;

  bool isError = false;
  String errorMessage = "";
  bool isShowPassword = false;

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoggedIn = false;
  UserModel? user;

  late FocusNode passwordFocusNode;
  bool isShowClearTextIcon = false;

  @override
  void initState() {
    super.initState();

    passwordFocusNode = FocusNode();
    passwordController.addListener(_printLatestValue);
    passwordFocusNode.addListener(_checkPasswordFocus);

    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? userString = prefs.getString('user');
    if (userString == null || token == null) {
      return;
    }
    final Map<String, dynamic> userCheck = jsonDecode(userString);
    UserModel userLocal = UserModel.fromJson(userCheck);
    setState(() {
      isLoggedIn = true;
      user = userLocal;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneController.dispose();

    passwordController.removeListener(_printLatestValue);
    passwordController.dispose();

    passwordFocusNode.removeListener(_checkPasswordFocus);
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    if (passwordFocusNode.hasFocus) {
      if (passwordController.text.isEmpty) {
        setState(() {
          isShowClearTextIcon = false;
        });
      } else {
        String currentValue = passwordController.text;
        print("text $currentValue");
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

  void _checkPasswordFocus() {
    if (!passwordFocusNode.hasFocus) {
      setState(() {
        isShowClearTextIcon = false;
      });
    } else {
      if (passwordController.text.isNotEmpty) {
        setState(() {
          isShowClearTextIcon = true;
        });
      }
    }
  }

  void onSubmitLogin() async {
    // print(emailController.text);

    final String phone = phoneController.text;
    final String password = passwordController.text;
    Map<String, dynamic> postData = {
      'phone': phone,
      'password': password,
    };
    if (phone.length < 10 || password.length < 8) {
      setState(() {
        isError = true;
        errorMessage = 'Validation failed';
      });
      return;
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return const AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              Text("Authenticating..."),
            ],
          ),
        );
      },
    );
    login(postData).then((value) {
      // print('Data received: $value');
      setState(() {
        isError = false;
        isLoggedIn = true;
        user = value.data.user;
        // errorMessage = 'call api failed';
      });

      // Navigator.push(context, route)
    }).catchError((onError) {
      print('Data error: $onError');
      setState(() {
        isError = true;
        errorMessage = '아이디 또는 비밀번호를 확인하세요!';
      });
    }).whenComplete(() {
      Navigator.pop(context);
    });
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('token');
    setState(() {
      isLoggedIn = false;
      user = null;
    });
  }

  void onPressedShowPassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  void onClearText() {
    passwordController.clear();
  }

  // get status bar height

  @override
  Widget build(BuildContext context) {
    print('isLoggedIn: $isLoggedIn');
    print('user: ${user?.email}');
    double statusBarHeight = MediaQuery.of(context).padding.top;
    Widget loginScreen = Padding(
      padding: EdgeInsets.fromLTRB(
        defaultPadding,
        defaultPadding + statusBarHeight,
        defaultPadding,
        defaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 44,
              horizontal: 0,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 94,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ---email----
          Column(
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
                child: CustomTextField(
                  controller: phoneController,
                  // style: const TextStyle(
                  //   color: Color(0xff090A0B),
                  // ),
                  decoration: const InputDecoration(
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
          ),

          // ---password---
          Column(
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
                child: TextFormField(
                  obscureText: !isShowPassword,
                  focusNode: passwordFocusNode,
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    print('value: $value');
                    return value!.length < 8
                        ? 'Password must be at least 8 characters'
                        : null;
                  },
                  onTapOutside: (event) {
                    passwordFocusNode.unfocus();
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
                ),
              ),
            ],
          ),

          // ---error text---
          Container(
            margin: const EdgeInsets.only(top: 12),
            child: isError == true
                ? Text(
                    errorMessage != '' ? errorMessage : '아이디 또는 비밀번호를 확인하세요!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: HexColor('#A9122B'),
                    ),
                  )
                : null,
          ),
          Container(
            width: double.infinity,
            height: 56,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            margin: const EdgeInsets.only(top: 48),
            child: ElevatedButton(
              onPressed: onSubmitLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff248BB0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              child: const Text(
                '로그인',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
    if (isLoggedIn == true) {
      loginScreen = HomeScreen(
        user: user,
        // onPressLogout: logout,
      );
    }
    return MaterialApp(
      home: Scaffold(
        body: loginScreen,
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
