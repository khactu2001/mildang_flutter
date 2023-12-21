import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/provider/authen_provider.dart';
import 'package:flutter_mildang/provider/change_notifier_provider.dart';
import 'package:flutter_mildang/screens/edit_profile_screen.dart';
import 'package:flutter_mildang/screens/home_screen.dart';
import 'package:flutter_mildang/screens/newsletter/newsletter_list.dart';
import 'package:flutter_mildang/utils/utilities.dart';
import 'package:flutter_mildang/widgets/bottom-tab/bottom_tabs.dart';
import 'package:provider/provider.dart';

class MyScaffold extends StatefulWidget {
  const MyScaffold({
    super.key,
  });

  @override
  State<MyScaffold> createState() => MyScaffoldState();
}

class MyScaffoldState extends State<MyScaffold> {
  String tabName = '/newsletter';
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();

    _loadUser();
  }

  Future<void> _loadUser() async {
    final Map<String, dynamic>? token =
        await getLocalVariable(LocalKeyCustom.token);
    final Map<String, dynamic>? userCheck =
        await getLocalVariable(LocalKeyCustom.user);
    print('user loaded from local: $userCheck');
    if (userCheck == null || token == null) {
      return;
    }
    try {
      UserModel userLocal = UserModel.fromJson(userCheck);

      if (mounted) {
        Provider.of<UserProvider>(context, listen: false)
            .updateUserProvider(userLocal);
        Provider.of<AuthenProvider>(context, listen: false)
            .setAuthenticated(true);
      }
    } catch (e) {
      print('${e.toString()}');
      // await removeLocalVariable(LocalKeyCustom.user);
      // await removeLocalVariable(LocalKeyCustom.token);
    }
  }

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
    // const HomeScreen(),
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
