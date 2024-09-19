import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sga/client/presentation/main_page/home_page.dart';
import 'package:sga/client/presentation/main_page/hoyoverse_page.dart';
import 'package:sga/client/presentation/main_page/kurogame._page.dart';
import 'package:sga/client/presentation/main_page/setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.child});

  final Widget child;

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                context.go(HomePage.routeName);
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              title: const Text('HoYoverse'),
              onTap: () {
                context.go(HoyoversePage.routeName);
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              title: const Text('Kuro Games'),
              onTap: () {
                context.go(KurogamePage.routeName);
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                context.go(SettingPage.routeName);
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('SGA'),
      ),
      body: SafeArea(
        child: widget.child,
      ),
    );
  }
}
