import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sga/server/repository/settings_repository.dart';

class ThemeProvider extends Cubit<ThemeMode> {
  ThemeProvider() : super(ThemeMode.system);

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
