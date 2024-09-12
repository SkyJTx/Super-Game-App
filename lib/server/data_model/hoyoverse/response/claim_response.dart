// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClaimResponse {
  int retcode;
  String message;
  ClaimData? data;

  ClaimResponse({
    required this.retcode,
    required this.message,
    required this.data,
  });

  ClaimResponse copyWith({
    int? retcode,
    String? message,
    ClaimData? data,
  }) {
    return ClaimResponse(
      retcode: retcode ?? this.retcode,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'retcode': retcode,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory ClaimResponse.fromMap(Map<String, dynamic> map) {
    return ClaimResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
      data: map['data'] != null ? ClaimData.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClaimResponse.fromJson(String source) =>
      ClaimResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ClaimResponse(retcode: $retcode, message: $message, data: $data)';

  @override
  bool operator ==(covariant ClaimResponse other) {
    if (identical(this, other)) return true;

    return other.retcode == retcode && other.message == message && other.data == data;
  }

  @override
  int get hashCode => retcode.hashCode ^ message.hashCode ^ data.hashCode;
}

class ClaimData {
  String code;
  int riskCode;
  String gt;
  String challenge;
  int success;
  bool isRisk;

  ClaimData({
    required this.code,
    required this.riskCode,
    required this.gt,
    required this.challenge,
    required this.success,
    required this.isRisk,
  });

  ClaimData copyWith({
    String? code,
    int? riskCode,
    String? gt,
    String? challenge,
    int? success,
    bool? isRisk,
  }) {
    return ClaimData(
      code: code ?? this.code,
      riskCode: riskCode ?? this.riskCode,
      gt: gt ?? this.gt,
      challenge: challenge ?? this.challenge,
      success: success ?? this.success,
      isRisk: isRisk ?? this.isRisk,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'risk_code': riskCode,
      'gt': gt,
      'challenge': challenge,
      'success': success,
      'is_risk': isRisk,
    };
  }

  factory ClaimData.fromMap(Map<String, dynamic> map) {
    return ClaimData(
      code: map['code'] as String,
      riskCode: map['risk_code'] as int,
      gt: map['gt'] as String,
      challenge: map['challenge'] as String,
      success: map['success'] as int,
      isRisk: map['is_risk'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClaimData.fromJson(String source) =>
      ClaimData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClaimData(code: $code, riskCode: $riskCode, gt: $gt, challenge: $challenge, success: $success, isRisk: $isRisk)';
  }

  @override
  bool operator ==(covariant ClaimData other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.riskCode == riskCode &&
        other.gt == gt &&
        other.challenge == challenge &&
        other.success == success &&
        other.isRisk == isRisk;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        riskCode.hashCode ^
        gt.hashCode ^
        challenge.hashCode ^
        success.hashCode ^
        isRisk.hashCode;
  }
}
