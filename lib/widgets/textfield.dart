// class TextfieldCustom extends StatefulWidget {

// }
import 'package:flutter/material.dart';

// class TextfieldCustom extends StatefulWidget {
//   const TextfieldCustom({super.key});

//   @override
//   State<TextfieldCustom> createState() {
//     return _TextfieldCustomState();
//   }
// }

// class _TextfieldCustomState extends State<TextfieldCustom> {
//   late TextEditingController _textEditingController;

//   @override
//   Widget build(BuildContext context) {
//     return  TextField(
//       controller: _textEditingController,
//     );
//   }
// }
class TextfieldCustom extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? placeholder;

  const TextfieldCustom(
      {super.key, required this.textEditingController, this.placeholder});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: placeholder,
        // enabledBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: Color(0xffE1E2E5),
        //   ),
        //   borderRadius: BorderRadius.all(Radius.circular(8)),
        // ),
        // focusedBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: Colors.black,
        //   ),
        //   borderRadius: BorderRadius.all(Radius.circular(8)),
        // ),
      ),
    );
  }
}
