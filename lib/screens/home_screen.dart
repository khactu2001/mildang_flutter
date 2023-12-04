import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.user,
  });

  final UserModel? user;

  void logout(BuildContext context) {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('HOME SCREEN'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Id: '),
                    Text(user?.id.toString() ?? '-'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Phone: '),
                    Text(user?.phone.toString() ?? '-'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nickname: '),
                    Text(user?.nickname?.toString() ?? '-'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Email: '),
                    Text(user?.email.toString() ?? '-'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Birthday: '),
                    Text(user?.birthday.toString() ?? '-'),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('user');
                    await prefs.remove('token');
                    // if(localContext != null){
                    if (!context.mounted) return;
                    logout(context);
                    // };
                  },
                  child: const Text('Log out'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // context.pushNamed('edit_profile_screen');
                    context.push(
                      '/edit',
                      extra: jsonEncode(user),
                    );
                    // context.go(
                    //   '/edit',
                    //   extra: jsonEncode(user),
                    // );
                    // Navigator.push(context)
                  },
                  child: const Text('Edit profile'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
