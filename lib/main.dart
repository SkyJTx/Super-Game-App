import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sga/client/constant/theme.dart';
import 'package:sga/client/controller/main_page/main_page_bloc.dart';
import 'package:sga/client/controller/theme/theme_bloc.dart';
import 'package:sga/client/presentation/main_page.dart';
import 'package:sga/dependencies_injector.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(BlocProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
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
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return BlocBuilder<ThemeProvider, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            home: SelectionArea(
              child: BlocProvider(
                create: (context) => MainBloc(),
                child: const MainPage(),
              ),
            ),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state,
            debugShowCheckedModeBanner: false,
            themeAnimationCurve: Curves.easeInOutCubicEmphasized,
            themeAnimationDuration: const Duration(milliseconds: 1000),
          );
        },
      );
    });
  }
}
