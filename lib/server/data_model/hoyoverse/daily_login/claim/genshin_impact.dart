part of 'claim_response.dart';

/* {
"code":"ok",
"first_bind":false,
"gt_result":{
  "risk_code":0,
  "gt":"",
  "challenge":"",
  "success":0,
  "is_risk":false
}} */

class GenshinImpactClaimResponse extends ClaimResponse {
  final GenshinImpactClaimData? data;

  GenshinImpactClaimResponse({
    required super.retcode,
    required super.message,
    required this.data,
  });

  @override
  GenshinImpactClaimResponse copyWith({
    int? retcode,
    String? message,
    GenshinImpactClaimData? data,
  }) {
    return GenshinImpactClaimResponse(
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

  factory GenshinImpactClaimResponse.fromMap(Map<String, dynamic> map) {
    return GenshinImpactClaimResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
      data: map['data'] != null ? GenshinImpactClaimData.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory GenshinImpactClaimResponse.fromJson(String source) =>
      GenshinImpactClaimResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GenshinImpactClaimResponse(retcode: $retcode, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GenshinImpactClaimResponse &&
        other.retcode == retcode &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => retcode.hashCode ^ message.hashCode ^ data.hashCode;
}

class GenshinImpactClaimData {
  final String code;
  final bool firstBind;
  final GTResult gtResult;

  GenshinImpactClaimData({
    required this.code,
    required this.firstBind,
    required this.gtResult,
  });

  GenshinImpactClaimData copyWith({
    String? code,
    bool? firstBind,
    GTResult? gtResult,
  }) {
    return GenshinImpactClaimData(
      code: code ?? this.code,
      firstBind: firstBind ?? this.firstBind,
      gtResult: gtResult ?? this.gtResult,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'first_bind': firstBind,
      'gt_result': gtResult.toMap(),
    };
  }

  factory GenshinImpactClaimData.fromMap(Map<String, dynamic> map) {
    return GenshinImpactClaimData(
      code: map['code'] as String,
      firstBind: map['first_bind'] as bool,
      gtResult: GTResult.fromMap(map['gt_result'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory GenshinImpactClaimData.fromJson(String source) =>
      GenshinImpactClaimData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GenshinImpactClaimData(code: $code, firstBind: $firstBind, gtResult: $gtResult)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GenshinImpactClaimData &&
        other.code == code &&
        other.firstBind == firstBind &&
        other.gtResult == gtResult;
  }

  @override
  int get hashCode => code.hashCode ^ firstBind.hashCode ^ gtResult.hashCode;
}

class GTResult {
  final int riskCode;
  final String gt;
  final String challenge;
  final int success;
  final bool isRisk;

  GTResult({
    required this.riskCode,
    required this.gt,
    required this.challenge,
    required this.success,
    required this.isRisk,
  });

  GTResult copyWith({
    int? riskCode,
    String? gt,
    String? challenge,
    int? success,
    bool? isRisk,
  }) {
    return GTResult(
      riskCode: riskCode ?? this.riskCode,
      gt: gt ?? this.gt,
      challenge: challenge ?? this.challenge,
      success: success ?? this.success,
      isRisk: isRisk ?? this.isRisk,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'risk_code': riskCode,
      'gt': gt,
      'challenge': challenge,
      'success': success,
      'is_risk': isRisk,
    };
  }

  factory GTResult.fromMap(Map<String, dynamic> map) {
    return GTResult(
      riskCode: map['risk_code'] as int,
      gt: map['gt'] as String,
      challenge: map['challenge'] as String,
      success: map['success'] as int,
      isRisk: map['is_risk'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory GTResult.fromJson(String source) =>
      GTResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GTResult(riskCode: $riskCode, gt: $gt, challenge: $challenge, success: $success, isRisk: $isRisk)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GTResult &&
        other.riskCode == riskCode &&
        other.gt == gt &&
        other.challenge == challenge &&
        other.success == success &&
        other.isRisk == isRisk;
  }

  @override
  int get hashCode {
    return riskCode.hashCode ^
        gt.hashCode ^
        challenge.hashCode ^
        success.hashCode ^
        isRisk.hashCode;
  }
}
