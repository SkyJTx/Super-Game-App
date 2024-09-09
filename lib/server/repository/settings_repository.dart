import 'package:isar/isar.dart';
import 'package:sga/server/data_model/setting.dart';

enum SettingsRepository {
  honkaiImpact3rdAccountId('honkai_impact_3rd_account_id', '', String),
  tearsOfThemisAccountId('tears_of_themis_account_id', '', String),
  genshinImpactAccountId('genshin_impact_account_id', '', String),
  honkaiStarRailAccountId('honkai_star_rail_account_id', '', String),
  zenlessZoneZeroAccountId('zenless_zone_zero_account_id', '', String),
  honkaiImpact3rdDailyCheckin('honkai_impact_3rd_daily_checkin', 'false', bool, options: ['true', 'false']),
  tearsOfThemisDailyCheckin('tears_of_themis_daily_checkin', 'false', bool, options: ['true', 'false']),
  genshinImpactDailyCheckin('genshin_impact_daily_checkin', 'false', bool, options: ['true', 'false']),
  honkaiStarRailDailyCheckin('honkai_star_rail_daily_checkin', 'false', bool, options: ['true', 'false']),
  zenlessZoneZeroDailyCheckin('zenless_zone_zero_daily_checkin', 'false', bool, options: ['true', 'false']),
  theme('theme', 'system', String, options: ['system', 'light', 'dark']),
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
