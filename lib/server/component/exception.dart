import 'dart:convert';

class ResponseException {
  final String message;
  final int code;

  ResponseException(this.message, this.code);

  factory ResponseException.fromJson(Map<String, dynamic> json) {
    return ResponseException(
      json['message'] as String,
      json['code'] as int,
    );
  }

  factory ResponseException.fromRawJson(String rawJson) {
    return ResponseException.fromJson(jsonDecode(rawJson));
  }

  static bool contains(String rawJson) {
    final json = jsonDecode(rawJson);
    return json is Map<String, dynamic> && json.containsKey('message') && json.containsKey('code');
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
    };
  }

  @override
  String toString() {
    return message;
  }
}