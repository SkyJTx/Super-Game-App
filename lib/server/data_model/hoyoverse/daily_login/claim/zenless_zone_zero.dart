part of 'claim_response.dart';

/* {
"code":"",
"risk_code":0,
"gt":"",
"challenge":"",
"success":0,
"is_risk":false
} */

class ZenlessZoneZeroClaimResponse extends ClaimResponse {
  final ZenlessZoneZeroClaimData? data;

  ZenlessZoneZeroClaimResponse({
    required super.retcode,
    required super.message,
    required this.data,
  });

  @override
  ZenlessZoneZeroClaimResponse copyWith({
    int? retcode,
    String? message,
    ZenlessZoneZeroClaimData? data,
  }) {
    return ZenlessZoneZeroClaimResponse(
      retcode: retcode ?? this.retcode,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'retcode': retcode,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory ZenlessZoneZeroClaimResponse.fromMap(Map<String, dynamic> map) {
    return ZenlessZoneZeroClaimResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
      data: map['data'] != null ? ZenlessZoneZeroClaimData.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ZenlessZoneZeroClaimResponse.fromJson(String source) =>
      ZenlessZoneZeroClaimResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ZenlessZoneZeroClaimResponse(retcode: $retcode, message: $message, data: $data)';

  @override
  bool operator ==(covariant ZenlessZoneZeroClaimResponse other) {
    if (identical(this, other)) return true;

    return other.retcode == super.retcode && other.message == super.message && other.data == data;
  }

  @override
  int get hashCode => retcode.hashCode ^ message.hashCode ^ data.hashCode;
}

class ZenlessZoneZeroClaimData {
  final String code;
  final int riskCode;
  final String gt;
  final String challenge;
  final int success;
  final bool isRisk;

  ZenlessZoneZeroClaimData({
    required this.code,
    required this.riskCode,
    required this.gt,
    required this.challenge,
    required this.success,
    required this.isRisk,
  });

  ZenlessZoneZeroClaimData copyWith({
    String? code,
    int? riskCode,
    String? gt,
    String? challenge,
    int? success,
    bool? isRisk,
  }) {
    return ZenlessZoneZeroClaimData(
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

  factory ZenlessZoneZeroClaimData.fromMap(Map<String, dynamic> map) {
    return ZenlessZoneZeroClaimData(
      code: map['code'] as String,
      riskCode: map['risk_code'] as int,
      gt: map['gt'] as String,
      challenge: map['challenge'] as String,
      success: map['success'] as int,
      isRisk: map['is_risk'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ZenlessZoneZeroClaimData.fromJson(String source) =>
      ZenlessZoneZeroClaimData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ZenlessZoneZeroClaimData(code: $code, riskCode: $riskCode, gt: $gt, challenge: $challenge, success: $success, isRisk: $isRisk)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ZenlessZoneZeroClaimData &&
        other.code == code &&
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
