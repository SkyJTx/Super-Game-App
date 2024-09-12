import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:sga/server/api.dart';
import 'package:sga/server/component/exception.dart';
import 'package:sga/server/constant/hoyoverse/request_event.dart';
import 'package:sga/server/data_model/hoyoverse/response/check_response.dart';
import 'package:sga/server/data_model/hoyoverse/response/claim_response.dart';
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

  Future<ClaimResponse> claimDailyReward(RequestEvent event) async {
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
    final body = {'act_id': event.actIdValue};

    final res = await _api.post(
      header,
      event.checkinUrlValue,
      body,
    );

    if (res.statusCode == HttpStatus.ok) {
      log('${event.actId.toString()} ${res.body}');
      final data = ClaimResponse.fromJson(res.body);
      if (data.retcode != 0) {
        throw ResponseException(
          'Error: ${event.actIdValue}, ${data.message}',
          res.statusCode,
        );
      }
      if (data.data != null && data.data!.isRisk) {
        throw ResponseException(
          'Captcha Required: ${event.actIdValue}, ${data.data!.challenge}',
          res.statusCode,
        );
      }
      return data;
    } else {
      throw ResponseException(
        res.reasonPhrase ?? 'Error from ${event.checkinUrlValue}',
        res.statusCode,
      );
    }
  }

  Future<CheckResponse> check(RequestEvent event) async {
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
      log('${event.actId.toString()} ${res.body}');
      final data = CheckResponse.fromJson(res.body);
      if (data.retcode != 0) {
        throw ResponseException(
          'Error: ${event.actIdValue}, ${data.message}',
          res.statusCode,
        );
      }
      return data;
    } else {
      throw ResponseException(
        res.reasonPhrase ?? 'Error from ${event.infoUrlValue}',
        res.statusCode,
      );
    }
  }
}
