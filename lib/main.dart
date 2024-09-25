import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sga/client/constant/theme.dart';
import 'package:sga/client/presentation/main_page/home_page.dart';
import 'package:sga/client/presentation/main_page/hoyoverse_page.dart';
import 'package:sga/client/presentation/main_page/setting_page.dart';
import 'package:sga/client/presentation/main_page/setting_page/auto_daily_login_page.dart';
import 'package:sga/client/repository/global_repo.dart';
import 'package:sga/client/controller/theme/theme_bloc.dart';
import 'package:sga/client/presentation/main_page.dart';
import 'package:sga/dependencies_injector.dart';
import 'package:sga/server/repository/hoyoverse_repository.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => HoYoverseRepository()),
      RepositoryProvider(create: (context) => GlobalRepository()),
    ],
    child: BlocProvider(
      create: (context) => ThemeProvider()..init(),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Page<dynamic> Function(BuildContext, GoRouterState) goPageBuilder({
    required Widget Function(BuildContext context, GoRouterState state) builder,
  }) {
    return (BuildContext context, GoRouterState state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: builder(context, state),
        transitionDuration: 0.seconds,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Animate(
            effects: [
              FadeEffect(
                curve: Curves.easeInOutCubicEmphasized,
                duration: 0.5.seconds,
                begin: 0.0,
                end: 1.0,
              ),
              SlideEffect(
                curve: Curves.easeInOutCubicEmphasized,
                duration: 0.5.seconds,
                begin: const Offset(0.5, 0),
                end: const Offset(0, 0),
              ),
            ],
            child: child,
          );
        },
      );
    };
  }

  late final GoRouter router;

  @override
  void didChangeDependencies() {
    router = GoRouter(
      navigatorKey: GlobalRepository.of(context).navigatorKey,
      routes: [
        ShellRoute(
          pageBuilder: (context, state, child) {
            return MaterialPage(
              child: SelectionArea(
                child: MainPage(
                  state: state,
                  child: child,
                ),
              ),
            );
          },
          routes: [
            GoRoute(
              path: HomePage.routeName,
              pageBuilder: goPageBuilder(
                builder: (context, state) {
                  return const HomePage();
                },
              ),
            ),
            GoRoute(
              path: HoyoversePage.routeName,
              pageBuilder: goPageBuilder(
                builder: (context, state) {
                  return const HoyoversePage();
                },
              ),
            ),
            GoRoute(
              path: SettingPage.routeName,
              pageBuilder: goPageBuilder(
                builder: (context, state) {
                  return const SettingPage();
                },
              ),
              routes: [
                GoRoute(
                  path: AutoDailyLoginSettingPage.routeName,
                  pageBuilder: goPageBuilder(
                    builder: (context, state) {
                      return const AutoDailyLoginSettingPage();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final globalRepo = GlobalRepository.of(context);
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return BlocBuilder<ThemeProvider, ThemeMode>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: router,
              scaffoldMessengerKey: globalRepo.scaffoldMessengerKey,
              title: 'Flutter Demo',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: state,
              debugShowCheckedModeBanner: false,
              themeAnimationCurve: Curves.easeInOutCubicEmphasized,
              themeAnimationDuration: const Duration(milliseconds: 1000),
            );
          },
        );
      },
    );
  }
}
