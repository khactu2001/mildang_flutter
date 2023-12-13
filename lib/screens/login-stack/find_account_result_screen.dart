import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/change_notifier_model.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FindAccountResultScreen extends StatelessWidget {
  const FindAccountResultScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    // Navigator.of(context).popUntil(
                    //   ModalRoute.withName('LoginScreen'),
                    // );

                    context.goNamed('LoginScreen');
                  },
                  child: const Text('pop'))
            ],
          );
        },
        child: const Text('FindAccountResultScreen'),
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
