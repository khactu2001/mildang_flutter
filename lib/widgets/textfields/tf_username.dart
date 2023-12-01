import 'package:flutter/material.dart';

class TextfieldUsername extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? placeholder;

  const TextfieldUsername(
      {super.key, required this.textEditingController, this.placeholder});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      // maxLength: 10,
      decoration: InputDecoration(
        hintText: placeholder,
        suffixText: "${textEditingController.text.length.toString()}/10",
      ),
    );
  }
}
