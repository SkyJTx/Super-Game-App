import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sga/client/repository/global_repo.dart';
import 'package:sga/server/constant/hoyoverse/details.dart';
import 'package:sga/server/data_model/hoyoverse/daily_login/check/check_response.dart';
import 'package:sga/server/repository/hoyoverse_repository.dart';

part 'hoyoverse_page_state.dart';

class HoyoversePageBloc extends Cubit<HoyoversePageState> {
  final GlobalRepository globalRepository;
  final HoYoverseRepository hoyoverseRepository;

  HoyoversePageBloc({
    required this.globalRepository,
    required this.hoyoverseRepository,
  }) : super(HoyoversePageState(
          isHI3CanCheckin: true,
          isToTCanCheckin: true,
          isGICanCheckin: true,
          isHSRCanCheckin: true,
          isZZZCanCheckin: true,
        ));

  void setCheckinState(HoYoverseGame game, bool value) {
    switch (game) {
      case HoYoverseGame.honkaiImpact3rd:
        emit(state.copyWith(isHI3CanCheckin: value));
        break;
      case HoYoverseGame.tearsOfThemis:
        emit(state.copyWith(isToTCanCheckin: value));
        break;
      case HoYoverseGame.genshinImpact:
        emit(state.copyWith(isGICanCheckin: value));
        break;
      case HoYoverseGame.honkaiStarRail:
        emit(state.copyWith(isHSRCanCheckin: value));
        break;
      case HoYoverseGame.zenlessZoneZero:
        emit(state.copyWith(isZZZCanCheckin: value));
        break;
    }
  }

  Future<void> init() async {
    await Future.wait([
      hoyoverseRepository.checkDailyReward(HoYoverseGame.honkaiImpact3rd).then((value) {
        final isSign = (value as HonkaiImpact3rdCheckResponse).data?.isSign ?? true;
        emit(state.copyWith(isHI3CanCheckin: !isSign));
      }).onError((error, stackTrace) {
        globalRepository.showErrorSnackBar(
          globalRepository.navigatorKey.currentContext!,
          message: 'Failed to check daily reward for Honkai Impact 3rd',
        );
      }),
      hoyoverseRepository.checkDailyReward(HoYoverseGame.tearsOfThemis).then((value) {
        final isSign = (value as TearsOfThemisCheckResponse).data?.isSign ?? true;
        emit(state.copyWith(isToTCanCheckin: !isSign));
      }).onError((error, stackTrace) {
        globalRepository.showErrorSnackBar(
          globalRepository.navigatorKey.currentContext!,
          message: 'Failed to check daily reward for Tears of Themis',
        );
      }),
      hoyoverseRepository.checkDailyReward(HoYoverseGame.genshinImpact).then((value) {
        final isSign = (value as GenshinImpactCheckResponse).data?.isSign ?? true;
        emit(state.copyWith(isGICanCheckin: !isSign));
      }).onError((error, stackTrace) {
        globalRepository.showErrorSnackBar(
          globalRepository.navigatorKey.currentContext!,
          message: 'Failed to check daily reward for Genshin Impact',
        );
      }),
      hoyoverseRepository.checkDailyReward(HoYoverseGame.honkaiStarRail).then((value) {
        final isSign = (value as HonkaiStarRailCheckResponse).data?.isSign ?? true;
        emit(state.copyWith(isHSRCanCheckin: !isSign));
      }).onError((error, stackTrace) {
        globalRepository.showErrorSnackBar(
          globalRepository.navigatorKey.currentContext!,
          message: 'Failed to check daily reward for Honkai Star Rail',
        );
      }),
      hoyoverseRepository.checkDailyReward(HoYoverseGame.zenlessZoneZero).then((value) {
        final isSign = (value as ZenlessZoneZeroCheckResponse).data?.isSign ?? true;
        emit(state.copyWith(isZZZCanCheckin: !isSign));
      }).onError((error, stackTrace) {
        globalRepository.showErrorSnackBar(
          globalRepository.navigatorKey.currentContext!,
          message: 'Failed to check daily reward for Zenless Zone Zero',
        );
      }),
    ]);
  }

  Future<void> Function() checkin(HoYoverseGame game) {
    return () async {
      try {
        final response = await hoyoverseRepository.fullDailyLogin(game);
        if (!response.success) {
          globalRepository.showErrorSnackBar(
            globalRepository.navigatorKey.currentContext!,
            message: response.message,
          );
        }
        setCheckinState(game, !response.success);
        globalRepository.showSuccessSnackBar(
          globalRepository.navigatorKey.currentContext!,
          message: '${game.name} ${response.message}',
        );
      } catch (e) {
        globalRepository.showErrorSnackBar(
          globalRepository.navigatorKey.currentContext!,
          message: 'Failed to check-in for ${game.name}',
        );
      }
    };
  }

  Future<void> checkinAll() async {
    await Future.wait([
      checkin(HoYoverseGame.honkaiImpact3rd),
      checkin(HoYoverseGame.tearsOfThemis),
      checkin(HoYoverseGame.genshinImpact),
      checkin(HoYoverseGame.honkaiStarRail),
      checkin(HoYoverseGame.zenlessZoneZero),
    ].map((e) => e()));
  }
}
