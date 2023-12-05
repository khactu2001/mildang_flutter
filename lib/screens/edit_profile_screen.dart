// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mildang/apis/api.dart';
// import 'package:flutter_mildang/main.dart';
import 'package:flutter_mildang/model/change_notifier_model.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/utils/utilities.dart';
import 'package:flutter_mildang/widgets/textfields/common_textfield_stateful.dart';
import 'package:flutter_mildang/widgets/textfields/dob_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final formatter = DateFormat.yMd();

class RowTitleRequiredField extends StatelessWidget {
  const RowTitleRequiredField({super.key, required this.title, this.required});
  final String title;
  final bool? required;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 32,
        bottom: 6,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            child: required == true
                ? Text(
                    '*',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.user});
  @override
  State<EditProfileScreen> createState() {
    return _EditProfileScreenState();
  }

  final UserModel user;
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submitProfile() async {
    if (_formKey.currentState!.validate()) {
      await updateProfile({
        'nickname': usernameController.text,
        'email': emailController.text,
      });

      widget.user.nickname = usernameController.text;
      widget.user.email = emailController.text;
      await setLocalVariable(LocalKeyCustom.user, jsonEncode(widget.user));

      if (mounted) {
        // standalone call function without needing data
        Provider.of<ChangeNotifierModel>(context, listen: false)
            .updateUserProvider(widget.user);

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('submit')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('invalid')));
    }
  }

  String get formatDOB {
    DateTime dob = widget.user.birthday == null
        ? DateTime.now()
        : DateTime.parse(widget.user.birthday!);
    String dobString = DateFormat('ddMMyy').format(dob);
    return dobString;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    phoneController.text = widget.user.phone;
    genderController.text = widget.user.gender.toString();
    usernameController.text = widget.user.nickname ?? '';
    // usernameController.text =
    //     Provider.of<ChangeNotifierModel>(context).userProvider?.nickname ?? '';
    emailController.text = widget.user.email;

    if (widget.user.birthday != null) {
      dobController.text =
          formatter.format(DateTime.parse(widget.user.birthday!));
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    dobController.dispose();
    genderController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void logout(BuildContext ctx) async {
    await removeLocalVariable(LocalKeyCustom.token);
    await removeLocalVariable(LocalKeyCustom.user);
    if (!mounted) return;
    ctx.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지 수정'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            // Navigator.pop(context);
            // context.go('/', extra: jsonEncode(widget.user));
            context.pop();
          },
        ),
        forceMaterialTransparency: true,
        actions: [
          TextButton(
            onPressed: _submitProfile,
            child: const Text('저장'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------phone--------------
                  const RowTitleRequiredField(
                    title: '휴대폰 번호',
                    required: true,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: CommonTextfieldStateful(
                            textEditingController: phoneController,
                            disabled: true,
                            decoration: const InputDecoration(
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const SizedBox(
                        height: 56,
                        width: 108,
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text('인증'),
                        ),
                      )
                    ],
                  ),
                  // ------------dob----------------
                  const RowTitleRequiredField(
                    title: '생년월일/ 성별',
                    required: true,
                  ),
                  TextFieldDOB(
                    dob: formatDOB,
                    disabled: true,
                    placeholder: '8734',
                    gender: widget.user.gender,
                  ),
                  // ---------------username-----------------
                  const RowTitleRequiredField(
                    title: '닉네임',
                    required: true,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextfieldStateful(
                          textEditingController: usernameController,
                          placeholderText: 'Enter username...',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                          maxLength: 10,
                          onChanged: (value) {
                            setState(() {
                              usernameController.text = value;
                            });
                          },
                          decoration: InputDecoration(
                              suffix:
                                  Text('${usernameController.text.length}/10')),
                        ),
                      ),
                    ],
                  ),
                  // // -------------------email---------------------
                  const RowTitleRequiredField(
                    title: '이메일',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextfieldStateful(
                          textEditingController: emailController,
                          decoration: const InputDecoration(),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              // start checking
                              return validateEmail(value)
                                  ? null
                                  : 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      logout(context);
                      // context.go(location)
                    },
                    child: const Text('Log out'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
