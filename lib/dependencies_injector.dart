import 'package:flutter/foundation.dart';
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

  final getit = GetIt.instance;

  getit.registerSingleton<Isar>(isar);
}
