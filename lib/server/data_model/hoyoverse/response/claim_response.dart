// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClaimResponse {
  int retcode;
  String message;
  ClaimData data;

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
      'data': data.toMap(),
    };
  }

  factory ClaimResponse.fromMap(Map<String, dynamic> map) {
    return ClaimResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
      data: ClaimData.fromMap(map['data'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClaimResponse.fromJson(String source) => ClaimResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ClaimResponse(retcode: $retcode, message: $message, data: $data)';

  @override
  bool operator ==(covariant ClaimResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.retcode == retcode &&
      other.message == message &&
      other.data == data;
  }

  @override
  int get hashCode => retcode.hashCode ^ message.hashCode ^ data.hashCode;
}

class ClaimData {
  String code;
  bool firstBind;
  GtResult gtResult;

  ClaimData({
    required this.code,
    required this.firstBind,
    required this.gtResult,
  });

  ClaimData copyWith({
    String? code,
    bool? firstBind,
    GtResult? gtResult,
  }) {
    return ClaimData(
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

  factory ClaimData.fromMap(Map<String, dynamic> map) {
    return ClaimData(
      code: map['code'] as String,
      firstBind: map['first_bind'] as bool,
      gtResult: GtResult.fromMap(map['gt_result'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClaimData.fromJson(String source) => ClaimData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ClaimData(code: $code, firstBind: $firstBind, gtResult: $gtResult)';

  @override
  bool operator ==(covariant ClaimData other) {
    if (identical(this, other)) return true;
  
    return 
      other.code == code &&
      other.firstBind == firstBind &&
      other.gtResult == gtResult;
  }

  @override
  int get hashCode => code.hashCode ^ firstBind.hashCode ^ gtResult.hashCode;
}

class GtResult {
  int riskCode;
  String gt;
  String challenge;
  int success;
  bool isRisk;

  GtResult({
    required this.riskCode,
    required this.gt,
    required this.challenge,
    required this.success,
    required this.isRisk,
  });

  GtResult copyWith({
    int? riskCode,
    String? gt,
    String? challenge,
    int? success,
    bool? isRisk,
  }) {
    return GtResult(
      riskCode: riskCode ?? this.riskCode,
      gt: gt ?? this.gt,
      challenge: challenge ?? this.challenge,
      success: success ?? this.success,
      isRisk: isRisk ?? this.isRisk,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'riskCode': riskCode,
      'gt': gt,
      'challenge': challenge,
      'success': success,
      'isRisk': isRisk,
    };
  }

  factory GtResult.fromMap(Map<String, dynamic> map) {
    return GtResult(
      riskCode: map['riskCode'] as int,
      gt: map['gt'] as String,
      challenge: map['challenge'] as String,
      success: map['success'] as int,
      isRisk: map['isRisk'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory GtResult.fromJson(String source) => GtResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GtResult(riskCode: $riskCode, gt: $gt, challenge: $challenge, success: $success, isRisk: $isRisk)';
  }

  @override
  bool operator ==(covariant GtResult other) {
    if (identical(this, other)) return true;
  
    return 
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
