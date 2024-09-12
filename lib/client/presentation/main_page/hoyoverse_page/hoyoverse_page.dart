import 'package:flutter/material.dart';
import 'package:sga/client/presentation/main_page/hoyoverse_page/hoyoverse_game_card.dart';
import 'package:sga/server/constant/hoyoverse/request_event.dart';
import 'package:sga/server/repository/hoyoverse_repository.dart';

class HoyoversePage extends StatefulWidget {
  const HoyoversePage({super.key});

  @override
  State<HoyoversePage> createState() => HoyoversePageState();
}

class HoyoversePageState extends State<HoyoversePage> {
  @override
  Widget build(BuildContext context) {
    final hoyoverseRepo = HoYoverseRepository.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          Text(
            'HoYoverse\'s Game',
            style: theme.textTheme.titleLarge,
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
                  imageProvider: const AssetImage(
                    'assets/images/hoyoverse/honkai_impact_3rd/card.jpg',
                  ),
                  title: 'Honkai Impact 3rd',
                  requestEvent: RequestEvent.honkaiImpact3rd,
                  onClaim: hoyoverseRepo.claimDailyReward,
                  onCheck: hoyoverseRepo.check,
                ),
                const SizedBox(height: 8),
                HoyoverseGameCard(
                  imageProvider: const AssetImage(
                    'assets/images/hoyoverse/tears_of_themis/card.jpg',
                  ),
                  title: 'Tears of Themis',
                  requestEvent: RequestEvent.tearsOfThemis,
                  onClaim: hoyoverseRepo.claimDailyReward,
                  onCheck: hoyoverseRepo.check,
                ),
                const SizedBox(height: 8),
                HoyoverseGameCard(
                  imageProvider: const AssetImage(
                    'assets/images/hoyoverse/genshin_impact/card.jpg',
                  ),
                  title: 'Genshin Impact',
                  requestEvent: RequestEvent.genshinImpact,
                  onClaim: hoyoverseRepo.claimDailyReward,
                  onCheck: hoyoverseRepo.check,
                ),
                const SizedBox(height: 8),
                HoyoverseGameCard(
                  imageProvider: const AssetImage(
                    'assets/images/hoyoverse/honkai_star_rail/card.png',
                  ),
                  title: 'Honkai Star Rail',
                  requestEvent: RequestEvent.honkaiStarRail,
                  onClaim: hoyoverseRepo.claimDailyReward,
                  onCheck: hoyoverseRepo.check,
                ),
                const SizedBox(height: 8),
                HoyoverseGameCard(
                  imageProvider: const AssetImage(
                    'assets/images/hoyoverse/zenless_zone_zero/card.jpg',
                  ),
                  title: 'Zenless Zone Zero',
                  requestEvent: RequestEvent.zenlessZoneZero,
                  onClaim: hoyoverseRepo.claimDailyReward,
                  onCheck: hoyoverseRepo.check,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
