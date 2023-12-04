import 'package:flutter/material.dart';
import 'package:flutter_mildang/widgets/textfields/common_textfield_stateful.dart';

class TextfieldUsername extends CommonTextfieldStateful {
  // TextfieldUsername({super.key});
  const TextfieldUsername({
    super.key,
    this.maxLength,
    required this.textEditingController,
    required this.decoration,
  }) : super(
          textEditingController: textEditingController,
          decoration: decoration,
        );

  final int? maxLength;
  @override
  final TextEditingController textEditingController;
  final InputDecoration decoration;
  @override
  State<TextfieldUsername> createState() => _TextfieldUsername();
}

class _TextfieldUsername extends State<TextfieldUsername> {
  // const TextfieldUsername(
  //     {
  //       super.key,
  //     // required this.textEditingController,
  //     // this.placeholder,
  //     // this.validator,
  //     });

  // final int maxLength = 10;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        hintText: widget.placeholderText,
        // suffixText:
        //     "${textEditingController.text.characters.length.toString()}/10",
      ),
      validator: widget.validator,
    );
  }
}
