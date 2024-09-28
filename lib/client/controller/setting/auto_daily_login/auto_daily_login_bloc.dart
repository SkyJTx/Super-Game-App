import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sga/server/repository/hoyoverse_repository.dart';
import 'package:sga/server/repository/settings_repository.dart';

part 'auto_daily_login_state.dart';

enum AutoDailyLoginGame {
  honkaiImpact3rd,
  tearsOfThemis,
  genshinImpact,
  honkaiStarRail,
  zenlessZoneZero,
}

class AutoDailyLoginBloc extends Cubit<AutoDailyLoginState> {
  AutoDailyLoginBloc()
      : super(
          AutoDailyLoginState(
            isGlobalAutoDailyLogin: false,
            isHI3AutoDailyLogin: false,
            isToTAutoDailyLogin: false,
            isGIAutoDailyLogin: false,
            isHSRAutoDailyLogin: false,
            isZZZAutoDailyLogin: false,
            enableHI3AutoDailyLogin: false,
            enableToTAutoDailyLogin: false,
            enableGIAutoDailyLogin: false,
            enableHSRAutoDailyLogin: false,
            enableZZZAutoDailyLogin: false,
          ),
        );

  Future<void> init() async {
    final prevState = state.copyWith();
    try {
      SettingsRepository.checkinTime.get().then((value) {
        final parsedDateTime = DateTime.tryParse(value);
        if (parsedDateTime != null) {
          emit(state.copyWith(
            checkTime: TimeOfDay.fromDateTime(parsedDateTime),
          ));
        }
      });
      List<bool?> getResult = await Future.wait([
        SettingsRepository.honkaiImpact3rdDailyCheckin.get(),
        SettingsRepository.tearsOfThemisDailyCheckin.get(),
        SettingsRepository.genshinImpactDailyCheckin.get(),
        SettingsRepository.honkaiStarRailDailyCheckin.get(),
        SettingsRepository.zenlessZoneZeroDailyCheckin.get(),
      ]).then(
        (v) {
          return v.map(bool.tryParse).toList();
        },
      );
      emit(
        state.copyWith(
          isHI3AutoDailyLogin: getResult[0],
          isToTAutoDailyLogin: getResult[1],
          isGIAutoDailyLogin: getResult[2],
          isHSRAutoDailyLogin: getResult[3],
          isZZZAutoDailyLogin: getResult[4],
          enableHI3AutoDailyLogin: getResult[0] ?? false,
          enableToTAutoDailyLogin: getResult[1] ?? false,
          enableGIAutoDailyLogin: getResult[2] ?? false,
          enableHSRAutoDailyLogin: getResult[3] ?? false,
          enableZZZAutoDailyLogin: getResult[4] ?? false,
        ),
      );
      final boolList = [
        state.isHI3AutoDailyLogin,
        state.isToTAutoDailyLogin,
        state.isGIAutoDailyLogin,
        state.isHSRAutoDailyLogin,
        state.isZZZAutoDailyLogin,
      ];
      if (boolList.every((e) => e)) {
        emit(state.copyWith(
          isGlobalAutoDailyLogin: true,
        ));
      } else if (boolList.every((e) => !e)) {
        emit(state.copyWith(
          isGlobalAutoDailyLogin: false,
        ));
      }
    } catch (e, s) {
      log('$e', error: e, stackTrace: s);
      emit(prevState);
    }
  }

