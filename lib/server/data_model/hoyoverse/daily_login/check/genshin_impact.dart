part of 'check_response.dart';

/* {"total_sign_day":2,
"today":"2024-09-18",
"is_sign":false,
"first_bind":false,
"is_sub":true,
"region":"os_asia",
"month_last_day":false
} */

class GenshinImpactCheckResponse extends CheckResponse {
  GenshinImpactCheckData? data;

  GenshinImpactCheckResponse({
    required super.retcode,
    required super.message,
    required this.data,
  });

  @override
  GenshinImpactCheckResponse copyWith({
    int? retcode,
    String? message,
    GenshinImpactCheckData? data,
  }) {
    return GenshinImpactCheckResponse(
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

  factory GenshinImpactCheckResponse.fromMap(Map<String, dynamic> map) {
    return GenshinImpactCheckResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
      data: map['data'] != null ? GenshinImpactCheckData.fromMap(map['data'] as Map<String, dynamic>) : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory GenshinImpactCheckResponse.fromJson(String source) =>
      GenshinImpactCheckResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GenshinImpactCheckResponse(retcode: $retcode, message: $message, data: $data)';

  @override
  bool operator ==(covariant GenshinImpactCheckResponse other) {
    if (identical(this, other)) return true;

    return other.retcode == retcode && other.message == message && other.data == data;
  }

  @override
  int get hashCode {
    return retcode.hashCode ^ message.hashCode ^ data.hashCode;
  }
}

class GenshinImpactCheckData {
  int totalSignDay;
  String today;
  bool isSign;
  bool firstBind;
  bool isSub;
  String region;
  bool monthLastDay;

  GenshinImpactCheckData({
    required this.totalSignDay,
    required this.today,
    required this.isSign,
    required this.firstBind,
    required this.isSub,
    required this.region,
    required this.monthLastDay,
  });

  GenshinImpactCheckData copyWith({
    int? totalSignDay,
    String? today,
    bool? isSign,
    bool? firstBind,
    bool? isSub,
    String? region,
    bool? monthLastDay,
  }) {
    return GenshinImpactCheckData(
      totalSignDay: totalSignDay ?? this.totalSignDay,
      today: today ?? this.today,
      isSign: isSign ?? this.isSign,
      firstBind: firstBind ?? this.firstBind,
      isSub: isSub ?? this.isSub,
      region: region ?? this.region,
      monthLastDay: monthLastDay ?? this.monthLastDay,
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
      'month_last_day': monthLastDay,
    };
  }

  factory GenshinImpactCheckData.fromMap(Map<String, dynamic> map) {
    return GenshinImpactCheckData(
      totalSignDay: map['total_sign_day'] as int,
      today: map['today'] as String,
      isSign: map['is_sign'] as bool,
      firstBind: map['first_bind'] as bool,
      isSub: map['is_sub'] as bool,
      region: map['region'] as String,
      monthLastDay: map['month_last_day'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory GenshinImpactCheckData.fromJson(String source) =>
      GenshinImpactCheckData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GenshinImpactCheckData(totalSignDay: $totalSignDay, today: $today, isSign: $isSign, firstBind: $firstBind, isSub: $isSub, region: $region, monthLastDay: $monthLastDay)';
  }

  @override
  bool operator ==(covariant GenshinImpactCheckData other) {
    if (identical(this, other)) return true;

    return other.totalSignDay == totalSignDay &&
        other.today == today &&
        other.isSign == isSign &&
        other.firstBind == firstBind &&
        other.isSub == isSub &&
        other.region == region &&
        other.monthLastDay == monthLastDay;
  }

  @override
  int get hashCode {
    return totalSignDay.hashCode ^
        today.hashCode ^
        isSign.hashCode ^
        firstBind.hashCode ^
        isSub.hashCode ^
        region.hashCode ^
        monthLastDay.hashCode;
  }
}
