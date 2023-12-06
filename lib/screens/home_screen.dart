import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_mildang/apis/api.dart';
import 'package:flutter_mildang/model/change_notifier_model.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/utils/utilities.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Tab {
  const Tab(
      {required this.icon,
      required this.text,
      required this.path,
      required this.iconActive});

  final Image icon;
  final Image iconActive;
  final String text;
  final String path;
}

final bottomButtons = [
  Tab(
      icon: Image.asset('assets/icons/bottom-bar/dr_post.png'),
      iconActive: Image.asset('assets/icons/bottom-bar/doctor_active.png'),
      text: 'Home',
      path: '/'),
  Tab(
    icon: Image.asset('assets/icons/bottom-bar/newsletter.png'),
    iconActive: Image.asset('assets/icons/bottom-bar/newsletter_active.png'),
    text: 'Letter',
    path: '/',
  ),
  Tab(
    icon: Image.asset('assets/icons/bottom-bar/diary.png'),
    iconActive: Image.asset('assets/icons/bottom-bar/diary_active.png'),
    text: 'Diary',
    path: '/',
  ),
  Tab(
    icon: Image.asset('assets/icons/bottom-bar/event.png'),
    iconActive: Image.asset('assets/icons/bottom-bar/event_active.png'),
    text: 'Event',
    path: '/',
  ),
  Tab(
    icon: Image.asset('assets/icons/bottom-bar/profile.png'),
    iconActive: Image.asset('assets/icons/bottom-bar/profile_active.png'),
    text: 'Profile',
    path: '/',
  ),
];

class BottomTabs extends StatefulWidget {
  const BottomTabs({super.key});

  @override
  State<BottomTabs> createState() => _BottomTabs();
}

class _BottomTabs extends State<BottomTabs> {
  int indexActive = 0;
  String tabName = bottomButtons[0].text;

  void changeIndexActive(int index) {
    setState(() {
      indexActive = index;
    });

    // context.go(location)
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // color: Colors.green,
        border: Border(
            top: BorderSide(
                width: 1, color: Color.fromARGB(255, 169, 197, 211))),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...[
            ...bottomButtons.map((button) {
              final isActive = button.text == tabName;
              print('active:  + $isActive');
              return TextButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  setState(() {
                    tabName = button.text;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isActive ? button.iconActive : button.icon,
                    Text(
                      button.text,
                      style: isActive
                          ? TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )
                          : TextStyle(
                              color: HexColor('#A3A5AE'),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                    ),
                  ],
                ),
                // child: Text(e.text),
              );
            }).toList()
          ].expand((element) => [
                Expanded(child: element),
              ]),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  void logout(BuildContext context) {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   bottom: const TabBar(tabs: [
      //     Tab(icon: Icon(Icons.directions_car)),
      //     Tab(icon: Icon(Icons.directions_transit)),
      //     Tab(icon: Icon(Icons.directions_bike)),
      //   ]),
      // ),
      body: Padding(
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
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await removeLocalVariable(LocalKeyCustom.user);
                        await removeLocalVariable(LocalKeyCustom.token);

                        if (!context.mounted) return;
                        logout(context);
                      },
                      child: const Text('Log out'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // context.pushNamed('edit_profile_screen');
                        context.push(
                          '/edit',
                          extra: jsonEncode(model.userProvider),
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
            );
          },
          child: const Text('HOME SCREEN'),
        ),
      ),
      bottomNavigationBar: const BottomTabs(),
      // bottomNavigationBar: const TabBar(tabs: [
      //   Tab(icon: Icon(Icons.directions_car)),
      //   Tab(icon: Icon(Icons.directions_transit)),
      //   Tab(icon: Icon(Icons.directions_bike)),
      // ]),
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
