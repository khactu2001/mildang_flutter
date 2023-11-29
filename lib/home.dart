import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/login_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.user, required this.onPressLogout});

  final UserModel? user;
  final void Function() onPressLogout;

  @override
  Widget build(BuildContext context) {
    print(user);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  const Text('Name: '),
                  Text(user?.name?.toString() ?? '-'),
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
          ElevatedButton(
            onPressed: onPressLogout,
            child: const Text('Log out'),
          )
        ],
      ),
    );
  }
}
