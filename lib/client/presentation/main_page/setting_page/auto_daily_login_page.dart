import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sga/client/component/custom_list_tile.dart';
import 'package:sga/client/controller/setting/auto_daily_login/auto_daily_login_bloc.dart';

class AutoDailyLoginSettingPage extends StatefulWidget {
  const AutoDailyLoginSettingPage({super.key});

  static const routeName = 'auto_daily_login';

  @override
  State<AutoDailyLoginSettingPage> createState() => AutoDailyLoginSettingPageState();
}

class AutoDailyLoginSettingPageState extends State<AutoDailyLoginSettingPage> {
  final bloc = AutoDailyLoginBloc()..init();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<AutoDailyLoginBloc, AutoDailyLoginState>(
            bloc: bloc,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Auto Daily Login',
                    style: theme.textTheme.titleLarge,
                  ),
                  const Divider(),
                  CustomListTile(
                    leading: const Image(
                      image: AssetImage('assets/images/hoyoverse/honkai_impact_3rd/logo.png'),
                      width: 36,
                    ),
                    title: 'Honkai Impact 3rd',
                    subtitle: 'Auto daily login for Honkai Impact 3rd',
                    trailing: Switch(
                      value: state.isHI3AutoDailyLogin,
                      onChanged: bloc.setAutoDailyLogin(AutoDailyLoginGame.honkaiImpact3rd),
                    ),
                  ),
                  CustomListTile(
                    leading: const Image(
                      image: AssetImage('assets/images/hoyoverse/tears_of_themis/logo.png'),
                      width: 36,
                    ),
                    title: 'Tears of Themis',
                    subtitle: 'Auto daily login for Tears of Themis',
                    trailing: Switch(
                      value: state.isToTAutoDailyLogin,
                      onChanged: bloc.setAutoDailyLogin(AutoDailyLoginGame.tearsOfThemis),
                    ),
                  ),
                  CustomListTile(
                    leading: const Image(
                      image: AssetImage('assets/images/hoyoverse/genshin_impact/logo.png'),
                      width: 36,
                    ),
                    title: 'Genshin Impact',
                    subtitle: 'Auto daily login for Genshin Impact',
                    trailing: Switch(
                      value: state.isGIAutoDailyLogin,
                      onChanged: bloc.setAutoDailyLogin(AutoDailyLoginGame.genshinImpact),
                    ),
                  ),
                  CustomListTile(
                    leading: const Image(
                      image: AssetImage('assets/images/hoyoverse/honkai_star_rail/logo.png'),
                      width: 36,
                    ),
                    title: 'Honkai Star Rail',
                    subtitle: 'Auto daily login for Honkai Star Rail',
                    trailing: Switch(
                      value: state.isHSRAutoDailyLogin,
                      onChanged: bloc.setAutoDailyLogin(AutoDailyLoginGame.honkaiStarRail),
                    ),
                  ),
                  CustomListTile(
                    leading: const Image(
                      image: AssetImage('assets/images/hoyoverse/zenless_zone_zero/logo.png'),
                      width: 36,
                    ),
                    title: 'Zenless Zone Zero',
                    subtitle: 'Auto daily login for Zenless Zone Zero',
                    trailing: Switch(
                      value: state.isZZZAutoDailyLogin,
                      onChanged: bloc.setAutoDailyLogin(AutoDailyLoginGame.zenlessZoneZero),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
