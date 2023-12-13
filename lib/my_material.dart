import 'package:flutter/material.dart';
import 'package:flutter_mildang/configs/theme.config.dart';
import 'package:flutter_mildang/my_scaffold_tabs.dart';
import 'package:flutter_mildang/provider/authen_model.dart';
import 'package:flutter_mildang/screens/detail_screen.dart';
import 'package:flutter_mildang/screens/login-stack/find_account_result_screen.dart';
import 'package:flutter_mildang/screens/login-stack/find_account_screen.dart';
import 'package:flutter_mildang/screens/login-stack/login_screen.dart';
import 'package:flutter_mildang/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final theme = ThemeData().copyWith(
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: appBarColor,
    foregroundColor: textWhite,
    elevation: 2.0,
    shadowColor: Colors.grey,
  ),
  useMaterial3: true,
  colorScheme: kColorScheme,
  textTheme: textTheme,
  buttonTheme: const ButtonThemeData(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.primary,
      foregroundColor: kColorScheme.onPrimary,
      //background color when button is disabled
      disabledBackgroundColor: kColorScheme.onSurface,
      //text when button is disabled
      disabledForegroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      fixedSize: const Size(double.infinity, 56),
    ),
  ),
  // button
  inputDecorationTheme: const InputDecorationTheme().copyWith(
    hintStyle: const TextStyle(
      color: Color(0xffA3A5AE),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffE1E2E5),
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    fillColor: textfieldDisabledBackgroundColor,
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
  ),
);
// final GoRouter _publicRouter = GoRouter(
//   // redirect: (context, state) async {
//   //   final Map<String, dynamic>? token =
//   //       await getLocalVariable(LocalKeyCustom.token);
//   //   final Map<String, dynamic>? userCheck =
//   //       await getLocalVariable(LocalKeyCustom.user);
//   //   print('user loaded from local: $userCheck');
//   //   print('token loaded from local: $token');
//   //   if (userCheck != null && token != null) {
//   //     try {
//   //       UserModel userLocal = UserModel.fromJson(userCheck);

//   //       if (context.mounted) {
//   //         Provider.of<ChangeNotifierModel>(context, listen: false)
//   //             .updateUserProvider(userLocal);
//   //         Provider.of<AuthenModel>(context, listen: false)
//   //             .setAuthenticated(true);
//   //       }
//   //     } catch (e) {
//   //       print('${e.toString()}');
//   //     }
//   //     return '/';
//   //   }

//   //   return null;
//   // },
//   errorBuilder: (context, state) {
//     return const ErrorScreen();
//   },
//   initialLocation: '/login',
//   debugLogDiagnostics: true,
//   routes: <RouteBase>[
//     GoRoute(
//         name: 'LoginScreen',
//         path: '/login',
//         builder: (BuildContext context, GoRouterState state) {
//           return const LoginScreen();
//         },
//         routes: <RouteBase>[
//           GoRoute(
//             name: 'FindAccountScreen',
//             path: 'find-account',
//             builder: (BuildContext context, GoRouterState state) {
//               return const FindAccountScreen();
//             },
//           ),
//           GoRoute(
//             name: 'FindAccountResultScreen',
//             path: 'find-account-result',
//             builder: (BuildContext context, GoRouterState state) {
//               return const FindAccountResultScreen();
//             },
//           ),
//         ]),
//     GoRoute(
//       name: 'SignupScreen',
//       path: '/signup',
//       builder: (BuildContext context, GoRouterState state) {
//         return const SignupScreen();
//       },
//     ),
//   ],
// );
// final GoRouter _privateRouter = GoRouter(
//   redirect: (context, state) async {
//     // final Map<String, dynamic>? token =
//     //     await getLocalVariable(LocalKeyCustom.token);
//     // final Map<String, dynamic>? userCheck =
//     //     await getLocalVariable(LocalKeyCustom.user);
//     // print('user loaded from local: $userCheck');
//     // print('token loaded from local: $token');
//     // if (userCheck != null && token != null) {
//     //   try {
//     //     UserModel userLocal = UserModel.fromJson(userCheck);

//     //     if (context.mounted) {
//     //       Provider.of<ChangeNotifierModel>(context, listen: false)
//     //           .updateUserProvider(userLocal);
//     //       Provider.of<AuthenModel>(context, listen: false)
//     //           .setAuthenticated(true);
//     //     }
//     //   } catch (e) {
//     //     print('${e.toString()}');
//     //   }
//     //   return '/';
//     // }
//     // print(state);

//     return null;
//   },
//   errorBuilder: (context, state) {
//     return const ErrorScreen();
//   },
//   initialLocation: '/',
//   debugLogDiagnostics: true,
//   routes: <RouteBase>[
//     GoRoute(
//       name: 'HomeScreen',
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) {
//         return const MyScaffold();
//       },
//       routes: <RouteBase>[
//         GoRoute(
//           name: 'DetailScreen',
//           path: 'detail',
//           builder: (BuildContext context, GoRouterState state) {
//             print('----${state.extra}----');
//             return const DetailScreen();
//           },
//         ),
//       ],
//       // route
//     ),
//   ],
// );

final GoRouter generalRouter = GoRouter(
  redirect: (context, state) {
    // user is in private routes AND token expired
    final authenModel = Provider.of<AuthenModel>(context, listen: false);
    final matchedLocation = state.matchedLocation;

    // not logged in
    if (authenModel.getAuthenticated == false) {
      // navigate to some public screens
      if (matchedLocation.startsWith('/public-routes') &&
          matchedLocation != '/public-routes') {
        // navigate to that screen
        return null;
      }
      return '/public-routes';
    }
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      name: 'HomeScreen',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyScaffold();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'DetailScreen',
          path: 'detail',
          builder: (BuildContext context, GoRouterState state) {
            print('----${state.extra}----');
            return const DetailScreen();
          },
        ),
      ],
      // route
    ),
    GoRoute(
        name: 'LoginScreen',
        path: '/public-routes',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'FindAccountScreen',
            path: 'find-account',
            builder: (BuildContext context, GoRouterState state) {
              return const FindAccountScreen();
            },
          ),
          GoRoute(
            name: 'FindAccountResultScreen',
            path: 'find-account-result',
            builder: (BuildContext context, GoRouterState state) {
              return const FindAccountResultScreen();
            },
          ),
          GoRoute(
            name: 'SignupScreen',
            path: 'signup',
            builder: (BuildContext context, GoRouterState state) {
              return const SignupScreen();
            },
          ),
        ]),
  ],
);

class MyMaterial extends StatelessWidget {
  const MyMaterial({
    super.key,
    // required this.isLoggedIn,
  });

  // final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    // final isAuthenticated = Provider.of<AuthenModel>(context).getAuthenticated;
    return MaterialApp.router(
      routerConfig: generalRouter,
      // routerConfig: isAuthenticated ? _privateRouter : _publicRouter,
      theme: theme,
    );
  }

  // final GoRoute _route = GoRoute(path: path)
}
