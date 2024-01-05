import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mildang/configs/theme.config.dart';
import 'package:flutter_mildang/screens/signup-stack/widgets/custom_form_builder_tf.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {super.key, required this.name, required this.focusNode});

  final String name;
  final FocusNode focusNode;

  @override
  State<PasswordTextField> createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  bool isShowPassword = false;
  bool isFocusing = false;
  String? text;
  final textFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onClearPasswordText() {
    textFieldKey.currentState?.didChange(null);
    setState(() {
      text = null;
    });
  }

  void onPressedShowPassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  Widget showClearOrCheckIcon() {
    if (widget.focusNode.hasFocus) {
      return text != null && text!.isNotEmpty
          ? IconButton(
              onPressed: onClearPasswordText,
              icon: Image.asset(
                'assets/icons/clear.png',
              ),
            )
          : Container();
    }

    if (textFieldKey.currentState?.isValid == true) {
      return Image.asset(
        'assets/icons/check.png',
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // print('isValid ${textFieldKey.currentState?.isValid}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFormBuilderTF(
          onChangeText: (p0) {
            setState(() {
              text = p0;
            });
          },
          name: widget.name,
          focusNode: widget.focusNode,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Password is required'),
            FormBuilderValidators.minLength(8,
                errorText: 'Password must be at least 8 characters!'),
          ]),
          obscureText: !isShowPassword,
          key: textFieldKey,
          decoration: InputDecoration(
            hintText: '휴대폰 번호로 입력해주세요.',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                showClearOrCheckIcon(),
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
        if (textFieldKey.currentState?.isValid == true &&
            textFieldKey.currentState?.value != null)
          Text(
            '사용 가능한 비밀번호예요!',
            style: successTextField,
          ),
      ],
    );
  }
}
