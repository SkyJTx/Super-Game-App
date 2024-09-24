part of 'auto_daily_login_bloc.dart';

class AutoDailyLoginState {
  final bool isGlobalAutoDailyLogin;
  final bool isHI3AutoDailyLogin;
  final bool isToTAutoDailyLogin;
  final bool isGIAutoDailyLogin;
  final bool isHSRAutoDailyLogin;
  final bool isZZZAutoDailyLogin;
  final bool enableHI3AutoDailyLogin;
  final bool enableToTAutoDailyLogin;
  final bool enableGIAutoDailyLogin;
  final bool enableHSRAutoDailyLogin;
  final bool enableZZZAutoDailyLogin;

  AutoDailyLoginState({
    required this.isGlobalAutoDailyLogin,
    required this.isHI3AutoDailyLogin,
    required this.isToTAutoDailyLogin,
    required this.isGIAutoDailyLogin,
    required this.isHSRAutoDailyLogin,
    required this.isZZZAutoDailyLogin,
    required this.enableHI3AutoDailyLogin,
    required this.enableToTAutoDailyLogin,
    required this.enableGIAutoDailyLogin,
    required this.enableHSRAutoDailyLogin,
    required this.enableZZZAutoDailyLogin,
  });

  AutoDailyLoginState copyWith({
    bool? isGlobalAutoDailyLogin,
    bool? isHI3AutoDailyLogin,
    bool? isToTAutoDailyLogin,
    bool? isGIAutoDailyLogin,
    bool? isHSRAutoDailyLogin,
    bool? isZZZAutoDailyLogin,
    bool? enableHI3AutoDailyLogin,
    bool? enableToTAutoDailyLogin,
    bool? enableGIAutoDailyLogin,
    bool? enableHSRAutoDailyLogin,
    bool? enableZZZAutoDailyLogin,
  }) {
    return AutoDailyLoginState(
      isGlobalAutoDailyLogin: isGlobalAutoDailyLogin ?? this.isGlobalAutoDailyLogin,
      isHI3AutoDailyLogin: isHI3AutoDailyLogin ?? this.isHI3AutoDailyLogin,
      isToTAutoDailyLogin: isToTAutoDailyLogin ?? this.isToTAutoDailyLogin,
      isGIAutoDailyLogin: isGIAutoDailyLogin ?? this.isGIAutoDailyLogin,
      isHSRAutoDailyLogin: isHSRAutoDailyLogin ?? this.isHSRAutoDailyLogin,
      isZZZAutoDailyLogin: isZZZAutoDailyLogin ?? this.isZZZAutoDailyLogin,
      enableHI3AutoDailyLogin: enableHI3AutoDailyLogin ?? this.enableHI3AutoDailyLogin,
      enableToTAutoDailyLogin: enableToTAutoDailyLogin ?? this.enableToTAutoDailyLogin,
      enableGIAutoDailyLogin: enableGIAutoDailyLogin ?? this.enableGIAutoDailyLogin,
      enableHSRAutoDailyLogin: enableHSRAutoDailyLogin ?? this.enableHSRAutoDailyLogin,
      enableZZZAutoDailyLogin: enableZZZAutoDailyLogin ?? this.enableZZZAutoDailyLogin,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AutoDailyLoginState &&
        other.isGlobalAutoDailyLogin == isGlobalAutoDailyLogin &&
        other.isHI3AutoDailyLogin == isHI3AutoDailyLogin &&
        other.isToTAutoDailyLogin == isToTAutoDailyLogin &&
        other.isGIAutoDailyLogin == isGIAutoDailyLogin &&
        other.isHSRAutoDailyLogin == isHSRAutoDailyLogin &&
        other.isZZZAutoDailyLogin == isZZZAutoDailyLogin &&
        other.enableHI3AutoDailyLogin == enableHI3AutoDailyLogin &&
        other.enableToTAutoDailyLogin == enableToTAutoDailyLogin &&
        other.enableGIAutoDailyLogin == enableGIAutoDailyLogin &&
        other.enableHSRAutoDailyLogin == enableHSRAutoDailyLogin &&
        other.enableZZZAutoDailyLogin == enableZZZAutoDailyLogin;
  }

  @override
  int get hashCode {
    return Object.hashAllUnordered([
      isGlobalAutoDailyLogin,
      isHI3AutoDailyLogin,
      isToTAutoDailyLogin,
      isGIAutoDailyLogin,
      isHSRAutoDailyLogin,
      isZZZAutoDailyLogin,
      enableHI3AutoDailyLogin,
      enableToTAutoDailyLogin,
      enableGIAutoDailyLogin,
      enableHSRAutoDailyLogin,
      enableZZZAutoDailyLogin,
    ]);
  }
}
