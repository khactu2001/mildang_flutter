import 'package:flutter/material.dart';
import 'package:flutter_mildang/configs/theme.config.dart';
import 'package:flutter_mildang/screens/detail_screen.dart';
import 'package:flutter_mildang/screens/edit_profile_screen.dart';
import 'package:flutter_mildang/screens/error_screen.dart';
import 'package:flutter_mildang/screens/home_screen.dart';
import 'package:flutter_mildang/screens/login-stack/find_account_result_screen.dart';
import 'package:flutter_mildang/screens/login-stack/find_account_screen.dart';
import 'package:flutter_mildang/screens/login-stack/login_screen.dart';
// import 'package:flutter_mildang/screens/signup_1_screen.dart';
import 'package:flutter_mildang/screens/signup_screen.dart';
// import 'package:flutter_mildang/screens/signup_screen.dart';
// import 'package:flutter_mildang/screens/signup_screen.dart';
// import 'package:flutter_mildang/utils/utilities.dart';
import 'package:flutter_mildang/widgets/bottom-tab/bottom_tabs.dart';
import 'package:go_router/go_router.dart';

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

class MyMaterial extends StatelessWidget {
  const MyMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: theme,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: 'home-stack',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyScaffold();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'detail',
          path: 'detail',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailScreen();
          },
        ),
      ],
    ),
    GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'find-account',
            path: 'find-account',
            builder: (BuildContext context, GoRouterState state) {
              return const FindAccountScreen();
            },
          ),
          GoRoute(
            name: 'find-account-result',
            path: 'find-account-result',
            builder: (BuildContext context, GoRouterState state) {
              return const FindAccountResultScreen();
            },
          ),
        ]),
    GoRoute(
      name: 'signup-screen',
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return const SignupScreen();
      },
    ),
  ],
);

class MyScaffold extends StatefulWidget {
  const MyScaffold({
    super.key,
  });

  @override
  State<MyScaffold> createState() => MyScaffoldState();
}

RouterConfig<Object>? routerConfig = GoRouter(
  errorBuilder: (context, state) {
    return const ErrorScreen();
  },
  initialLocation: '/login',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        name: 'home_screen',
        path: '/',
        builder: (context, state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: 'detail',
            builder: (context, state) {
              return const DetailScreen();
            },
          )
        ]),
    GoRoute(
      name: 'edit_profile_screen',
      path: '/edit',
      builder: (context, state) {
        return const EditProfileScreen();
      },
    ),
    GoRoute(
      name: 'login_screen',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    // GoRoute(
    //   name: 'signup_screen',
    //   path: '/signup',
    //   builder: (context, state) => const SignupScreen(),
    // ),
  ],
);

class MyScaffoldState extends State<MyScaffold> {
  String tabName = '/';
  int currentTabIndex = 0;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomTabs(
        tabName: tabName,
        navigateTo: (path) {
          setState(() {
            tabName = path;
          });
          switch (path) {
            case '/':
              setState(() {
                currentTabIndex = 0;
              });
              break;
            // case '/detail':
            //   setState(() {
            //     currentTabIndex = 1;
            //   });
            //   break;
            // case '/detail':
            //   setState(() {
            //     currentTabIndex = 2;
            //   });
            //   break;
            // case '/login':
            //   setState(() {
            //     currentTabIndex = 3;
            //   });
            //   break;
            case '/edit':
              setState(() {
                currentTabIndex = 1;
              });
              break;

            // default:
            //   break;
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return TabNavigator(
      navigatorKey: navigatorKey,
      tabName: tabName,
      currentTabIndex: currentTabIndex,
    );
  }
}

class TabNavigator extends StatelessWidget {
  TabNavigator(
      {super.key,
      required this.navigatorKey,
      required this.tabName,
      required this.currentTabIndex});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabName;
  final int currentTabIndex;

  final List<Widget> _screens = [
    const HomeScreen(),
    const EditProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentTabIndex],
    );
  }
}
