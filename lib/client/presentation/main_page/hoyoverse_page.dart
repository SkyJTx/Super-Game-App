import 'package:flutter/material.dart';
import 'package:sga/client/component/hoyoverse_game_card.dart';
import 'package:sga/client/component/multiple_value_change_notifier_selector.dart';
import 'package:sga/client/component/value_change_notifier.dart';
import 'package:sga/client/repository/global_repo.dart';
import 'package:sga/server/constant/hoyoverse/details.dart';
import 'package:sga/server/data_model/hoyoverse/daily_login/check/check_response.dart';
import 'package:sga/server/data_model/hoyoverse/daily_login/claim/claim_response.dart';
import 'package:sga/server/repository/hoyoverse_repository.dart';

class HoyoversePage extends StatefulWidget {
  const HoyoversePage({super.key});

  static const routeName = '/hoyoverse';

  @override
  State<HoyoversePage> createState() => HoyoversePageState();
}

class HoyoversePageState extends State<HoyoversePage> {
  final hi3isAlreadyCheckin = ValueChangeNotifier(false);
  final giisAlreadyCheckin = ValueChangeNotifier(false);
  final totisAlreadyCheckin = ValueChangeNotifier(false);
  final hsrisAlreadyCheckin = ValueChangeNotifier(false);
  final zzzisAlreadyCheckin = ValueChangeNotifier(false);

