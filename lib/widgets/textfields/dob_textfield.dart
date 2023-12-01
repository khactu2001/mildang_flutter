import 'package:flutter/material.dart';
import 'package:flutter_mildang/main.dart';

class TextFieldDOB extends StatefulWidget {
  const TextFieldDOB({
    super.key,
    // required this.textEditingController,
    // required this.genderController,
    this.dob,
    this.placeholder,
    this.disabled,
  });

  final String? placeholder;
  final String? dob;
  final bool? disabled;

  @override
  State<TextFieldDOB> createState() => _TextFieldDOBState();
}

class _TextFieldDOBState extends State<TextFieldDOB> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  late FocusNode phoneFocusNode;
  late FocusNode genderFocusNode;
  @override
  void initState() {
    super.initState();
    phoneController.addListener(_printLatestValue);
    genderController.addListener(_printGenderValue);

    phoneFocusNode = FocusNode();
    genderFocusNode = FocusNode();
    phoneController.text = widget.dob ?? '';
  }

  @override
  void dispose() {
    phoneController.dispose();
    genderController.dispose();

    phoneFocusNode.dispose();
    genderFocusNode.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    final text = phoneController.text;
    print('Second text field: $text (${text.characters.length})');
    // if (text.characters.length > 5) {
    //   // genderController
    //   genderFocusNode.requestFocus();
    // }
  }

  void _printGenderValue() {
    final text = genderController.text;
    print('Second text field: $text (${text.characters.length})');
  }

  // const _TextFieldDOBState(
  //     {super.key,
  //     required this.textEditingController,
  //     required this.genderController,
  //     this.placeholder,
  //     this.disabled});
  // @override
  // void initState() {
  //   super.initState();

  //   // Start listening to changes.
  //   myController.addListener(_printLatestValue);
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: SizedBox(
            width: 135,
            height: 56,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.top,
              controller: phoneController,
              focusNode: phoneFocusNode,
              onChanged: (value) {
                if (value.trim().length > 5) {
                  genderFocusNode.requestFocus();
                }
              },
              enabled: widget.disabled == true ? false : true,
              onTapOutside: (event) {
                phoneFocusNode.unfocus();
              },
              decoration: InputDecoration(
                hintText: widget.placeholder,
                filled: widget.disabled == true,
                counterText: '',
              ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    letterSpacing: 2,
                  ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('-'),
        ),
        SizedBox(
          width: 50,
          height: 56,
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.top,
              enabled: widget.disabled == true ? false : true,
              controller: genderController,
              focusNode: genderFocusNode,
              maxLength: 1,
              onTapOutside: (event) {
                genderFocusNode.unfocus();
              },
              decoration: InputDecoration(
                counterText: '',
                hintText: widget.placeholder,
                filled: widget.disabled == true,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '******',
            style: TextStyle(
              fontSize: 24,
              color: textLabelColor,
            ),
          ),
        ),
      ],
    );
  }
}
