// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:isar/isar.dart';

part 'setting.g.dart';

@collection
class Setting {
  Id id = Isar.autoIncrement;
  String key;
  String value;

  Setting({
    required this.key,
    required this.value,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        key: json['key'] as String,
        value: json['value'] as String,
      );
  
  factory Setting.fromRawJson(String rawJson) => Setting.fromJson(jsonDecode(rawJson));

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };
  
  @override
  String toString() {
    return jsonEncode(toJson());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Setting &&
      other.key == key &&
      other.value == value;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode;
}
