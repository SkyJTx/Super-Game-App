part of 'claim_response.dart';

class HonkaiImpact3rdClaimResponse extends ClaimResponse {
  HonkaiImpact3rdClaimData? data;

  HonkaiImpact3rdClaimResponse({
    required super.retcode,
    required super.message,
    required this.data,
  });

  @override
  HonkaiImpact3rdClaimResponse copyWith({
    int? retcode,
    String? message,
    HonkaiImpact3rdClaimData? data,
  }) {
    return HonkaiImpact3rdClaimResponse(
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

  factory HonkaiImpact3rdClaimResponse.fromMap(Map<String, dynamic> map) {
    return HonkaiImpact3rdClaimResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
      data: map['data'] != null ? HonkaiImpact3rdClaimData.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory HonkaiImpact3rdClaimResponse.fromJson(String source) => HonkaiImpact3rdClaimResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HonkaiImpact3rdClaimResponse(retcode: $retcode, message: $message, data: $data)';

  @override
  bool operator ==(covariant HonkaiImpact3rdClaimResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.retcode == super.retcode &&
      other.message == super.message &&
      other.data == data;
  }

  @override
  int get hashCode => super.retcode.hashCode ^ super.message.hashCode ^ data.hashCode;
}

class HonkaiImpact3rdClaimData {
  String code;
  HonkaiImpact3rdClaimData({
    required this.code,
  });

  HonkaiImpact3rdClaimData copyWith({
    String? code,
  }) {
    return HonkaiImpact3rdClaimData(
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
    };
  }

  factory HonkaiImpact3rdClaimData.fromMap(Map<String, dynamic> map) {
    return HonkaiImpact3rdClaimData(
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HonkaiImpact3rdClaimData.fromJson(String source) => HonkaiImpact3rdClaimData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HonkaiImpact3rdClaimData(code: $code)';

  @override
  bool operator ==(covariant HonkaiImpact3rdClaimData other) {
    if (identical(this, other)) return true;
  
    return 
      other.code == code;
  }

  @override
  int get hashCode => code.hashCode;
}
