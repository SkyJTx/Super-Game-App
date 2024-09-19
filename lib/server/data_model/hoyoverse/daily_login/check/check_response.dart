// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

part 'genshin_impact.dart';
part 'honkai_impact_3rd.dart';
part 'honkai_star_rail.dart';
part 'tears_of_themis.dart';
part 'zenless_zone_zero.dart';

class CheckResponse {
  int retcode;
  String message;

  CheckResponse({
    required this.retcode,
    required this.message,
  });

  CheckResponse copyWith({
    int? retcode,
    String? message,
  }) {
    return CheckResponse(
      retcode: retcode ?? this.retcode,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'retcode': retcode,
      'message': message,
    };
  }

  factory CheckResponse.fromMap(Map<String, dynamic> map) {
    return CheckResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckResponse.fromJson(String source) =>
      CheckResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CheckResponse(retcode: $retcode, message: $message)';

  @override
  bool operator ==(covariant CheckResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.retcode == retcode &&
      other.message == message;
  }

  @override
  int get hashCode => retcode.hashCode ^ message.hashCode;
}
