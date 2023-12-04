import 'package:flutter/material.dart';
import 'package:flutter_mildang/widgets/textfields/common_textfield_stateful.dart';
// import 'package:flutter_mildang/main.dart';
// import 'package:flutter_mildang/widgets/textfields/dob_textfield.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<CommonTextfieldStateful> createState() => _TestState();
}

class _TestState extends State<CommonTextfieldStateful> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.textEditingController.text);
  }
}
