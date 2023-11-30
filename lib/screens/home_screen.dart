import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.user,
  });

  final UserModel? user;

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
                Text('HOME SCREEN'),
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
                    const Text('Username: '),
                    Text(user?.username?.toString() ?? '-'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Email: '),
                    Text(user?.email.toString() ?? '-'),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     context.canPop() ? context.pop() : () {};
                //   },
                //   child: const Text('go back'),
                // ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Log out'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed('edit_profile_screen');
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
