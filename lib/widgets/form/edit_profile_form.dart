import 'package:flutter/material.dart';

// Define a custom Form widget.
class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  EditProfileFormState createState() {
    return EditProfileFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class EditProfileFormState extends State<EditProfileForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: widget.formKey,
      child: const Column(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
