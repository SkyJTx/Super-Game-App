import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sga/client/controller/theme/theme_bloc.dart';
import 'package:sga/server/repository/settings_repository.dart';
import 'package:sizer/sizer.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

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

  Widget customTextField({
    required Icon leading,
    required String title,
    required String subtitle,
    required String hintText,
    required TextEditingController controller,
    required SettingsRepository setting,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Flexible(child: Container()),
          SizedBox(
            width: min(300, 30.w),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              onEditingComplete: () async {
                final res = controller.text;
                await setting.set(res);
              },
              onTapOutside: (event) async {
                final res = controller.text;
                await setting.set(res);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget customListTile({
    required Icon leading,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Flexible(child: Container()),
          trailing,
        ],
      ),
    );
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
              customListTile(
                leading: const Icon(Icons.brightness_4),
                title: 'Theme Mode',
                subtitle: 'Current theme mode for this app.',
                trailing: DropdownMenu<ThemeMode>(
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
                  customTextField(
                    leading: const Icon(Icons.perm_identity),
                    title: 'HoYoverse\'s LTUID',
                    subtitle: 'Your LTUID from HoYoLab.',
                    hintText: 'Enter your LTUID',
                    controller: hoyoverseLTUIDController,
                    setting: SettingsRepository.hoyoverseLTUID,
                  ),
                  customTextField(
                    leading: const Icon(Icons.vpn_key),
                    title: 'HoYoverse\'s LToken',
                    subtitle: 'Your LToken from HoYoLab.',
                    hintText: 'Enter your LToken',
                    controller: hoyoverseLTokenController,
                    setting: SettingsRepository.hoyoverseLToken,
                  ),
                  customTextField(
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
