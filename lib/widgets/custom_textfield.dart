import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final InputDecoration? decoration;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.decoration,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: widget.decoration,
      validator: widget.validator,
      onTapOutside: (event) {
        _focusNode.unfocus();
      },
      focusNode: _focusNode,
    );
  }
}
