import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mildang/utils/utilities.dart';

class CustomFormBuilderTF extends FormBuilderTextField {
  CustomFormBuilderTF({
    Key? key,
    String name = '',
    InputDecoration? decoration, // Custom decoration
    String? Function(String?)? validator,
    FocusNode? focusNode,
    String? hintText,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    // Add other parameters you need to pass to FormBuilderTextField
  }) : super(
          key: key,
          name: name,
          validator: validator,
          focusNode: focusNode,
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxLength),
          ],
          decoration: InputDecoration(
            // isDense: true,
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
            contentPadding: decoration?.hintText == null
                ? const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16)
                : decoration?.contentPadding,
            isDense: decoration?.hintText == null ? false : true,
          ).copyWith(
            hintText: decoration?.hintText,
          ), // Use custom or default decoration
          // Pass other parameters to FormBuilderTextField
        );

  // Widget build(BuildContext context) {
  //   return Container(
  //     decoration: const BoxDecoration(color: Colors.amber),
  //     height: 80,
  //     width: 300,
  //     child: FormBuilderTextField(
  //       key: ValueKey(name),
  //       name: name,
  //       // decoration: decoration,
  //       validator: validator,
  //       focusNode: focusNode,
  //       decoration: InputDecoration(
  //         errorStyle: const TextStyle(fontSize: 14),
  //         hintStyle: TextStyle(
  //           color: HexColor('#A3A5AE'),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(
  //             color: HexColor('#E1E2E5'),
  //           ),
  //           borderRadius: const BorderRadius.all(Radius.circular(8)),
  //         ),
  //         focusedBorder: const OutlineInputBorder(
  //           borderSide: BorderSide(
  //             color: Colors.black,
  //           ),
  //           borderRadius: BorderRadius.all(Radius.circular(8)),
  //         ),
  //         errorBorder: const OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(8)),
  //           borderSide: BorderSide(
  //             color: Colors.red,
  //           ),
  //         ),
  //         focusedErrorBorder: const OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(8)),
  //           borderSide: BorderSide(
  //             color: Colors.red,
  //           ),
  //         ),
  //       ).copyWith(
  //         hintText: decoration.hintText,
  //       ), // Use custom or default decoration
  //     ),
  //   );
  //   // return Text('akshjdfx');
  //   // return Container(
  //   //   decoration: const BoxDecoration(color: Colors.amber, border: Border()),
  //   //   height: 100,
  //   //   width: 300,
  //   //   child: Text('kjashdkjhdf'),
  //   // );
  // }
}
