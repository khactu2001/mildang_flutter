import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mildang/configs/theme.config.dart';
import 'package:flutter_mildang/screens/signup-stack/widgets/custom_form_builder_tf.dart';
import 'package:flutter_mildang/utils/utilities.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  const ConfirmPasswordTextField({
    super.key,
    required this.name,
    required this.focusNode,
    required this.validator,
    // required this.onChanged,
  });

  final String name;
  final FocusNode focusNode;
  final String? Function(String?) validator;
  // final void Function(String?) onChanged;

  @override
  State<ConfirmPasswordTextField> createState() =>
      ConfirmPasswordTextFieldState();
}

class ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
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

    if (textFieldKey.currentState?.isValid == true &&
        textFieldKey.currentState?.value != null) {
      return Image.asset(
        'assets/icons/check.png',
      );
    }
    return Container();
  }

  String? confirmPWValidator(value) {
    if (value != textFieldKey.currentState?.value) {
      return 'Password mismatched';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
          validator: widget.validator,
          obscureText: !isShowPassword,
          key: textFieldKey,
          decoration: InputDecoration(
            hintText: '비밀번호를 다시 한 번 입력해 주세요.',
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
            '비밀번호와 같아요!',
            style: successTextField,
          ),
      ],
    );
  }
}
