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

  void select(ThemeMode themeMode) async {
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

  void toggle() async {
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

  void reset() async {
    emit(ThemeMode.system);
    await SettingsRepository.theme.set('system');
  }
}
