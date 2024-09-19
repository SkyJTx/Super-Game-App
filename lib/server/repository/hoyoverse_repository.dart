import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:sga/server/api.dart';
import 'package:sga/server/component/exception.dart';
import 'package:sga/server/constant/hoyoverse/details.dart';
import 'package:sga/server/data_model/hoyoverse/daily_login/check/check_response.dart';
import 'package:sga/server/data_model/hoyoverse/daily_login/claim/claim_response.dart';
import 'package:sga/server/repository/settings_repository.dart';

class HoYoverseRepository {
  late Api _api;

  HoYoverseRepository({
    Client? client,
  }) {
    _api = Api(client: client);
  }

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
      log('${game.dailyLoginActIdValue} ${res.body}');
      switch (game) {
        case HoYoverseGame.honkaiImpact3rd:
          final body = HonkaiImpact3rdClaimResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              'Error: ${game.dailyLoginActIdValue}, ${body.message}',
              res.statusCode,
            );
          }
          return body;
        case HoYoverseGame.genshinImpact:
          final body = GenshinImpactClaimResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              'Error: ${body.retcode}, ${body.message}',
              res.statusCode,
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
              'Error: ${body.retcode}, ${body.message}',
              res.statusCode,
            );
          } else if (body.data!.isRisk) {
            throw ResponseException(
              'Error: ${body.retcode}, Captcha is Required',
              res.statusCode,
            );
          }
          return body;
        case HoYoverseGame.honkaiStarRail:
          final body = HonkaiStarRailClaimResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              'Error: ${body.retcode}, ${body.message}',
              res.statusCode,
            );
          } else if (body.data!.isRisk) {
            throw ResponseException(
              'Error: ${body.retcode}, Captcha is Required',
              res.statusCode,
            );
          }
          return body;
        case HoYoverseGame.zenlessZoneZero:
          final body = ZenlessZoneZeroClaimResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              'Error: ${body.retcode}, ${body.message}',
              res.statusCode,
            );
          } else if (body.data!.isRisk) {
            throw ResponseException(
              'Error: ${body.retcode}, Captcha is Required',
              res.statusCode,
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
      log('${event.dailyLoginActIdValue} ${res.body}');
      switch (event) {
        case HoYoverseGame.honkaiImpact3rd:
          final body = HonkaiImpact3rdCheckResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              'Error: ${event.dailyLoginActIdValue}, ${body.message}',
              res.statusCode,
            );
          }
          return body;
        case HoYoverseGame.genshinImpact:
          final body = GenshinImpactCheckResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              'Error: ${event.dailyLoginActIdValue}, ${body.message}',
              res.statusCode,
            );
          }
          return body;
        case HoYoverseGame.tearsOfThemis:
          final body = TearsOfThemisCheckResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              'Error: ${event.dailyLoginActIdValue}, ${body.message}',
              res.statusCode,
            );
          }
          return body;
        case HoYoverseGame.honkaiStarRail:
          final body = HonkaiStarRailCheckResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              'Error: ${event.dailyLoginActIdValue}, ${body.message}',
              res.statusCode,
            );
          }
          return body;
        case HoYoverseGame.zenlessZoneZero:
          final body = ZenlessZoneZeroCheckResponse.fromJson(res.body);
          if (body.retcode != 0 || body.data == null) {
            throw ResponseException(
              'Error: ${event.dailyLoginActIdValue}, ${body.message}',
              res.statusCode,
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
}
