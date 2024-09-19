part of 'claim_response.dart';

/* {
"code":"",
"risk_code":0,
"gt":"",
"challenge":"",
"success":0,
"is_risk":false
} */

class HonkaiStarRailClaimResponse extends ClaimResponse {
  final HonkaiStarRailClaimData? data;

  HonkaiStarRailClaimResponse({
    required super.retcode,
    required super.message,
    required this.data,
  });

  @override
  HonkaiStarRailClaimResponse copyWith({
    int? retcode,
    String? message,
    HonkaiStarRailClaimData? data,
  }) {
    return HonkaiStarRailClaimResponse(
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

  factory HonkaiStarRailClaimResponse.fromMap(Map<String, dynamic> map) {
    return HonkaiStarRailClaimResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
      data: map['data'] != null ? HonkaiStarRailClaimData.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory HonkaiStarRailClaimResponse.fromJson(String source) =>
      HonkaiStarRailClaimResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HonkaiStarRailClaimResponse(retcode: $retcode, message: $message, data: $data)';

  @override
  bool operator ==(covariant HonkaiStarRailClaimResponse other) {
    if (identical(this, other)) return true;

    return other.retcode == retcode && other.message == message && other.data == data;
  }

  @override
  int get hashCode => retcode.hashCode ^ message.hashCode ^ data.hashCode;
}

class HonkaiStarRailClaimData {
  String code;
  int riskCode;
  String gt;
  String challenge;
  int success;
  bool isRisk;

  HonkaiStarRailClaimData({
    required this.code,
    required this.riskCode,
    required this.gt,
    required this.challenge,
    required this.success,
    required this.isRisk,
  });

  HonkaiStarRailClaimData copyWith({
    String? code,
    int? riskCode,
    String? gt,
    String? challenge,
    int? success,
    bool? isRisk,
  }) {
    return HonkaiStarRailClaimData(
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

  factory HonkaiStarRailClaimData.fromMap(Map<String, dynamic> map) {
    return HonkaiStarRailClaimData(
      code: map['code'] as String,
      riskCode: map['risk_code'] as int,
      gt: map['gt'] as String,
      challenge: map['challenge'] as String,
      success: map['success'] as int,
      isRisk: map['is_risk'] as bool,
    );
  }

  String toJson() => json.encode(toMap());
}
