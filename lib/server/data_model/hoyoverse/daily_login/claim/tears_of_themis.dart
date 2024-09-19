part of 'claim_response.dart';

/* {
"code":"",
"risk_code":0,
"gt":"",
"challenge":"",
"success":0,
"is_risk":false
} */

class TearsOfThemisClaimResponse extends ClaimResponse {
  TearsOfThemisClaimData? data;

  TearsOfThemisClaimResponse({
    required super.retcode,
    required super.message,
    required this.data,
  });

  @override
  TearsOfThemisClaimResponse copyWith({
    int? retcode,
    String? message,
    TearsOfThemisClaimData? data,
  }) {
    return TearsOfThemisClaimResponse(
      retcode: retcode ?? super.retcode,
      message: message ?? super.message,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'retcode': super.retcode,
      'message': super.message,
      'data': data?.toMap(),
    };
  }

  factory TearsOfThemisClaimResponse.fromMap(Map<String, dynamic> map) {
    return TearsOfThemisClaimResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
      data: map['data'] != null ? TearsOfThemisClaimData.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory TearsOfThemisClaimResponse.fromJson(String source) =>
      TearsOfThemisClaimResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TearsOfThemisClaimResponse(retcode: $retcode, message: $message, data: $data)';

  @override
  bool operator ==(covariant TearsOfThemisClaimResponse other) {
    if (identical(this, other)) return true;

    return other.retcode == super.retcode && other.message == super.message && other.data == data;
  }

  @override
  int get hashCode => super.retcode.hashCode ^ super.message.hashCode ^ data.hashCode;
}

class TearsOfThemisClaimData {
  String code;
  int riskCode;
  String gt;
  String challenge;
  int success;
  bool isRisk;
  TearsOfThemisClaimData({
    required this.code,
    required this.riskCode,
    required this.gt,
    required this.challenge,
    required this.success,
    required this.isRisk,
  });

  TearsOfThemisClaimData copyWith({
    String? code,
    int? riskCode,
    String? gt,
    String? challenge,
    int? success,
    bool? isRisk,
  }) {
    return TearsOfThemisClaimData(
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

  factory TearsOfThemisClaimData.fromMap(Map<String, dynamic> map) {
    return TearsOfThemisClaimData(
      code: map['code'] as String,
      riskCode: map['risk_code'] as int,
      gt: map['gt'] as String,
      challenge: map['challenge'] as String,
      success: map['success'] as int,
      isRisk: map['is_risk'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TearsOfThemisClaimData.fromJson(String source) =>
      TearsOfThemisClaimData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TearsOfThemisClaimData(code: $code, riskCode: $riskCode, gt: $gt, challenge: $challenge, success: $success, isRisk: $isRisk)';
  }

  @override
  bool operator ==(covariant TearsOfThemisClaimData other) {
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
