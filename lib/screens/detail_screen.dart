import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/change_notifier_model.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/screens/edit_profile_screen.dart';
import 'package:flutter_mildang/utils/utilities.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
  });

  void logout(BuildContext context) {
    // context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
        child: Consumer<ChangeNotifierModel>(
          builder: (context, model, child) {
            UserModel? userProvider = model.userProvider;
            print('userProvider: ${userProvider?.nickname}');
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ...[
                      if (child != null) child,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Id: '),
                          Text(userProvider?.id.toString() ?? '-'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Phone: '),
                          Text(userProvider?.phone ?? '-'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Birthday: '),
                          Text(userProvider?.birthday != null
                              ? convertStringToFormattedDateTime(
                                  userProvider!.birthday.toString(),
                                  format: 'dd-MM-yyyy',
                                )
                              : ''),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Nickname: '),
                          Text(userProvider?.nickname ?? '-'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Email: '),
                          Text(userProvider?.email ?? '-'),
                        ],
                      ),
                    ].expand((element) => [
                          element,
                          const SizedBox(
                            height: 20,
                          ),
                        ])
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await removeLocalVariable(LocalKeyCustom.user);
                        await removeLocalVariable(LocalKeyCustom.token);

                        if (!context.mounted) return;
                        logout(context);
                      },
                      child: const Text('Log out'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context)
                        //     .popUntil(ModalRoute.withName('/'));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const EditProfileScreen(),
                        //   ),
                        // );
                      },
                      child: const Text('Edit profile'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.go('/');
                        // Navigator.of(context)
                        //     .popUntil(ModalRoute.withName('/'));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const EditProfileScreen(),
                        //   ),
                        // );
                      },
                      child: const Text('back to home'),
                    )
                  ],
                )
              ],
            );
          },
          child: const Text('DETAIL SCREEN'),
        ),
      ),
    );
  }

  Widget showBottomTab(Icon icon, String buttonText) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
      ),
      onPressed: () {},
      child: Column(
        children: [
          icon,
          Text(buttonText),
        ],
      ),
    );
  }
}
