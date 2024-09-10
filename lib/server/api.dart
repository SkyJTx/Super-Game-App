import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sga/server/component/exception.dart';
import 'package:sga/server/constant/constant.dart';

class Api {
  final http.Client client;

  Api({http.Client? client}) : client = client ?? http.Client();

  Future<http.Response> get(
    Map<String, String> headers,
    String url,
  ) {
    return client
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
            'message': 'Internal Server Error from $url',
            'code': HttpStatus.internalServerError,
          }),
          HttpStatus.internalServerError,
        );
      },
    );
  }

  Future<http.Response> post(
    Map<String, String> headers,
    String url,
    dynamic body,
  ) {
    return client
        .post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
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
            'message': 'Internal Server Error from $url',
            'code': HttpStatus.internalServerError,
          }),
          HttpStatus.internalServerError,
        );
      },
    );
  }
}
