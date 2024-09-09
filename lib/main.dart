import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sga/client/constant/theme.dart';
import 'package:sga/client/controller/main_page/main_page_bloc.dart';
import 'package:sga/client/controller/theme/theme_bloc.dart';
import 'package:sga/client/presentation/main_page.dart';

void main() {
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
    return BlocBuilder<ThemeProvider, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          home: BlocProvider(
            create: (context) => MainBloc(),
            child: const MainPage(),
          ),
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state,
        );
      },
    );
  }
}
