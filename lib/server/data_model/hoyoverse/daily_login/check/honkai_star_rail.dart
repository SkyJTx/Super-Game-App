part of 'check_response.dart';

/* {
"total_sign_day":2,
"today":"2024-09-18",
"is_sign":false,
"is_sub":true,
"region":"prod_official_asia",
"sign_cnt_missed":15,
"short_sign_day":0,
"send_first":false
} */

class HonkaiStarRailCheckResponse extends CheckResponse {
  HonkaiStarRailCheckData? data;

  HonkaiStarRailCheckResponse({
    required super.retcode,
    required super.message,
    required this.data,
  });

  @override
  HonkaiStarRailCheckResponse copyWith({
    int? retcode,
    String? message,
    HonkaiStarRailCheckData? data,
  }) {
    return HonkaiStarRailCheckResponse(
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

  factory HonkaiStarRailCheckResponse.fromMap(Map<String, dynamic> map) {
    return HonkaiStarRailCheckResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
      data: map['data'] != null ? HonkaiStarRailCheckData.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory HonkaiStarRailCheckResponse.fromJson(String source) =>
      HonkaiStarRailCheckResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HonkaiStarRailCheckResponse(retcode: $retcode, message: $message, data: $data)';

  @override
  bool operator ==(covariant HonkaiStarRailCheckResponse other) {
    if (identical(this, other)) return true;

    return other.retcode == retcode && other.message == message && other.data == data;
  }

  @override
  int get hashCode {
    return retcode.hashCode ^ message.hashCode ^ data.hashCode;
  }
}

class HonkaiStarRailCheckData {
  int totalSignDay;
  String today;
  bool isSign;
  bool isSub;
  String region;
  int signCntMissed;
  int shortSignDay;
  bool sendFirst;

  HonkaiStarRailCheckData({
    required this.totalSignDay,
    required this.today,
    required this.isSign,
    required this.isSub,
    required this.region,
    required this.signCntMissed,
    required this.shortSignDay,
    required this.sendFirst,
  });

  HonkaiStarRailCheckData copyWith({
    int? totalSignDay,
    String? today,
    bool? isSign,
    bool? isSub,
    String? region,
    int? signCntMissed,
    int? shortSignDay,
    bool? sendFirst,
  }) {
    return HonkaiStarRailCheckData(
      totalSignDay: totalSignDay ?? this.totalSignDay,
      today: today ?? this.today,
      isSign: isSign ?? this.isSign,
      isSub: isSub ?? this.isSub,
      region: region ?? this.region,
      signCntMissed: signCntMissed ?? this.signCntMissed,
      shortSignDay: shortSignDay ?? this.shortSignDay,
      sendFirst: sendFirst ?? this.sendFirst,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_sign_day': totalSignDay,
      'today': today,
      'is_sign': isSign,
      'is_sub': isSub,
      'region': region,
      'sign_cnt_missed': signCntMissed,
      'short_sign_day': shortSignDay,
      'send_first': sendFirst,
    };
  }

  factory HonkaiStarRailCheckData.fromMap(Map<String, dynamic> map) {
    return HonkaiStarRailCheckData(
      totalSignDay: map['total_sign_day'] as int,
      today: map['today'] as String,
      isSign: map['is_sign'] as bool,
      isSub: map['is_sub'] as bool,
      region: map['region'] as String,
      signCntMissed: map['sign_cnt_missed'] as int,
      shortSignDay: map['short_sign_day'] as int,
      sendFirst: map['send_first'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory HonkaiStarRailCheckData.fromJson(String source) =>
      HonkaiStarRailCheckData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HonkaiStarRailCheckData(totalSignDay: $totalSignDay, today: $today, isSign: $isSign, isSub: $isSub, region: $region, signCntMissed: $signCntMissed, shortSignDay: $shortSignDay, sendFirst: $sendFirst)';
  }

  @override
  bool operator ==(covariant HonkaiStarRailCheckData other) {
    if (identical(this, other)) return true;

    return other.totalSignDay == totalSignDay &&
        other.today == today &&
        other.isSign == isSign &&
        other.isSub == isSub &&
        other.region == region &&
        other.signCntMissed == signCntMissed &&
        other.shortSignDay == shortSignDay &&
        other.sendFirst == sendFirst;
  }

  @override
  int get hashCode {
    return totalSignDay.hashCode ^
        today.hashCode ^
        isSign.hashCode ^
        isSub.hashCode ^
        region.hashCode ^
        signCntMissed.hashCode ^
        shortSignDay.hashCode ^
        sendFirst.hashCode;
  }
}
