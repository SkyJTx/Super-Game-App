import 'package:isar/isar.dart';
import 'package:sga/server/data_model/setting.dart';

enum SettingsRepository {
  hoyoverseLTUID('hoyoverse_ltuid', '', String),
  hoyoverseLToken('hoyoverse_ltoken', '', String),
  hoyoverseDeviceId('hoyoverse_device_id', '', String),
  honkaiImpact3rdDailyCheckin('honkai_impact_3rd_auto_daily_checkin', 'false', bool, options: ['true', 'false']),
  tearsOfThemisDailyCheckin('tears_of_themis_auto_daily_checkin', 'false', bool, options: ['true', 'false']),
  genshinImpactDailyCheckin('genshin_impact_auto_daily_checkin', 'false', bool, options: ['true', 'false']),
  honkaiStarRailDailyCheckin('honkai_star_rail_auto_daily_checkin', 'false', bool, options: ['true', 'false']),
  zenlessZoneZeroDailyCheckin('zenless_zone_zero_auto_daily_checkin', 'false', bool, options: ['true', 'false']),
  theme('theme', 'system', String, options: ['system', 'light', 'dark']),
  checkinTime('checkin_time', '', String),
  ;

  const SettingsRepository(
    this.key,
    this.defaultValue,
    this.type, {
    this.options,
  });

  final String key;
  final String defaultValue;
  final Type type;
  final List<String>? options;

  static Isar get instance {
    final isarInstance = Isar.getInstance();
    if (isarInstance == null) {
      throw Exception('Isar instance is not initialized');
    }
    return isarInstance;
  }

  static IsarCollection<Setting> get table => instance.settings;

  static Future<void> init() async {
    await instance.writeTxn(() async {
      for (final setting in SettingsRepository.values) {
        final existingSetting =
            await instance.settings.filter().keyEqualTo(setting.key).findFirst();
        if (existingSetting == null) {
          instance.settings.put(Setting(key: setting.key, value: setting.defaultValue));
        }
      }
    });
  }

  Future<String> get() async {
    return instance.txn(() async {
      final setting = await instance.settings.filter().keyEqualTo(key).findFirst();
      return setting?.value ?? defaultValue;
    });
  }

  Future<void> set(String value) async {
    await instance.writeTxn(() async {
      final setting = await instance.settings.filter().keyEqualTo(key).findFirst();
      if (setting == null) {
        instance.settings.put(Setting(key: key, value: value));
      } else {
        setting.value = value;
        instance.settings.put(setting);
      }
    });
  }

  Future<void> reset() async {
    await instance.writeTxn(() async {
      final setting = await instance.settings.filter().keyEqualTo(key).findFirst();
      if (setting != null) {
        instance.settings.put(setting..value = defaultValue);
      } else {
        instance.settings.put(Setting(key: key, value: defaultValue));
      }
    });
  }
}
