import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/screens/signup-stack/widgets/confirm_password_tf.dart';
import 'package:flutter_mildang/screens/signup-stack/widgets/custom_form_builder_tf.dart';
import 'package:flutter_mildang/screens/signup-stack/widgets/email_tf.dart';
import 'package:flutter_mildang/screens/signup-stack/widgets/nickname_tf.dart';
import 'package:flutter_mildang/screens/signup-stack/widgets/password_tf.dart';
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

  late FocusNode phoneFocusNode;
  late FocusNode pwFocusNode;
  late FocusNode confirmPWFocusNode;
  late FocusNode nicknameFocusNode;
  late FocusNode dobFocusNode;
  late FocusNode genderFocusNode;
  late FocusNode nickameFocusNode;
  late FocusNode emailFocusNode;

  bool isShowClearTextIcon = false;

  @override
  void initState() {
    super.initState();
    pwFocusNode = FocusNode();
    confirmPWFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    nicknameFocusNode = FocusNode();
    dobFocusNode = FocusNode();
    genderFocusNode = FocusNode();
    nickameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    pwFocusNode.dispose();
    confirmPWFocusNode.dispose();
    phoneFocusNode.dispose();
    nicknameFocusNode.dispose();
    dobFocusNode.dispose();
    genderFocusNode.dispose();
    nickameFocusNode.dispose();
    emailFocusNode.dispose();
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

  String? phoneValidator(phone) {
    if (phone.length < 10 || phone.length > 11) {
      return 'Phone number must contain 10 or 11 digits!';
    }
    return null;
  }

  void onClearPasswordText() {
    _formKey.currentState!.fields['password']?.reset();
    print('clearrrrrr----${_formKey.currentState?.fields['password']?.value}');
  }

  String? nicknameValidator(value) {
    if (value != null) {
      if (value.length > 10) {
        return 'Limit exceeded';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
              defaultPadding + 56 + 16 * 2,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomFormBuilderTF(
                              name: 'phone',
                              keyboardType: TextInputType.phone,
                              focusNode: phoneFocusNode,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Phone number is required'),
                                phoneValidator,
                              ]),
                              decoration: const InputDecoration(
                                hintText: '휴대폰 번호로 입력해주세요.',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Future<bool> checkApi(String phone) async {
                                return await Future.delayed(
                                    const Duration(seconds: 2), () {
                                  print('success');
                                  return phone.length % 2 == 0;
                                });
                              }

                              final phone =
                                  _formKey.currentState!.fields['phone']?.value;
                              if (phone == null) return;
                              final isExist = await checkApi(phone);
                              print('result $isExist');
                              if (isExist) {
                                _formKey.currentState?.fields['phone']!
                                    .invalidate('phone is existed');
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
                      PasswordTextField(
                        name: 'password',
                        focusNode: pwFocusNode,
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
                      ConfirmPasswordTextField(
                        name: 'confirmation',
                        focusNode: confirmPWFocusNode,
                        validator: nicknameValidator,
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
                  const SizedBox(
                    height: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      renderLabelTF('닉네임'),
                      const SizedBox(
                        height: 8,
                      ),
                      NicknameField(
                        name: 'nickname',
                        focusNode: nickameFocusNode,
                        // validator: nicknameValidator,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      renderLabelTF('이메일', isRequired: false),
                      const SizedBox(
                        height: 8,
                      ),
                      EmailField(
                        name: 'email',
                        focusNode: emailFocusNode,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    double width = MediaQuery.of(context).size.width;

    bool checkDisabledSubmitButton() {
      String? phone = _formKey.currentState?.fields['phone']?.value;
      String? password = _formKey.currentState?.fields['password']?.value;
      String? confirmation =
          _formKey.currentState?.fields['confirmation']?.value;
      String? dob = _formKey.currentState?.fields['dob']?.value;
      String? gender = _formKey.currentState?.fields['gender']?.value;
      if ([phone, password, confirmation, dob, gender]
          .any((element) => element == null || element.isEmpty)) {
        return true;
      }

      return false;
    }

    // final currentState = _formKey.currentState;

    return Scaffold(
      body: signupScreen,
      // floatingActionButton: phoneFocusNode.hasFocus ||
      //         pwFocusNode.hasFocus ||
      //         confirmPWFocusNode.hasFocus ||
      //         dobFocusNode.hasFocus ||
      //         genderFocusNode.hasFocus ||
      //         nickameFocusNode.hasFocus ||
      floatingActionButton: [
        phoneFocusNode,
        pwFocusNode,
        confirmPWFocusNode,
        dobFocusNode,
        genderFocusNode,
        nickameFocusNode,
        emailFocusNode,
      ].any((e) => e.hasFocus)
          ? null
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
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
