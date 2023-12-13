import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/provider/authen_model.dart';
import 'package:flutter_mildang/provider/change_notifier_model.dart';
import 'package:flutter_mildang/utils/utilities.dart';
// import 'package:flutter_mildang/widgets/bottom-tab/bottom_tabs.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.title,
  });

  final String? title;

  void logout(BuildContext context) {
    context.goNamed('LoginScreen');
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Provider.of<AuthenModel>(context).getAuthenticated ${Provider.of<AuthenModel>(context).getAuthenticated}');
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Home screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                // Row(
                //   children: [
                //     ElevatedButton(
                //       onPressed: () async {
                //         await removeLocalVariable(LocalKeyCustom.user);
                //         await removeLocalVariable(LocalKeyCustom.token);

                //         if (!context.mounted) return;
                //         Provider.of<AuthenModel>(context, listen: false)
                //             .setAuthenticated(false);
                //         logout(context);
                //       },
                //       child: const Text('Log out'),
                //     ),
                //     ElevatedButton(
                //       onPressed: () {
                //         Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => const DetailScreen(),
                //         ));
                //       },
                //       child: const Text('Edit profile'),
                //     ),
                //   ],
                // ),
                // Row(
                //   children: [
                //     ElevatedButton(
                //       onPressed: () {
                //         // Navigator.push(
                //         //     context,
                //         //     MaterialPageRoute(
                //         //         builder: (context) => const DetailScreen()));
                //         // context.go('/detail');
                //         context.pushNamed('DetailScreen',
                //             extra: userProvider.toString());
                //       },
                //       child: const Text('Detail'),
                //     ),
                //     ElevatedButton(
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => const SignupScreen()));
                //       },
                //       child: const Text('Signup'),
                //     ),
                //     ElevatedButton(
                //       onPressed: () {
                //         // Navigator.push(
                //         //     context,
                //         //     MaterialPageRoute(
                //         //         builder: (context) => const SignupScreen()));
                //         context.go('/login');
                //       },
                //       child: const Text('login'),
                //     ),
                //   ],
                // )
              ],
            );
          },
          child: const SizedBox(
            height: 20,
          ),
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
