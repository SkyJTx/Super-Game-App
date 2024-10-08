import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sga/server/repository/settings_repository.dart';

class ThemeProvider extends Cubit<ThemeMode> {
  ThemeProvider() : super(ThemeMode.system);

  static ThemeProvider? of(BuildContext context) {
    try {
      return BlocProvider.of<ThemeProvider>(context);
    } catch (e) {
      return null;
    }
  }

  Future<void> init() async {
    final theme = await SettingsRepository.theme.get();
    switch (theme) {
      case 'system':
        emit(ThemeMode.system);
        break;
      case 'light':
        emit(ThemeMode.light);
        break;
      case 'dark':
        emit(ThemeMode.dark);
        break;
      default:
        break;
    }
  }

  Future<void> select(ThemeMode themeMode) async {
    emit(themeMode);
    switch (themeMode) {
      case ThemeMode.system:
        await SettingsRepository.theme.set('system');
        break;
      case ThemeMode.light:
        await SettingsRepository.theme.set('light');
        break;
      case ThemeMode.dark:
        await SettingsRepository.theme.set('dark');
        break;
      default:
        break;
    }
  }

  Future<void> toggle() async {
    if (state == ThemeMode.system) {
      final systemBrightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      if (systemBrightness == Brightness.light) {
        emit(ThemeMode.dark);
        await SettingsRepository.theme.set('dark');
      } else {
        emit(ThemeMode.light);
        await SettingsRepository.theme.set('light');
      }
    } else {
      if (state == ThemeMode.dark) {
        emit(ThemeMode.light);
        await SettingsRepository.theme.set('light');
      } else {
        emit(ThemeMode.dark);
        await SettingsRepository.theme.set('dark');
      }
    }
  }

  Future<void> reset() async {
    emit(ThemeMode.system);
    await SettingsRepository.theme.set('system');
  }
}
