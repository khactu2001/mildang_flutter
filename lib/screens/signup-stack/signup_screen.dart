import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/screens/signup-stack/widgets/custom_form_builder_tf.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  double defaultPadding = 20.0;

  bool isError = false;
  String errorMessage = "";
  bool isShowPassword = false;

  bool isLoggedIn = false;
  UserModel? user;

  late FocusNode emailFocusNode;
  late FocusNode pwFocusNode;
  late FocusNode confirmPWFocusNode;
  late FocusNode nicknameFocusNode;
  late FocusNode dobFocusNode;
  late FocusNode genderFocusNode;

  bool isShowClearTextIcon = false;

  @override
  void initState() {
    super.initState();
    pwFocusNode = FocusNode();
    confirmPWFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    nicknameFocusNode = FocusNode();
    dobFocusNode = FocusNode();
    genderFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    pwFocusNode.dispose();
    confirmPWFocusNode.dispose();
    emailFocusNode.dispose();
    nicknameFocusNode.dispose();
    dobFocusNode.dispose();
    genderFocusNode.dispose();
    super.dispose();
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

  // get status bar height
  final _formKey = GlobalKey<FormBuilderState>();

  Widget renderLabelTF(String text, {bool isRequired = true}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff383B45),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        if (isRequired)
          const Text(
            '*',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
          ),
      ],
    );
  }

  String? confirmPWValidator(value) {
    if (value != _formKey.currentState!.fields['password']?.value) {
      return 'Password mismatched';
    }
    return null;
  }

  String? nicknameValidator(value) {
    // if (value != _formKey.currentState!.fields['password']?.value) {
    //   return 'Password mismatched';
    // }
    if (value != null) {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // print('isLoggedIn: $isLoggedIn');
    // print('user: ${user?.email}');
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthRatioActualWithDesign = MediaQuery.of(context).size.width / 352;
    Widget signupScreen = GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside the text field
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              defaultPadding,
              defaultPadding + statusBarHeight,
              defaultPadding,
              defaultPadding,
            ),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      renderLabelTF('휴대폰 번호'),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomFormBuilderTF(
                              name: 'email',
                              focusNode: emailFocusNode,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Email is required'),
                                FormBuilderValidators.email(
                                    errorText: 'Please enter a valid email!'),
                              ]),
                              decoration: const InputDecoration(
                                  hintText: '휴대폰 번호로 입력해주세요.'),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Future<bool> checkApi(String email) async {
                                return await Future.delayed(
                                    const Duration(seconds: 2), () {
                                  print('success');
                                  return email.length % 2 == 0;
                                });
                              }

                              final email =
                                  _formKey.currentState!.fields['email']?.value;
                              if (email == null) return;
                              final isExist = await checkApi(email);
                              print('result $isExist');
                              if (isExist) {
                                _formKey.currentState?.fields['email']!
                                    .invalidate('Email is existed');
                              }
                            },
                            child: const Text('check'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      renderLabelTF('비밀번호'),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomFormBuilderTF(
                        name: 'password',
                        focusNode: pwFocusNode,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Password is required'),
                          FormBuilderValidators.minLength(8,
                              errorText:
                                  'Password must be at least 8 characters!'),
                        ]),
                        decoration: const InputDecoration(
                          hintText: '휴대폰 번호로 입력해주세요.',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      renderLabelTF('비밀번호 확인'),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomFormBuilderTF(
                        name: 'confirmation',
                        focusNode: confirmPWFocusNode,
                        validator: confirmPWValidator,
                        decoration: const InputDecoration(
                          hintText: '비밀번호를 다시 한 번 입력해 주세요.',
                          hintStyle: TextStyle(
                              backgroundColor: Colors.red, color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      renderLabelTF('생년월일/ 성별'),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 135 * widthRatioActualWithDesign,
                            child: CustomFormBuilderTF(
                              name: 'dob',
                              maxLength: 6,
                              focusNode: dobFocusNode,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              decoration: const InputDecoration(
                                  // hintText: '비밀번호를 다시 한 번 입력해 주세요.',
                                  ),
                            ),
                          ),
                          Container(
                            width: 16,
                            height: 1,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(border: Border.all()),
                          ),
                          SizedBox(
                            width: 56 * widthRatioActualWithDesign,
                            child: CustomFormBuilderTF(
                              maxLength: 1,
                              name: 'gender',
                              focusNode: genderFocusNode,
                              validator: FormBuilderValidators.required(
                                  errorText: 'Gender is required'),
                              decoration: const InputDecoration(
                                  // hintText: '비밀번호를 다시 한 번 입력해 주세요.',
                                  ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Row(
                            children: [
                              ...[1, 2, 3, 4, 5, 6]
                                  .map((e) => const Text(
                                        '*',
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ))
                                  .expand((element) => [
                                        element,
                                        const SizedBox(
                                          width: 4,
                                        ),
                                      ]),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  // const SizedBox(
                  //   height: 32,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    double width = MediaQuery.of(context).size.width;

    bool checkDisabledSubmitButton() {
      // if (_formKey.currentState?) {
      //   return false;
      // }
      // return true;
      return false;
    }

    return Scaffold(
      body: signupScreen,
      floatingActionButton: emailFocusNode.hasFocus ||
              pwFocusNode.hasFocus ||
              confirmPWFocusNode.hasFocus ||
              dobFocusNode.hasFocus ||
              genderFocusNode.hasFocus
          ? null
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // disabledBackgroundColor: ,
                  maximumSize: Size.fromWidth(width - defaultPadding * 2 + 8)),
              onPressed: checkDisabledSubmitButton()
                  ? null
                  : () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        debugPrint(_formKey.currentState!.value.toString());
                        print(_formKey.currentState!.value.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('successfully')),
                        );
                      } else {
                        print(
                          "----------validation failed-------------${_formKey.currentState!.errors}",
                        );
                        print(
                          "----------validation failed-------------${_formKey.currentState!.value}",
                        );
                      }
                    },
              child: const Text('다음'),
            ),
    );
  }
}
