import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sga/server/data_model/setting.dart';
import 'package:sga/server/repository/hoyoverse_repository.dart';
import 'package:sga/server/repository/settings_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';

Future<void> init() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [SettingSchema],
    directory: dir.path,
    inspector: kDebugMode,
  );

  final deviceId = await SettingsRepository.hoyoverseDeviceId.get();
  if (deviceId.isEmpty) {
    await SettingsRepository.hoyoverseDeviceId.set(const Uuid().v4());
  }

  // await initLocalNotification();

  if (Platform.isAndroid || Platform.isIOS) {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );
  }

  final getit = GetIt.instance;

  getit.registerSingleton<Isar>(isar);
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == HoYoverseRepository().taskName) {
        await HoYoverseRepository().autoDailyLogin();
      }
      return true;
    } catch (e) {
      return false;
    }
  });
}

Future<void> initLocalNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
    onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) {},
  );
  const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (response) {},
    onDidReceiveBackgroundNotificationResponse: (response) {},
  );
}
