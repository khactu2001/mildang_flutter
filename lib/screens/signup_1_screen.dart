import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/provider/change_notifier_provider.dart';
import 'package:provider/provider.dart';

class Signup1Screen extends StatelessWidget {
  const Signup1Screen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
      child: Consumer<UserProvider>(
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
                  ].expand((element) => [
                        element,
                        const SizedBox(
                          height: 20,
                        ),
                      ])
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('signup/signup2');
                  },
                  child: Text('go to signup 2'))
            ],
          );
        },
        child: const Text('1 SCREEN'),
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
