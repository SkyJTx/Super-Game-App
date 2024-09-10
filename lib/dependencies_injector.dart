import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sga/server/data_model/setting.dart';

Future<void> init() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [SettingSchema],
    directory: dir.path,
    inspector: kDebugMode,
  );
  final getit = GetIt.instance;

  getit.registerSingleton<Isar>(isar);
}
