// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

part 'genshin_impact.dart';
part 'honkai_impact_3rd.dart';
part 'honkai_star_rail.dart';
part 'tears_of_themis.dart';
part 'zenless_zone_zero.dart';

class ClaimResponse {
  int retcode;
  String message;

  ClaimResponse({
    required this.retcode,
    required this.message,
  });

  ClaimResponse copyWith({
    int? retcode,
    String? message,
  }) {
    return ClaimResponse(
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

  factory ClaimResponse.fromMap(Map<String, dynamic> map) {
    return ClaimResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClaimResponse.fromJson(String source) =>
      ClaimResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ClaimResponse(retcode: $retcode, message: $message)';

  @override
  bool operator ==(covariant ClaimResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.retcode == retcode &&
      other.message == message;
  }

  @override
  int get hashCode => retcode.hashCode ^ message.hashCode;
}
