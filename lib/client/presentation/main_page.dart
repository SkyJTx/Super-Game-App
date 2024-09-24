import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sga/client/presentation/main_page/home_page.dart';
import 'package:sga/client/presentation/main_page/hoyoverse_page.dart';
import 'package:sga/client/presentation/main_page/setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.state,
    required this.child,
  });

  final GoRouterState state;
  final Widget child;

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didUpdateWidget(covariant MainPage oldWidget) {
    final old = context.canPop();
    super.didUpdateWidget(oldWidget);
    final current = context.canPop();
    if (old != current) {
      setState(() {});
    }
  }

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
        title: ListTile(
          title: Text(
            'SGA',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            widget.state.fullPath.toString(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              if (context.canPop()) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.pop();
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: widget.child,
      ),
    );
  }
}
