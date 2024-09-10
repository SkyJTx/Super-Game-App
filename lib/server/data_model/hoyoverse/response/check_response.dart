// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CheckResponse {
  int retcode;
  String message;
  CheckData data;

  CheckResponse({
    required this.retcode,
    required this.message,
    required this.data,
  });

  CheckResponse copyWith({
    int? retcode,
    String? message,
    CheckData? data,
  }) {
    return CheckResponse(
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

  factory CheckResponse.fromMap(Map<String, dynamic> map) {
    return CheckResponse(
      retcode: map['retcode'] as int,
      message: map['message'] as String,
      data: CheckData.fromMap(map['data'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckResponse.fromJson(String source) => CheckResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CheckResponse(retcode: $retcode, message: $message, data: $data)';

  @override
  bool operator ==(covariant CheckResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.retcode == retcode &&
      other.message == message &&
      other.data == data;
  }

  @override
  int get hashCode => retcode.hashCode ^ message.hashCode ^ data.hashCode;
}

class CheckData {
  int totalSignDay;
  String today;
  bool isSign;
  bool firstBind;
  bool isSub;
  String region;
  bool monthLastDay;

  CheckData({
    required this.totalSignDay,
    required this.today,
    required this.isSign,
    required this.firstBind,
    required this.isSub,
    required this.region,
    required this.monthLastDay,
  });

  CheckData copyWith({
    int? totalSignDay,
    String? today,
    bool? isSign,
    bool? firstBind,
    bool? isSub,
    String? region,
    bool? monthLastDay,
  }) {
    return CheckData(
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

  factory CheckData.fromMap(Map<String, dynamic> map) {
    return CheckData(
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

  factory CheckData.fromJson(String source) => CheckData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CheckData(totalSignDay: $totalSignDay, today: $today, isSign: $isSign, firstBind: $firstBind, isSub: $isSub, region: $region, monthLastDay: $monthLastDay)';
  }

  @override
  bool operator ==(covariant CheckData other) {
    if (identical(this, other)) return true;
  
    return 
      other.totalSignDay == totalSignDay &&
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