  Future<void> setGlobalAutoDailyLogin(bool value) async {
    final prevState = state.copyWith();
    try {
      emit(state.copyWith(
        isGlobalAutoDailyLogin: value,
        isHI3AutoDailyLogin: value,
        isToTAutoDailyLogin: value,
        isGIAutoDailyLogin: value,
        isHSRAutoDailyLogin: value,
        isZZZAutoDailyLogin: value,
        enableHI3AutoDailyLogin: false,
        enableToTAutoDailyLogin: false,
        enableGIAutoDailyLogin: false,
        enableHSRAutoDailyLogin: false,
        enableZZZAutoDailyLogin: false,
      ));
      await Future.wait([
        SettingsRepository.honkaiImpact3rdDailyCheckin.set(value.toString()),
        SettingsRepository.tearsOfThemisDailyCheckin.set(value.toString()),
        SettingsRepository.genshinImpactDailyCheckin.set(value.toString()),
        SettingsRepository.honkaiStarRailDailyCheckin.set(value.toString()),
        SettingsRepository.zenlessZoneZeroDailyCheckin.set(value.toString()),
      ]);
      emit(state.copyWith(
        enableHI3AutoDailyLogin: true,
        enableToTAutoDailyLogin: true,
        enableGIAutoDailyLogin: true,
        enableHSRAutoDailyLogin: true,
        enableZZZAutoDailyLogin: true,
      ));
    } catch (e, s) {
      log('$e', error: e, stackTrace: s);
      emit(prevState);
    }
  }

  Future<void> Function(bool) setAutoDailyLogin(AutoDailyLoginGame game) {
    return (bool value) async {
      final prevState = state.copyWith();
      try {
        switch (game) {
          case AutoDailyLoginGame.honkaiImpact3rd:
            emit(state.copyWith(
              isHI3AutoDailyLogin: value,
              enableHI3AutoDailyLogin: false,
            ));
            await SettingsRepository.honkaiImpact3rdDailyCheckin.set(value.toString());
            emit(state.copyWith(
              enableHI3AutoDailyLogin: true,
            ));
            break;
          case AutoDailyLoginGame.tearsOfThemis:
            emit(state.copyWith(
              isToTAutoDailyLogin: value,
              enableToTAutoDailyLogin: false,
            ));
            await SettingsRepository.tearsOfThemisDailyCheckin.set(value.toString());
            emit(state.copyWith(
              enableToTAutoDailyLogin: true,
            ));
            break;
          case AutoDailyLoginGame.genshinImpact:
            emit(state.copyWith(
              isGIAutoDailyLogin: value,
              enableGIAutoDailyLogin: false,
            ));
            await SettingsRepository.genshinImpactDailyCheckin.set(value.toString());
            emit(state.copyWith(
              enableGIAutoDailyLogin: true,
            ));
            break;
          case AutoDailyLoginGame.honkaiStarRail:
            emit(state.copyWith(
              isHSRAutoDailyLogin: value,
              enableHSRAutoDailyLogin: false,
            ));
            await SettingsRepository.honkaiStarRailDailyCheckin.set(value.toString());
            emit(state.copyWith(
              enableHSRAutoDailyLogin: true,
            ));
            break;
          case AutoDailyLoginGame.zenlessZoneZero:
            emit(state.copyWith(
              isZZZAutoDailyLogin: value,
              enableZZZAutoDailyLogin: false,
            ));
            await SettingsRepository.zenlessZoneZeroDailyCheckin.set(value.toString());
            emit(state.copyWith(
              enableZZZAutoDailyLogin: true,
            ));
            break;
          default:
            break;
        }
        final boolList = [
          state.isHI3AutoDailyLogin,
          state.isToTAutoDailyLogin,
          state.isGIAutoDailyLogin,
          state.isHSRAutoDailyLogin,
          state.isZZZAutoDailyLogin,
        ];
        if (boolList.every((e) => e)) {
          emit(state.copyWith(
            isGlobalAutoDailyLogin: true,
          ));
        } else if (boolList.every((e) => !e)) {
          emit(state.copyWith(
            isGlobalAutoDailyLogin: false,
          ));
        }
      } catch (e, s) {
        log('$e', error: e, stackTrace: s);
        emit(prevState);
      }
    };
  }

  Future<void> setCheckinTime(TimeOfDay? time) async {
    HoYoverseRepository().setAutoCheckinTask(time);
    if (time != null) {
      SettingsRepository.checkinTime.set(
        DateTime(0, 0, 0, time.hour, time.minute).toIso8601String(),
      );
    }

    emit(state.copyWith(checkTime: time));
  }
}
