import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sga/client/component/custom_list_tile.dart';
import 'package:sga/client/component/custom_text_field.dart';
import 'package:sga/client/controller/theme/theme_bloc.dart';
import 'package:sga/client/presentation/main_page/setting_page/auto_daily_login_page.dart';
import 'package:sga/server/repository/settings_repository.dart';
import 'package:sizer/sizer.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  static const routeName = '/settings';

  @override
  State<SettingPage> createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  final hoyoverseLTUIDController = TextEditingController();
  final hoyoverseLTokenController = TextEditingController();
  final hoyoverseDeviceIDController = TextEditingController();
  final themeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    themeController.text = formatThemeMode(ThemeProvider.of(context)?.state);

    SettingsRepository.hoyoverseLTUID.get().then((value) {
      hoyoverseLTUIDController.text = value;
    });
    SettingsRepository.hoyoverseLToken.get().then((value) {
      hoyoverseLTokenController.text = value;
    });
    SettingsRepository.hoyoverseDeviceId.get().then((value) {
      hoyoverseDeviceIDController.text = value;
    });
  }

  String formatThemeMode(ThemeMode? themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      default:
        return 'System';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'General',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(),
              CustomListTile(
                leading: const Icon(Icons.brightness_4),
                title: 'Theme Mode',
                subtitle: 'Current theme mode for this app.',
                trailing: DropdownMenu<ThemeMode>(
                  width: min(200, 30.w),
                  controller: themeController,
                  dropdownMenuEntries: ThemeMode.values
                      .map(
                        (e) => DropdownMenuEntry(
                          value: e,
                          label: formatThemeMode(e),
                        ),
                      )
                      .toList(),
                  onSelected: (value) {
                    if (value != null) {
                      ThemeProvider.of(context)?.select(value);
                    }
                  },
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  context.go('${SettingPage.routeName}/${AutoDailyLoginSettingPage.routeName}');
                },
                child: const CustomListTile(
                  leading: Icon(Icons.auto_awesome),
                  title: 'Auto Daily Login',
                  subtitle: 'Auto daily login for your games.',
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HoYoverse',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(),
              Column(
                children: [
                  ListTileTextField(
                    leading: const Icon(Icons.perm_identity),
                    title: 'HoYoverse\'s LTUID',
                    subtitle: 'Your LTUID from HoYoLab.',
                    hintText: 'Enter your LTUID',
                    controller: hoyoverseLTUIDController,
                    setting: SettingsRepository.hoyoverseLTUID,
                  ),
                  ListTileTextField(
                    leading: const Icon(Icons.vpn_key),
                    title: 'HoYoverse\'s LToken',
                    subtitle: 'Your LToken from HoYoLab.',
                    hintText: 'Enter your LToken',
                    controller: hoyoverseLTokenController,
                    setting: SettingsRepository.hoyoverseLToken,
                  ),
                  ListTileTextField(
                    leading: const Icon(Icons.phone_android),
                    title: 'HoYoverse\'s Device ID',
                    subtitle: 'Your Device ID from HoYoLab.',
                    hintText: 'Enter your Device ID',
                    controller: hoyoverseDeviceIDController,
                    setting: SettingsRepository.hoyoverseDeviceId,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
