import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sga/client/controller/main_page/main_page_bloc.dart';
import 'package:sga/client/presentation/main_page/home_page.dart';
import 'package:sga/client/presentation/main_page/hoyoverse_page/hoyoverse_page.dart';
import 'package:sga/client/presentation/main_page/kurogame._page.dart';
import 'package:sga/client/presentation/main_page/setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MainBloc>(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                bloc.showHome();
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              title: const Text('HoYoverse'),
              onTap: () {
                bloc.showHoYoVerse();
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              title: const Text('Kuro Games'),
              onTap: () {
                bloc.showKuroGame();
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                bloc.showSettings();
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
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state is HomeState) {
              return const HomePage();
            } else if (state is HoYoverseState) {
              return const HoyoversePage();
            } else if (state is KuroGamesState) {
              return const KurogamePage();
            } else if (state is SettingsState) {
              return const SettingPage();
            }
            return const CircularProgressIndicator.adaptive();
          },
        ),
      ),
    );
  }
}
