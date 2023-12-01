import 'package:flutter/material.dart';

class CommonTextfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool? disabled;
  final InputDecoration decoration;
  final FormFieldValidator<String>? validator;

  const CommonTextfield({
    super.key,
    required this.textEditingController,
    this.disabled,
    required this.decoration,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      style: Theme.of(context).textTheme.bodySmall,
      enabled: disabled == true ? false : true,
      decoration: decoration,
      validator: validator,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
