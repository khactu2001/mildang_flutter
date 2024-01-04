import 'package:flutter/material.dart';
import 'package:flutter_mildang/configs/theme.config.dart';
import 'package:flutter_mildang/my_scaffold_tabs.dart';
import 'package:flutter_mildang/screens/error_screen.dart';
import 'package:flutter_mildang/screens/login-stack/login_screen.dart';
import 'package:flutter_mildang/screens/newsletter/newsletter_bookmark.dart';
import 'package:flutter_mildang/screens/newsletter/newsletter_detail.dart';
import 'package:flutter_mildang/screens/signup-stack/signup_screen.dart';
import 'package:flutter_mildang/screens/signup-stack/term_screen.dart';
import 'package:flutter_mildang/screens/signup_screen.dart';
import 'package:flutter_mildang/utils/utilities.dart';
import 'package:get/get.dart';

final theme = ThemeData().copyWith(
  appBarTheme: const AppBarTheme().copyWith(
    elevation: 2.0,
    shadowColor: Colors.grey,
    backgroundColor: Colors.white,
    foregroundColor: textLabelColor,
    surfaceTintColor: Colors.transparent,
  ),
  primaryColor: HexColor('#248BB0'),
  useMaterial3: true,
  colorScheme: kColorScheme,
  textTheme: textTheme,
  buttonTheme: const ButtonThemeData(),
  scaffoldBackgroundColor: Colors.white,
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

// final GoRouter generalRouter = GoRouter(
//   // navigatorKey: navigatorKey,
//   navigatorKey: Get.key,
//   debugLogDiagnostics: true,
//   redirect: (context, state) {
//     final Controller c = Get.find();
//     // user is in private routes AND token expired
//     // final authenProvider = Provider.of<AuthenProvider>(context, listen: false);
//     // final authenProvider  = AuthenProvider(_isAuthenticated, _token)
//     final matchedLocation = state.matchedLocation;

//     // not logged in
//     // if (authenProvider.getAuthenticated == false) {
//     if (c.isAuthen.value == false) {
//       // navigate to some public screens
//       if (matchedLocation.startsWith('/public-routes') &&
//           matchedLocation != '/public-routes') {
//         // navigate to that screen
//         return null;
//       }
//       return '/public-routes';
//     }
//     return null;
//   },
//   routes: <RouteBase>[
//     GoRoute(
//       name: 'HomeScreen',
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) {
//         return const MyScaffold();
//       },
//       routes: <RouteBase>[
//         // GoRoute(
//         //   name: 'DetailScreen',
//         //   path: 'detail',
//         //   builder: (BuildContext context, GoRouterState state) {
//         //     print('----${state.extra}----');
//         //     return const DetailScreen();
//         //   },
//         // ),
//         GoRoute(
//           name: 'NewsletterDetailScreen',
//           path: 'news-detail',
//           builder: (BuildContext context, GoRouterState state) {
//             print('----${state.extra}----');
//             // NewsItems newsItems =
//             //     NewsItems.fromJson(jsonDecode(state.extra.toString()));
//             return const NewsletterDetailScreen(
//                 // newsItems: newsItems,
//                 );
//           },
//         ),
//         GoRoute(
//           name: 'NewsletterBookmarkScreen',
//           path: 'news-bookmark',
//           builder: (BuildContext context, GoRouterState state) {
//             return const NewsletterBookmarkScreen();
//           },
//         ),
//       ],
//       // route
//     ),
//     GoRoute(
//         name: 'LoginScreen',
//         path: '/public-routes',
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
//           GoRoute(
//             name: 'SignupScreen',
//             path: 'signup',
//             builder: (BuildContext context, GoRouterState state) {
//               return const SignupScreen();
//             },
//           ),
//         ]),
//     GoRoute(
//       name: 'DetailScreen',
//       path: '/detail',
//       builder: (BuildContext context, GoRouterState state) {
//         print('----${state.extra}----');
//         return const DetailScreen();
//       },
//     ),
//   ],
// );
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyMaterial extends StatelessWidget {
  const MyMaterial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    // return MaterialApp.router(
    //   routerConfig: generalRouter,
    //   theme: theme,
    // );
    return GetMaterialApp(
      theme: theme,
      unknownRoute: GetPage(name: '/notfound', page: () => const ErrorScreen()),
      initialRoute: '/signup',
      getPages: [
        GetPage(
          name: '/',
          page: () => const MyScaffold(),
          //
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: '/notfound',
          page: () => const ErrorScreen(),
        ),
        GetPage(
          name: '/news-bookmark',
          page: () => const NewsletterBookmarkScreen(),
        ),
        GetPage(
          name: '/news-detail/:id',
          page: () => const NewsletterDetailScreen(),
        ),
        GetPage(
          name: '/terms-of-service',
          page: () => const TermScreen(),
        ),
        GetPage(
          name: '/signup',
          page: () => const SignupScreen(),
        ),
      ],
    );
  }
}
