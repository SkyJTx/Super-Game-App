import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:sga/client/constant/theme.dart';
import 'package:sga/client/repository/global_repo.dart';
import 'package:sga/client/controller/main_page/main_page_bloc.dart';
import 'package:sga/client/controller/theme/theme_bloc.dart';
import 'package:sga/client/presentation/main_page.dart';
import 'package:sga/dependencies_injector.dart';
import 'package:sga/server/repository/hoyoverse_repository.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  final client = Client();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => HoYoverseRepository(client: client)),
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
  @override
  Widget build(BuildContext context) {
    final globalRepo = GlobalRepository.of(context);
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return BlocBuilder<ThemeProvider, ThemeMode>(
          builder: (context, state) {
            return MaterialApp(
              navigatorKey: globalRepo.navigatorKey,
              scaffoldMessengerKey: globalRepo.scaffoldMessengerKey,
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
      },
    );
  }
}

//! ApiActId.honkaiImpact3rd {"retcode":0,"message":"OK","data":{"code":"ok"}}
//! ApiActId.tearsOfThemis {"retcode":0,"message":"OK","data":{"code":"","risk_code":0,"gt":"","challenge":"","success":0,"is_risk":false}}
//! ApiActId.genshinImpact {"retcode":0,"message":"OK","data":{"code":"ok","first_bind":false,"gt_result":{"risk_code":0,"gt":"","challenge":"","success":0,"is_risk":false}}}
//! ApiActId.honkaiStarRail {"retcode":0,"message":"OK","data":{"code":"","risk_code":0,"gt":"","challenge":"","success":0,"is_risk":false}}
//! ApiActId.zenlessZoneZero {"retcode":0,"message":"OK","data":{"code":"","risk_code":0,"gt":"","challenge":"","success":0,"is_risk":false}}
 