import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mildang/configs/theme.config.dart';
import 'package:flutter_mildang/screens/signup-stack/widgets/custom_form_builder_tf.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EmailField extends StatefulWidget {
  const EmailField({super.key, required this.name, required this.focusNode});

  final String name;
  final FocusNode focusNode;

  @override
  State<EmailField> createState() => EmailFieldState();
}

class EmailFieldState extends State<EmailField> {
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

  bool get isShowVerified {
    return textFieldKey.currentState?.isValid == true &&
        textFieldKey.currentState?.value != null &&
        textFieldKey.currentState?.value != "";
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

    if (isShowVerified) {
      return Image.asset(
        'assets/icons/check.png',
      );
    }
    return Container();
  }

  String? emailValidator(email) {
    if (email == null || email.isEmpty) return null;
    return FormBuilderValidators.email()(email);
  }

  @override
  Widget build(BuildContext context) {
    // print('isValid ${textFieldKey.currentState?.isValid}');
    // print('value ${textFieldKey.currentState?.value}');

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
          validator: emailValidator,
          key: textFieldKey,
          decoration: InputDecoration(
            hintText: '이메일을 입력해 주세요.',
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  showClearOrCheckIcon(),
                ],
              ),
            ),
          ),
        ),
        if (isShowVerified)
          Text(
            '올바른 이메일 형식이에요!',
            style: successTextField,
          ),
      ],
    );
  }
}
