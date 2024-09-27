import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sga/server/data_model/setting.dart';
import 'package:sga/server/repository/settings_repository.dart';
import 'package:uuid/uuid.dart';

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

  final getit = GetIt.instance;

  getit.registerSingleton<Isar>(isar);
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
