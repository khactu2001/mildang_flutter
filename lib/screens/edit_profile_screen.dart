// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mildang/apis/api.dart';
// import 'package:flutter_mildang/main.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/provider/authen_provider.dart';
import 'package:flutter_mildang/provider/change_notifier_provider.dart';
import 'package:flutter_mildang/utils/utilities.dart';
import 'package:flutter_mildang/widgets/textfields/common_textfield_stateful.dart';
import 'package:flutter_mildang/widgets/textfields/dob_textfield.dart';
import 'package:get/get.dart';
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
  const EditProfileScreen({
    super.key,
  });
  @override
  State<EditProfileScreen> createState() {
    return _EditProfileScreenState();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // UserModel? user;

  void _submitProfile() async {
    if (_formKey.currentState!.validate()) {
      await updateProfile({
        'nickname': usernameController.text,
        'email': emailController.text,
      });

      if (mounted) {
        UserModel user = Provider.of<UserProvider>(context, listen: false)
            .getUserProvider()!;
        user.nickname = usernameController.text;
        user.email = emailController.text;

        // standalone call function without needing data
        Provider.of<UserProvider>(context).updateUserProvider(user);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            content: Text('submit'),
          ),
        );
        await setLocalVariable(LocalKeyCustom.user, jsonEncode(user));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('invalid'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initValueAfterMounted();
  }

  void _initValueAfterMounted() {
    if (mounted) {
      final userProvider =
          Provider.of<UserProvider>(context, listen: false).userProvider;

      usernameController.text = userProvider?.nickname ?? '';
      emailController.text = userProvider?.email ?? '';

      phoneController.text = userProvider?.phone ?? '';
      genderController.text = userProvider?.gender.toString() ?? '';

      if (userProvider?.birthday != null) {
        dobController.text =
            formatter.format(DateTime.parse(userProvider?.birthday ?? ''));
      }
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
    // return Scaffold(
    // appBar: AppBar(
    //   title: const Text('마이페이지 수정'),
    //   titleTextStyle: Theme.of(context).textTheme.titleLarge,
    //   centerTitle: true,
    //   leading: IconButton(
    //     color: Colors.black,
    //     icon: const Icon(Icons.arrow_back_ios_new),
    //     onPressed: () {
    //       context.pop();
    //     },
    //   ),
    //   forceMaterialTransparency: true,
    //   actions: [
    //     TextButton(
    //       onPressed: _submitProfile,
    //       child: const Text('저장'),
    //     ),
    //   ],
    // ),
    //   body: SingleChildScrollView(
    //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.max,
    //       children: [
    //         Form(
    //           key: _formKey,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   // ---------------phone--------------
    //                   const RowTitleRequiredField(
    //                     title: '휴대폰 번호',
    //                     required: true,
    //                   ),
    //                   Row(
    //                     children: [
    //                       Expanded(
    //                         child: SizedBox(
    //                           height: 56,
    //                           child: CommonTextfieldStateful(
    //                             textEditingController: phoneController,
    //                             disabled: true,
    //                             decoration: const InputDecoration(
    //                               filled: true,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         width: 8,
    //                       ),
    //                       const SizedBox(
    //                         height: 56,
    //                         width: 108,
    //                         child: ElevatedButton(
    //                           onPressed: null,
    //                           child: Text('인증'),
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                   // ------------dob----------------
    //                   const RowTitleRequiredField(
    //                     title: '생년월일/ 성별',
    //                     required: true,
    //                   ),
    //                   TextFieldDOB(
    //                     dob: convertStringToFormattedDateTime(
    //                         Provider.of<ChangeNotifierModel>(context,
    //                                     listen: false)
    //                                 .userProvider
    //                                 ?.birthday ??
    //                             ""),
    //                     disabled: true,
    //                     gender: int.tryParse(genderController.text),
    //                   ),
    //                   // ---------------username-----------------
    //                   const RowTitleRequiredField(
    //                     title: '닉네임',
    //                     required: true,
    //                   ),
    //                   Row(
    //                     children: [
    //                       Expanded(
    //                         child: CommonTextfieldStateful(
    //                           textEditingController: usernameController,
    //                           placeholderText: 'Enter username...',
    //                           validator: (value) {
    //                             if (value == null || value.isEmpty) {
    //                               return 'Please enter username';
    //                             }
    //                             return null;
    //                           },
    //                           maxLength: 10,
    //                           decoration: InputDecoration(
    //                               suffix: Text(
    //                                   '${usernameController.text.length}/10')),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   // // -------------------email---------------------
    //                   const RowTitleRequiredField(
    //                     title: '이메일',
    //                   ),
    //                   Row(
    //                     children: [
    //                       Expanded(
    //                         child: CommonTextfieldStateful(
    //                           textEditingController: emailController,
    //                           decoration: const InputDecoration(),
    //                           validator: (value) {
    //                             if (value != null && value.isNotEmpty) {
    //                               // start checking
    //                               return validateEmail(value)
    //                                   ? null
    //                                   : 'Please enter a valid email';
    //                             }
    //                             return null;
    //                           },
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //               // Row(
    //               //   mainAxisAlignment: MainAxisAlignment.center,
    //               //   children: [
    //               //     ElevatedButton(
    //               //       onPressed: () {
    //               //         logout(context);
    //               //         // context.go(location)
    //               //       },
    //               //       child: const Text('Log out'),
    //               //     ),
    //               //   ],
    //               // ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Form(
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
                        dob: convertStringToFormattedDateTime(
                            Provider.of<UserProvider>(context, listen: false)
                                    .userProvider
                                    ?.birthday ??
                                ""),
                        disabled: true,
                        gender: int.tryParse(genderController.text),
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
                              decoration: InputDecoration(
                                  suffix: Text(
                                      '${usernameController.text.length}/10')),
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

                      ElevatedButton(
                        onPressed: () async {
                          await removeLocalVariable(LocalKeyCustom.user);
                          await removeLocalVariable(LocalKeyCustom.token);
                          Get.offAllNamed('/login');
                        },
                        child: const Text('Logout'),
                      ),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     await removeLocalVariable(LocalKeyCustom.user);
                      //     await removeLocalVariable(LocalKeyCustom.token);
                      //   },
                      //   child: const Text('test base api'),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
