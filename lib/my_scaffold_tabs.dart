import 'package:flutter/material.dart';
import 'package:flutter_mildang/screens/edit_profile_screen.dart';
import 'package:flutter_mildang/screens/home_screen.dart';
import 'package:flutter_mildang/screens/newsletter/newsletter_list.dart';
import 'package:flutter_mildang/widgets/bottom-tab/bottom_tabs.dart';

class MyScaffold extends StatefulWidget {
  const MyScaffold({
    super.key,
  });

  @override
  State<MyScaffold> createState() => MyScaffoldState();
}

class MyScaffoldState extends State<MyScaffold> {
  String tabName = '/';
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomTabs(
        tabName: tabName,
        navigateTo: (path, index) {
          setState(() {
            tabName = path;
            currentTabIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildBody() {
    return TabNavigator(
      tabName: tabName,
      currentTabIndex: currentTabIndex,
    );
  }
}

class TabNavigator extends StatelessWidget {
  TabNavigator(
      {super.key, required this.tabName, required this.currentTabIndex});
  final String tabName;
  final int currentTabIndex;

  final List<Widget> _screens = [
    const HomeScreen(),
    const NewsletterListScreen(),
    const EditProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentTabIndex],
    );
  }
}
