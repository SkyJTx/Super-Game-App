part of 'hoyoverse_page_bloc.dart';

class HoyoversePageState {
  final bool isHI3CanCheckin;
  final bool isToTCanCheckin;
  final bool isGICanCheckin;
  final bool isHSRCanCheckin;
  final bool isZZZCanCheckin;

  HoyoversePageState({
    required this.isHI3CanCheckin,
    required this.isToTCanCheckin,
    required this.isGICanCheckin,
    required this.isHSRCanCheckin,
    required this.isZZZCanCheckin,
  });

  HoyoversePageState copyWith({
    bool? isHI3CanCheckin,
    bool? isToTCanCheckin,
    bool? isGICanCheckin,
    bool? isHSRCanCheckin,
    bool? isZZZCanCheckin,
  }) {
    return HoyoversePageState(
      isHI3CanCheckin: isHI3CanCheckin ?? this.isHI3CanCheckin,
      isToTCanCheckin: isToTCanCheckin ?? this.isToTCanCheckin,
      isGICanCheckin: isGICanCheckin ?? this.isGICanCheckin,
      isHSRCanCheckin: isHSRCanCheckin ?? this.isHSRCanCheckin,
      isZZZCanCheckin: isZZZCanCheckin ?? this.isZZZCanCheckin,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HoyoversePageState &&
        other.isHI3CanCheckin == isHI3CanCheckin &&
        other.isToTCanCheckin == isToTCanCheckin &&
        other.isGICanCheckin == isGICanCheckin &&
        other.isHSRCanCheckin == isHSRCanCheckin &&
        other.isZZZCanCheckin == isZZZCanCheckin;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      isHI3CanCheckin,
      isToTCanCheckin,
      isGICanCheckin,
      isHSRCanCheckin,
      isZZZCanCheckin,
    ]);
  }
}
