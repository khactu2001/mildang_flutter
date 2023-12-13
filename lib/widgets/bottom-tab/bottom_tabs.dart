import 'package:flutter/material.dart';
import 'package:flutter_mildang/utils/utilities.dart';

class Tab {
  const Tab({
    required this.icon,
    required this.text,
    required this.path,
    required this.iconActive,
    // required this.index,
  });

  final Image icon;
  final Image iconActive;
  final String text;
  final String path;
  // final int index;
}

final bottomButtons = [
  Tab(
    icon: Image.asset('assets/icons/bottom-bar/dr_post.png'),
    iconActive: Image.asset('assets/icons/bottom-bar/doctor_active.png'),
    text: 'Home',
    path: '/',
    // index: 0,
  ),
  Tab(
    icon: Image.asset('assets/icons/bottom-bar/newsletter.png'),
    iconActive: Image.asset('assets/icons/bottom-bar/newsletter_active.png'),
    text: 'Newsletter',
    path: '/signup',
  ),
  // Tab(
  //   icon: Image.asset('assets/icons/bottom-bar/diary.png'),
  //   iconActive: Image.asset('assets/icons/bottom-bar/diary_active.png'),
  //   text: 'Detail',
  //   path: '/detail',
  // ),
  // Tab(
  //   icon: Image.asset('assets/icons/bottom-bar/event.png'),
  //   iconActive: Image.asset('assets/icons/bottom-bar/event_active.png'),
  //   text: 'Login',
  //   path: '/login',
  // ),
  Tab(
    icon: Image.asset('assets/icons/bottom-bar/profile.png'),
    iconActive: Image.asset('assets/icons/bottom-bar/profile_active.png'),
    text: 'Profile',
    path: '/edit',
  ),
];

class BottomTabs extends StatelessWidget {
  const BottomTabs(
      {super.key, required this.navigateTo, required this.tabName});
  final void Function(String, int) navigateTo;
  final String tabName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey,
          ),
        ],
        border: Border(
          top: BorderSide(width: 1, color: Color.fromARGB(255, 169, 197, 211)),
        ),
      ),
      child: Row(
        children: [
          ...[
            ...bottomButtons.asMap().entries.map((entry) {
              final button = entry.value;
              final index = entry.key;
              final isActive = button.path == tabName;
              return TextButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  navigateTo(button.path, index);
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
              );
            }).toList()
          ].expand((element) => [
                Expanded(child: element),
              ]),
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return BottomNavigationBar(items: const [
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.home),
  //       label: 'Screen 1',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.search),
  //       label: 'Screen 2',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.person),
  //       label: 'Screen 3',
  //     ),
  //   ]);
  // }
}
