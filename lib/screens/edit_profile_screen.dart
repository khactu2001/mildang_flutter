import 'package:flutter/material.dart';
import 'package:flutter_mildang/main.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/widgets/textfields/common_textfield.dart';
import 'package:flutter_mildang/widgets/textfields/dob_textfield.dart';
import 'package:flutter_mildang/widgets/textfields/tf_username.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // final dobController = TextEditingController();
  final genderController = TextEditingController();
  final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submitProfile() {
    if (_formKey.currentState!.validate()) {}
  }

  final String? dobParam = '29387';

  @override
  void initState() {
    super.initState();
    DateTime dob = widget.user.birthday == null
        ? DateTime.now()
        : DateTime.parse(widget.user.birthday!);
    String dobString = DateFormat('ddMMyy').format(dob);
    print('birthday: $dobString');

    setState(() {
      // dobParam = dobString;
    });

    emailController.text = widget.user.email;
    phoneController.text = widget.user.phone;
    genderController.text = widget.user.gender.toString();
  }

  @override
  void dispose() {
    phoneController.dispose();
    // dobController.dispose();
    genderController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void logout(BuildContext ctx) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('token');
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
          onPressed: () {},
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
                          child: CommonTextfield(
                            textEditingController: phoneController,
                            disabled: true,
                            decoration:
                                const InputDecoration(hintText: 'jasflk'),
                            // obscureText: true,
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
                  const TextFieldDOB(
                    // textEditingController: dobController,
                    // genderController: genderController,
                    disabled: true,
                    // dob: dobParam,
                  ),
                  // ---------------username-----------------
                  const RowTitleRequiredField(
                    title: '닉네임',
                    required: true,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextfieldUsername(
                          textEditingController: phoneController,
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
                        child: CommonTextfield(
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
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.canPop() ? context.pop() : () {};
                    },
                    child: const Text('go back'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      logout(context);
                      // context.go(location)
                    },
                    child: const Text('Log out'),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/edit');
                  //   },
                  //   child: const Text('Edit profile'),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