  @override
  Widget build(BuildContext context) {
    final hoyoverseRepo = HoYoverseRepository.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'HoYoverse\'s Game',
                style: theme.textTheme.titleLarge,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 150),
                child: MultipleValueChangeNotifierSelector<bool>(
                  valueChangeNotifiers: [
                    hi3isAlreadyCheckin,
                    giisAlreadyCheckin,
                    totisAlreadyCheckin,
                    hsrisAlreadyCheckin,
                    zzzisAlreadyCheckin,
                  ],
                  selector: () {
                    return hi3isAlreadyCheckin.value &&
                        giisAlreadyCheckin.value &&
                        totisAlreadyCheckin.value &&
                        hsrisAlreadyCheckin.value &&
                        zzzisAlreadyCheckin.value;
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: !state ? () async {
                        final results = await Future.wait(
                          HoYoverseGame.values.map(
                            (game) async {
                              final res = await hoyoverseRepo.fullDailyLogin(game);
                              switch (game) {
                                case HoYoverseGame.honkaiImpact3rd:
                                  hi3isAlreadyCheckin.value = res.success;
                                  break;
                                case HoYoverseGame.genshinImpact:
                                  giisAlreadyCheckin.value = res.success;
                                  break;
                                case HoYoverseGame.tearsOfThemis:
                                  totisAlreadyCheckin.value = res.success;
                                  break;
                                case HoYoverseGame.honkaiStarRail:
                                  hsrisAlreadyCheckin.value = res.success;
                                  break;
                                case HoYoverseGame.zenlessZoneZero:
                                  zzzisAlreadyCheckin.value = res.success;
                                  break;
                              }
                              return res;
                            },
                          ),
                        );
                        if (!context.mounted) return;
                        final globalRepo = GlobalRepository.of(context);
                        globalRepo.showSuccessSnackBar(
                          context,
                          message:
                              'Checkin ${results.map((e) => e.success).length} game(s) success.',
                        );
                      } : null,
                      child: const Text('Check-in All'),
                    );
                  },
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                HoyoverseGameCard(
                  checkNotifier: hi3isAlreadyCheckin,
                  imageProvider: const AssetImage(
                    'assets/images/hoyoverse/honkai_impact_3rd/card.jpg',
                  ),
                  title: 'Honkai Impact 3rd',
                  onInit: () async {
                    final check =
                        await hoyoverseRepo.checkDailyReward(HoYoverseGame.honkaiImpact3rd)
                            as HonkaiImpact3rdCheckResponse;
                    return check.data!.isSign;
                  },
                  onClaim: () async {
                    final claim =
                        await hoyoverseRepo.claimDailyReward(HoYoverseGame.honkaiImpact3rd)
                            as HonkaiImpact3rdClaimResponse;
                    return claim.retcode == 0;
                  },
                  onCheck: () async {
                    final check =
                        await hoyoverseRepo.checkDailyReward(HoYoverseGame.honkaiImpact3rd)
                            as HonkaiImpact3rdCheckResponse;
                    return check.data!.isSign;
                  },
                ),
                const SizedBox(height: 8),
                HoyoverseGameCard(
                  checkNotifier: giisAlreadyCheckin,
                  imageProvider: const AssetImage(
                    'assets/images/hoyoverse/tears_of_themis/card.jpg',
                  ),
                  title: 'Tears of Themis',
                  onInit: () async {
                    final check = await hoyoverseRepo.checkDailyReward(HoYoverseGame.tearsOfThemis)
                        as TearsOfThemisCheckResponse;
                    return check.data!.isSign;
                  },
                  onClaim: () async {
                    final claim = await hoyoverseRepo.claimDailyReward(HoYoverseGame.tearsOfThemis)
                        as TearsOfThemisClaimResponse;
                    return claim.retcode == 0;
                  },
                  onCheck: () async {
                    final check = await hoyoverseRepo.checkDailyReward(HoYoverseGame.tearsOfThemis)
                        as TearsOfThemisCheckResponse;
                    return check.data!.isSign;
                  },
                ),
                const SizedBox(height: 8),
                HoyoverseGameCard(
                  checkNotifier: totisAlreadyCheckin,
                  imageProvider: const AssetImage(
                    'assets/images/hoyoverse/genshin_impact/card.jpg',
                  ),
                  title: 'Genshin Impact',
                  onInit: () async {
                    final check = await hoyoverseRepo.checkDailyReward(HoYoverseGame.genshinImpact)
                        as GenshinImpactCheckResponse;
                    return check.data!.isSign;
                  },
                  onClaim: () async {
                    final claim = await hoyoverseRepo.claimDailyReward(HoYoverseGame.genshinImpact)
                        as GenshinImpactClaimResponse;
                    return claim.retcode == 0;
                  },
                  onCheck: () async {
                    final check = await hoyoverseRepo.checkDailyReward(HoYoverseGame.genshinImpact)
                        as GenshinImpactCheckResponse;
                    return check.data!.isSign;
                  },
                ),
                const SizedBox(height: 8),
                HoyoverseGameCard(
                  checkNotifier: hsrisAlreadyCheckin,
                  imageProvider: const AssetImage(
                    'assets/images/hoyoverse/honkai_star_rail/card.png',
                  ),
                  title: 'Honkai Star Rail',
                  onInit: () async {
                    final check = await hoyoverseRepo.checkDailyReward(HoYoverseGame.honkaiStarRail)
                        as HonkaiStarRailCheckResponse;
                    return check.data!.isSign;
                  },
                  onClaim: () async {
                    final claim = await hoyoverseRepo.claimDailyReward(HoYoverseGame.honkaiStarRail)
                        as HonkaiStarRailClaimResponse;
                    return claim.retcode == 0;
                  },
                  onCheck: () async {
                    final check = await hoyoverseRepo.checkDailyReward(HoYoverseGame.honkaiStarRail)
                        as HonkaiStarRailCheckResponse;
                    return check.data!.isSign;
                  },
                ),
                const SizedBox(height: 8),
                HoyoverseGameCard(
                  checkNotifier: zzzisAlreadyCheckin,
                  imageProvider: const AssetImage(
                    'assets/images/hoyoverse/zenless_zone_zero/card.jpg',
                  ),
                  title: 'Zenless Zone Zero',
                  onInit: () async {
                    final check =
                        await hoyoverseRepo.checkDailyReward(HoYoverseGame.zenlessZoneZero)
                            as ZenlessZoneZeroCheckResponse;
                    return check.data!.isSign;
                  },
                  onClaim: () async {
                    final claim =
                        await hoyoverseRepo.claimDailyReward(HoYoverseGame.zenlessZoneZero)
                            as ZenlessZoneZeroClaimResponse;
                    return claim.retcode == 0;
                  },
                  onCheck: () async {
                    final check =
                        await hoyoverseRepo.checkDailyReward(HoYoverseGame.zenlessZoneZero)
                            as ZenlessZoneZeroCheckResponse;
                    return check.data!.isSign;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
