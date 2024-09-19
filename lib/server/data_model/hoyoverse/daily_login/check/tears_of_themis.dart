part of 'check_response.dart';

/* {
"total_sign_day":2,
"today":"2024-09-18",
"is_sign":false,
"is_sub":false,
"region":"",
"sign_cnt_missed":15,
"short_sign_day":0,
"send_first":false
} */

class TearsOfThemisCheckResponse extends CheckResponse {
  TearsOfThemisCheckData? data;

  TearsOfThemisCheckResponse({
    required super.retcode,
    required super.message,
    required this.data,
  });

  @override
  TearsOfThemisCheckResponse copyWith({
    int? retcode,
    String? message,
    TearsOfThemisCheckData? data,
  }) {
    return TearsOfThemisCheckResponse(
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

  factory TearsOfThemisCheckResponse.fromMap(Map<String, dynamic> map) {
    return TearsOfThemisCheckResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
      data: map['data'] != null ? TearsOfThemisCheckData.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory TearsOfThemisCheckResponse.fromJson(String source) =>
      TearsOfThemisCheckResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TearsOfThemisCheckResponse(retcode: $retcode, message: $message, data: $data)';

  @override
  bool operator ==(covariant TearsOfThemisCheckResponse other) {
    if (identical(this, other)) return true;

    return other.retcode == retcode && other.message == message && other.data == data;
  }

  @override
  int get hashCode => retcode.hashCode ^ message.hashCode ^ data.hashCode;
}

class TearsOfThemisCheckData {
  int totalSignDay;
  String today;
  bool isSign;
  bool isSub;
  String region;
  int signCntMissed;
  int shortSignDay;
  bool sendFirst;

  TearsOfThemisCheckData({
    required this.totalSignDay,
    required this.today,
    required this.isSign,
    required this.isSub,
    required this.region,
    required this.signCntMissed,
    required this.shortSignDay,
    required this.sendFirst,
  });

  TearsOfThemisCheckData copyWith({
    int? totalSignDay,
    String? today,
    bool? isSign,
    bool? isSub,
    String? region,
    int? signCntMissed,
    int? shortSignDay,
    bool? sendFirst,
  }) {
    return TearsOfThemisCheckData(
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

  factory TearsOfThemisCheckData.fromMap(Map<String, dynamic> map) {
    return TearsOfThemisCheckData(
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

  factory TearsOfThemisCheckData.fromJson(String source) =>
      TearsOfThemisCheckData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TearsOfThemisCheckData(totalSignDay: $totalSignDay, today: $today, isSign: $isSign, isSub: $isSub, region: $region, signCntMissed: $signCntMissed, shortSignDay: $shortSignDay, sendFirst: $sendFirst)';
  }

  @override
  bool operator ==(covariant TearsOfThemisCheckData other) {
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
