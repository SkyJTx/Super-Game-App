part of 'check_response.dart';

/* {
"total_sign_day":2,
"today":"2024-09-18",
"is_sign":false,
"first_bind":false,
"is_sub":false,
"region":""
} */

class HonkaiImpact3rdCheckResponse extends CheckResponse {
  HonkaiImpact3rdCheckData? data;

  HonkaiImpact3rdCheckResponse({
    required super.retcode,
    required super.message,
    required this.data,
  });

  @override
  HonkaiImpact3rdCheckResponse copyWith({
    int? retcode,
    String? message,
    HonkaiImpact3rdCheckData? data,
  }) {
    return HonkaiImpact3rdCheckResponse(
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

  factory HonkaiImpact3rdCheckResponse.fromMap(Map<String, dynamic> map) {
    return HonkaiImpact3rdCheckResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
      data: map['data'] != null ? HonkaiImpact3rdCheckData.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory HonkaiImpact3rdCheckResponse.fromJson(String source) =>
      HonkaiImpact3rdCheckResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HonkaiImpact3rdCheckResponse(retcode: $retcode, message: $message, data: $data)';

  @override
  bool operator ==(covariant HonkaiImpact3rdCheckResponse other) {
    if (identical(this, other)) return true;

    return other.retcode == retcode && other.message == message && other.data == data;
  }

  @override
  int get hashCode {
    return retcode.hashCode ^ message.hashCode ^ data.hashCode;
  }
}

class HonkaiImpact3rdCheckData {
  int totalSignDay;
  String today;
  bool isSign;
  bool firstBind;
  bool isSub;
  String region;

  HonkaiImpact3rdCheckData({
    required this.totalSignDay,
    required this.today,
    required this.isSign,
    required this.firstBind,
    required this.isSub,
    required this.region,
  });

  HonkaiImpact3rdCheckData copyWith({
    int? totalSignDay,
    String? today,
    bool? isSign,
    bool? firstBind,
    bool? isSub,
    String? region,
  }) {
    return HonkaiImpact3rdCheckData(
      totalSignDay: totalSignDay ?? this.totalSignDay,
      today: today ?? this.today,
      isSign: isSign ?? this.isSign,
      firstBind: firstBind ?? this.firstBind,
      isSub: isSub ?? this.isSub,
      region: region ?? this.region,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_sign_day': totalSignDay,
      'today': today,
      'is_sign': isSign,
      'first_bind': firstBind,
      'is_sub': isSub,
      'region': region,
    };
  }

  factory HonkaiImpact3rdCheckData.fromMap(Map<String, dynamic> map) {
    return HonkaiImpact3rdCheckData(
      totalSignDay: map['total_sign_day'] as int,
      today: map['today'] as String,
      isSign: map['is_sign'] as bool,
      firstBind: map['first_bind'] as bool,
      isSub: map['is_sub'] as bool,
      region: map['region'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HonkaiImpact3rdCheckData.fromJson(String source) =>
      HonkaiImpact3rdCheckData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HonkaiImpact3rdCheckData(totalSignDay: $totalSignDay, today: $today, isSign: $isSign, firstBind: $firstBind, isSub: $isSub, region: $region)';
  }

  @override
  bool operator ==(covariant HonkaiImpact3rdCheckData other) {
    if (identical(this, other)) return true;

    return other.totalSignDay == totalSignDay &&
        other.today == today &&
        other.isSign == isSign &&
        other.firstBind == firstBind &&
        other.isSub == isSub &&
        other.region == region;
  }

  @override
  int get hashCode {
    return totalSignDay.hashCode ^
        today.hashCode ^
        isSign.hashCode ^
        firstBind.hashCode ^
        isSub.hashCode ^
        region.hashCode;
  }
}
