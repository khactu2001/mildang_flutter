import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mildang/configs/theme.config.dart';
import 'package:flutter_mildang/screens/signup-stack/widgets/custom_form_builder_tf.dart';
import 'package:flutter_mildang/utils/utilities.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class NicknameField extends StatefulWidget {
  const NicknameField({super.key, required this.name, required this.focusNode});

  final String name;
  final FocusNode focusNode;

  @override
  State<NicknameField> createState() => NicknameFieldState();
}

class NicknameFieldState extends State<NicknameField> {
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
            int? length = p0?.length;
            if (length != null && length <= 10) {
              setState(() {
                text = p0;
              });
            }
          },
          maxLength: 10,
          name: widget.name,
          focusNode: widget.focusNode,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Nickname is required'),
          ]),
          obscureText: !isShowPassword,
          key: textFieldKey,
          decoration: InputDecoration(
            hintText: '닉네임을 입력해 주세요.',
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  showClearOrCheckIcon(),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${text?.length ?? 0}/10',
                    style: successTextField.copyWith(
                      color: HexColor('#626576'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (textFieldKey.currentState?.isValid == true &&
            textFieldKey.currentState?.value != null)
          Text(
            '사용할 수 있는 닉네임이에요!',
            style: successTextField,
          ),
      ],
    );
  }
}
