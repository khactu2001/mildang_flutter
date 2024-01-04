import 'package:flutter/material.dart';
import 'package:flutter_mildang/utils/utilities.dart';

class CommonTextfieldStateful extends StatefulWidget {
  const CommonTextfieldStateful({
    super.key,
    required this.textEditingController,
    this.disabled,
    required this.decoration,
    this.validator,
    this.style,
    this.obscureText,
    this.placeholderText,
    this.onChanged,
    this.maxLength,
  });

  final TextEditingController textEditingController;
  final bool? disabled;
  final bool? obscureText;
  final InputDecoration decoration;
  final FormFieldValidator<String>? validator;
  final TextStyle? style;
  final String? placeholderText;
  final void Function(String)? onChanged;
  final int? maxLength;

  @override
  State<CommonTextfieldStateful> createState() => _CommonTextfieldStateful();
}

class _CommonTextfieldStateful extends State<CommonTextfieldStateful> {
  late FocusNode focusNode;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: widget.textEditingController,
      controller: textEditingController,
      focusNode: focusNode,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: widget.style?.fontSize,
            fontWeight: widget.style?.fontWeight,
            color: widget.style?.color,
          ),
      enabled: widget.disabled == true ? false : true,
      decoration: widget.decoration.copyWith(
        filled: widget.disabled,
        hintText: widget.placeholderText,
        counterText: '',
        errorStyle: const TextStyle(fontSize: 14),
        hintStyle: TextStyle(
          color: HexColor('#A3A5AE'),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#E1E2E5'),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      validator: widget.validator,
      obscureText: widget.obscureText ?? false,
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
      // textInputAction: TextInputAction.next,
    );
  }
}
