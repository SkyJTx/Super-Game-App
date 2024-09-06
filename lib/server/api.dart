import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sga/server/component/exception.dart';
import 'package:sga/server/constant/constant.dart';

class Api {
  final http.Client client;

  Api({http.Client? client}) : client = client ?? http.Client();

  Future<String> get(
    Map<String, String> headers,
    String url,
  ) async {
    final response = await client
        .get(
      Uri.parse(url),
      headers: headers,
    )
        .timeout(
      timeoutLimit,
      onTimeout: () {
        return http.Response(
          jsonEncode({
            'message': 'Request Time Out from $url',
            'code': HttpStatus.requestTimeout,
          }),
          HttpStatus.requestTimeout,
        );
      },
    ).onError(
      (error, stackTrace) {
        return http.Response(
          jsonEncode({
            'message': 'Failed to get data from $url',
            'code': HttpStatus.internalServerError,
          }),
          HttpStatus.internalServerError,
        );
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    } else if (ResponseException.contains(response.body)) {
      throw ResponseException.fromRawJson(response.body);
    } else {
      throw ResponseException(
        'Failed to get data from $url',
        response.statusCode,
      );
    }
  }
}
