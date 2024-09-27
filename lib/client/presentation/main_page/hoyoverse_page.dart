import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sga/client/component/hoyoverse_game_card.dart';
import 'package:sga/client/controller/hoyoverse/hoyoverse_page_bloc.dart';
import 'package:sga/client/repository/global_repo.dart';
import 'package:sga/server/constant/hoyoverse/details.dart';
import 'package:sga/server/repository/hoyoverse_repository.dart';

class HoyoversePage extends StatefulWidget {
  const HoyoversePage({super.key});

  static const routeName = '/hoyoverse';

  @override
  State<HoyoversePage> createState() => HoyoversePresentationState();
}

class HoyoversePresentationState extends State<HoyoversePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => HoyoversePageBloc(
        globalRepository: GlobalRepository.of(context),
        hoyoverseRepository: HoYoverseRepository.of(context),
      )..init(),
      child: Padding(
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
                  child: BlocSelector<HoyoversePageBloc, HoyoversePageState, bool>(
                    selector: (state) {
                      return state.isHI3CanCheckin &&
                          state.isToTCanCheckin &&
                          state.isGICanCheckin &&
                          state.isHSRCanCheckin &&
                          state.isZZZCanCheckin;
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed:
                            !state ? BlocProvider.of<HoyoversePageBloc>(context).checkinAll : null,
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
              child: BlocBuilder<HoyoversePageBloc, HoyoversePageState>(
                builder: (context, state) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      HoyoverseGameCard(
                        enabled: state.isHI3CanCheckin,
                        imageProvider: const AssetImage(
                          'assets/images/hoyoverse/honkai_impact_3rd/card.jpg',
                        ),
                        title: 'Honkai Impact 3rd',
                        onCheckIn: BlocProvider.of<HoyoversePageBloc>(context).checkin(HoYoverseGame.honkaiImpact3rd),
                      ),
                      const SizedBox(height: 8),
                      HoyoverseGameCard(
                        enabled: state.isToTCanCheckin,
                        imageProvider: const AssetImage(
                          'assets/images/hoyoverse/tears_of_themis/card.jpg',
                        ),
                        title: 'Tears of Themis',
                        onCheckIn: BlocProvider.of<HoyoversePageBloc>(context).checkin(HoYoverseGame.tearsOfThemis),
                      ),
                      const SizedBox(height: 8),
                      HoyoverseGameCard(
                        enabled: state.isGICanCheckin,
                        imageProvider: const AssetImage(
                          'assets/images/hoyoverse/genshin_impact/card.jpg',
                        ),
                        title: 'Genshin Impact',
                        onCheckIn: BlocProvider.of<HoyoversePageBloc>(context).checkin(HoYoverseGame.genshinImpact),
                      ),
                      const SizedBox(height: 8),
                      HoyoverseGameCard(
                        enabled: state.isHSRCanCheckin,
                        imageProvider: const AssetImage(
                          'assets/images/hoyoverse/honkai_star_rail/card.png',
                        ),
                        title: 'Honkai Star Rail',
                        onCheckIn: BlocProvider.of<HoyoversePageBloc>(context).checkin(HoYoverseGame.honkaiStarRail),
                      ),
                      const SizedBox(height: 8),
                      HoyoverseGameCard(
                        enabled: state.isZZZCanCheckin,
                        imageProvider: const AssetImage(
                          'assets/images/hoyoverse/zenless_zone_zero/card.jpg',
                        ),
                        title: 'Zenless Zone Zero',
                        onCheckIn: BlocProvider.of<HoyoversePageBloc>(context).checkin(HoYoverseGame.zenlessZoneZero),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
