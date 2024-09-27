// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DailyLoginInternalResponse {
  bool success;
  bool isSign;
  String message;

  DailyLoginInternalResponse({
    required this.success,
    required this.isSign,
    required this.message,
  });

  DailyLoginInternalResponse copyWith({
    bool? success,
    bool? isSign,
    String? message,
  }) {
    return DailyLoginInternalResponse(
      success: success ?? this.success,
      isSign: isSign ?? this.isSign,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'isSign': isSign,
      'message': message,
    };
  }

  factory DailyLoginInternalResponse.fromMap(Map<String, dynamic> map) {
    return DailyLoginInternalResponse(
      success: map['success'] as bool,
      isSign: map['isSign'] as bool,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyLoginInternalResponse.fromJson(String source) =>
      DailyLoginInternalResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DailyLoginInternalResponse(success: $success, isSign: $isSign, message: $message)';

  @override
  bool operator ==(covariant DailyLoginInternalResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.success == success &&
      other.isSign == isSign &&
      other.message == message;
  }

  @override
  int get hashCode => success.hashCode ^ isSign.hashCode ^ message.hashCode;
}
