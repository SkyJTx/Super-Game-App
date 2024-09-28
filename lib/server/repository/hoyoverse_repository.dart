import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:sga/server/api.dart';
import 'package:sga/server/component/exception.dart';
import 'package:sga/server/constant/hoyoverse/details.dart';
import 'package:sga/server/data_model/hoyoverse/daily_login/check/check_response.dart';
import 'package:sga/server/data_model/hoyoverse/daily_login/claim/claim_response.dart';
import 'package:sga/server/data_model/hoyoverse/daily_login/daily_login_internal_response.dart';
import 'package:sga/server/repository/settings_repository.dart';
import 'package:workmanager/workmanager.dart';

class HoYoverseRepository {
  final _api = Api(client: HoYoverseRepository._client);
  final taskName = 'auto_daily_login';
  final workTag = 'AutoDailyLogin';

  static final Client _client = Client();

  static final instance = HoYoverseRepository._internal();

  factory HoYoverseRepository() {
    return instance;
  }

  HoYoverseRepository._internal();

  static HoYoverseRepository of(BuildContext context) {
    return RepositoryProvider.of<HoYoverseRepository>(context);
  }

  Future<ClaimResponse> claimDailyReward(HoYoverseGame game) async {
    final ltuid = await SettingsRepository.hoyoverseLTUID.get();
    final ltoken = await SettingsRepository.hoyoverseLToken.get();
    final deviceId = await SettingsRepository.hoyoverseDeviceId.get();
    if (ltuid.isEmpty || ltoken.isEmpty || deviceId.isEmpty) {
      throw Exception('HoYoverse credentials are not set');
    }
    final header = {
      'accept': 'application/json, text/plain, */*',
      'accept-language': 'en-US',
      'content-type': 'application/json;charset=UTF-8',
      'cookie': 'ltuid_v2=$ltuid; ltoken_v2=$ltoken',
      'origin': 'https://act.hoyolab.com',
      'referer': 'https://act.hoyolab.com/',
      'sec-ch-ua': '"Not/A)Brand";v="99", "Google Chrome";v="115", "Chromium";v="115"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': 'Windows',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-site',
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
      'x-rpc-app_version': '',
      'x-rpc-device_id': deviceId,
      'x-rpc-device_name': '',
      'x-rpc-platform': '4',
    };
    final body = {'act_id': game.dailyLoginActIdValue};

    final res = await _api.post(
      header,
      game.checkinUrlValue,
      body,
    );

    if (res.statusCode == HttpStatus.ok) {
      switch (game) {
        case HoYoverseGame.honkaiImpact3rd:
          final body = HonkaiImpact3rdClaimResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              body.message,
              body.retcode,
            );
          }
          return body;
        case HoYoverseGame.genshinImpact:
          final body = GenshinImpactClaimResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              body.message,
              body.retcode,
            );
          } else if (body.data!.gtResult.isRisk) {
            throw ResponseException(
              'Error: ${body.retcode}, Captcha is Required',
              res.statusCode,
            );
          }
          return body;
        case HoYoverseGame.tearsOfThemis:
          final body = TearsOfThemisClaimResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              body.message,
              body.retcode,
            );
          } else if (body.data!.isRisk) {
            throw ResponseException(
              'Captcha is Required',
              body.data!.riskCode,
            );
          }
          return body;
        case HoYoverseGame.honkaiStarRail:
          final body = HonkaiStarRailClaimResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              body.message,
              body.retcode,
            );
          } else if (body.data!.isRisk) {
            throw ResponseException(
              'Captcha is Required',
              body.data!.riskCode,
            );
          }
          return body;
        case HoYoverseGame.zenlessZoneZero:
          final body = ZenlessZoneZeroClaimResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              body.message,
              body.retcode,
            );
          } else if (body.data!.isRisk) {
            throw ResponseException(
              'Captcha is Required',
              body.data!.riskCode,
            );
          }
          return body;
        default:
          throw ResponseException(
            'Error: ${game.dailyLoginActIdValue}, Unknown Event',
            res.statusCode,
          );
      }
    } else {
      throw ResponseException(
        res.reasonPhrase ?? 'Error from ${game.checkinUrlValue}',
        res.statusCode,
      );
    }
  }

  Future<CheckResponse> checkDailyReward(HoYoverseGame event) async {
    final ltuid = await SettingsRepository.hoyoverseLTUID.get();
    final ltoken = await SettingsRepository.hoyoverseLToken.get();
    final header = {
      'accept': 'application/json, text/plain, */*',
      'accept-language': 'en-US',
      'content-type': 'application/json;charset=UTF-8',
      'cookie': 'ltuid_v2=$ltuid; ltoken_v2=$ltoken',
      'origin': 'https://act.hoyolab.com',
      'referer': 'https://act.hoyolab.com/',
      'sec-ch-ua': '"Not/A)Brand";v="99", "Google Chrome";v="115", "Chromium";v="115"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': 'Windows',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-site',
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
    };

    final res = await _api.get(
      header,
      event.infoUrlValue,
    );

    if (res.statusCode == HttpStatus.ok) {
      switch (event) {
        case HoYoverseGame.honkaiImpact3rd:
          final body = HonkaiImpact3rdCheckResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              body.message,
              body.retcode,
            );
          }
          return body;
        case HoYoverseGame.genshinImpact:
          final body = GenshinImpactCheckResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              body.message,
              body.retcode,
            );
          }
          return body;
        case HoYoverseGame.tearsOfThemis:
          final body = TearsOfThemisCheckResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              body.message,
              body.retcode,
            );
          }
          return body;
        case HoYoverseGame.honkaiStarRail:
          final body = HonkaiStarRailCheckResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              body.message,
              body.retcode,
            );
          }
          return body;
        case HoYoverseGame.zenlessZoneZero:
          final body = ZenlessZoneZeroCheckResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              body.message,
              body.retcode,
            );
          }
          return body;
        default:
          throw ResponseException(
            'Error: ${event.dailyLoginActIdValue}, Unknown Event',
            res.statusCode,
          );
      }
    } else {
      throw ResponseException(
        res.reasonPhrase ?? 'Error from ${event.infoUrlValue}',
        res.statusCode,
      );
    }
  }

  Future<DailyLoginInternalResponse> fullDailyLogin(HoYoverseGame game) async {
    try {
      switch (game) {
        case HoYoverseGame.honkaiImpact3rd:
          final check = await checkDailyReward(game) as HonkaiImpact3rdCheckResponse;
          if (check.data == null) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Error: ${check.retcode}',
              isSign: false,
            );
          } else if (check.data!.isSign) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Already Signed In',
              isSign: true,
            );
          }

          final claim = await claimDailyReward(game) as HonkaiImpact3rdClaimResponse;
          if (claim.data == null) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Error: ${claim.retcode}',
              isSign: false,
            );
          }
          return DailyLoginInternalResponse(
            success: true,
            message: 'Success on Daily Checkin',
            isSign: true,
          );
        case HoYoverseGame.genshinImpact:
          final check = await checkDailyReward(game) as GenshinImpactCheckResponse;
          if (check.data == null) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Error: ${check.retcode}',
              isSign: false,
            );
          } else if (check.data!.isSign) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Already Signed In',
              isSign: true,
            );
          }

          final claim = await claimDailyReward(game) as GenshinImpactClaimResponse;
          if (claim.data == null) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Error: ${claim.retcode}',
              isSign: false,
            );
          } else if (claim.data!.gtResult.isRisk) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Captcha is Required',
              isSign: false,
            );
          }
          return DailyLoginInternalResponse(
            success: true,
            message: check.message,
            isSign: true,
          );
        case HoYoverseGame.tearsOfThemis:
          final check = await checkDailyReward(game) as TearsOfThemisCheckResponse;
          if (check.data == null) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Error: ${check.retcode}',
              isSign: false,
            );
          } else if (check.data!.isSign) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Already Signed In',
              isSign: true,
            );
          }

          final claim = await claimDailyReward(game) as TearsOfThemisClaimResponse;
          if (claim.data == null) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Error: ${claim.retcode}',
              isSign: false,
            );
          } else if (claim.data!.isRisk) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Captcha is Required',
              isSign: false,
            );
          }

          return DailyLoginInternalResponse(
            success: true,
            message: 'Success on Daily Checkin',
            isSign: true,
          );
        case HoYoverseGame.honkaiStarRail:
          final check = await checkDailyReward(game) as HonkaiStarRailCheckResponse;
          if (check.data == null) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Error: ${check.retcode}',
              isSign: false,
            );
          } else if (check.data!.isSign) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Already Signed In',
              isSign: true,
            );
          }

          final claim = await claimDailyReward(game) as HonkaiStarRailClaimResponse;
          if (claim.data == null) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Error: ${claim.retcode}',
              isSign: false,
            );
          } else if (claim.data!.isRisk) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Captcha is Required',
              isSign: false,
            );
          }

          return DailyLoginInternalResponse(
            success: true,
            message: 'Success on Daily Checkin',
            isSign: true,
          );
        case HoYoverseGame.zenlessZoneZero:
          final check = await checkDailyReward(game) as ZenlessZoneZeroCheckResponse;
          if (check.data == null) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Error: ${check.retcode}',
              isSign: false,
            );
          } else if (check.data!.isSign) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Already Signed In',
              isSign: true,
            );
          }

          final claim = await claimDailyReward(game) as ZenlessZoneZeroClaimResponse;
          if (claim.data == null) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Error: ${claim.retcode}',
              isSign: false,
            );
          } else if (claim.data!.isRisk) {
            return DailyLoginInternalResponse(
              success: false,
              message: 'Captcha is Required',
              isSign: false,
            );
          }

          return DailyLoginInternalResponse(
            success: true,
            message: 'Success on Daily Checkin',
            isSign: true,
          );
        default:
          throw ResponseException(
            'Error: ${game.dailyLoginActIdValue}, Unknown Event',
            404,
          );
      }
    } catch (e) {
      return DailyLoginInternalResponse(
        success: false,
        message: e.toString(),
        isSign: false,
      );
    }
  }

  Future<Map<HoYoverseGame, DailyLoginInternalResponse>> autoDailyLogin() async {
    late final bool isHonkaiImpact3rd;
    late final bool isGenshinImpact;
    late final bool isTearsOfThemis;
    late final bool isHonkaiStarRail;
    late final bool isZenlessZoneZero;

    await Future.wait([
      SettingsRepository.honkaiImpact3rdDailyCheckin
          .get()
          .then((value) => isHonkaiImpact3rd = bool.tryParse(value) ?? false),
      SettingsRepository.genshinImpactDailyCheckin
          .get()
          .then((value) => isGenshinImpact = bool.tryParse(value) ?? false),
      SettingsRepository.tearsOfThemisDailyCheckin
          .get()
          .then((value) => isTearsOfThemis = bool.tryParse(value) ?? false),
      SettingsRepository.honkaiStarRailDailyCheckin
          .get()
          .then((value) => isHonkaiStarRail = bool.tryParse(value) ?? false),
      SettingsRepository.zenlessZoneZeroDailyCheckin
          .get()
          .then((value) => isZenlessZoneZero = bool.tryParse(value) ?? false),
    ]);

    final Map<HoYoverseGame, DailyLoginInternalResponse> dailyLogin = {};

    await Future.wait([
      if (isHonkaiImpact3rd)
        Future.delayed(Duration.zero)
            .then((value) => fullDailyLogin(HoYoverseGame.honkaiImpact3rd))
            .then((value) => dailyLogin[HoYoverseGame.honkaiImpact3rd] = value),
      if (isGenshinImpact)
        Future.delayed(const Duration(seconds: 1))
            .then((value) => fullDailyLogin(HoYoverseGame.genshinImpact))
            .then((value) => dailyLogin[HoYoverseGame.genshinImpact] = value),
      if (isTearsOfThemis)
        Future.delayed(const Duration(seconds: 2))
            .then((value) => fullDailyLogin(HoYoverseGame.tearsOfThemis))
            .then((value) => dailyLogin[HoYoverseGame.tearsOfThemis] = value),
      if (isHonkaiStarRail)
        Future.delayed(const Duration(seconds: 3))
            .then((value) => fullDailyLogin(HoYoverseGame.honkaiStarRail))
            .then((value) => dailyLogin[HoYoverseGame.honkaiStarRail] = value),
      if (isZenlessZoneZero)
        Future.delayed(const Duration(seconds: 4))
            .then((value) => fullDailyLogin(HoYoverseGame.zenlessZoneZero))
            .then((value) => dailyLogin[HoYoverseGame.zenlessZoneZero] = value),
    ]);

    return dailyLogin;
  }

  Future<void> setAutoCheckinTask(TimeOfDay? time) async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      return;
    }

    if (time == null) {
      await Workmanager().cancelByTag(workTag);
      return;
    } else {
      await Workmanager().cancelByTag(workTag);
      final currentTimeofDay = TimeOfDay.now();
      await Workmanager().registerPeriodicTask(
        '1',
        taskName,
        tag: workTag,
        initialDelay: Duration(
          hours: (time.hour - currentTimeofDay.hour) % 24,
          minutes: (time.minute - currentTimeofDay.minute) % 60,
        ),
        frequency: const Duration(hours: 24),
        constraints: Constraints(
          networkType: NetworkType.connected,
          requiresCharging: false,
        ),
        backoffPolicyDelay: const Duration(minutes: 1),
      );
    }
  }
}
