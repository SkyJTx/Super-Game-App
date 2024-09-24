import 'dart:convert';

class DailyLoginInternalResponse {
  bool success;
  String message;

  DailyLoginInternalResponse({
    required this.success,
    required this.message,
  });

  DailyLoginInternalResponse copyWith({
    bool? success,
    String? message,
  }) {
    return DailyLoginInternalResponse(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
    };
  }

  factory DailyLoginInternalResponse.fromMap(Map<String, dynamic> map) {
    return DailyLoginInternalResponse(
      success: map['success'] as bool,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyLoginInternalResponse.fromJson(String source) =>
      DailyLoginInternalResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DailyLoginInternalResponse(success: $success, message: $message)';

  @override
  bool operator ==(covariant DailyLoginInternalResponse other) {
    if (identical(this, other)) return true;

    return other.success == success && other.message == message;
  }

  @override
  int get hashCode {
    return success.hashCode ^ message.hashCode;
  }
}