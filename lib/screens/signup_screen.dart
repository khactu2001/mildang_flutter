import 'package:flutter/material.dart';
import 'package:flutter_mildang/screens/signup_1_screen.dart';
import 'package:flutter_mildang/screens/signup_2_screen.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
    //   child: Consumer<ChangeNotifierModel>(
    //     builder: (context, model, child) {
    //       UserModel? userProvider = model.userProvider;
    //       print('userProvider: ${userProvider?.nickname}');
    //       return Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Column(
    //             children: [
    //               ...[
    //                 if (child != null) child,
    //               ].expand((element) => [
    //                     element,
    //                     const SizedBox(
    //                       height: 20,
    //                     ),
    //                   ])
    //             ],
    //           ),
    //         ],
    //       );
    //     },
    //     child: const Text('SIGNUP SCREEN'),
    //   ),
    // );
    return Navigator(
      initialRoute: 'signup/signup1',
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'signup/signup1':
            builder = (context) => const Signup1Screen();
          case 'signup/signup2':
            builder = (BuildContext _) => Signup2Screen(
                  onSignupFinish: () {
                    context.goNamed('LoginScreen');
                  },
                );

          default:
            throw Exception('Invalid route: ${settings.name}');
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
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
