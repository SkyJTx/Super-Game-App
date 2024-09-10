import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sga/client/controller/theme/theme_bloc.dart';
import 'package:sga/server/repository/settings_repository.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.perm_identity),
          title: const Text('HoYoverse\'s LTUID'),
          subtitle: const Text('Your LTUID for HoYoLab.'),
          trailing: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 145),
            child: TextField(
              controller: hoyoverseLTUIDController,
              decoration: const InputDecoration(
                hintText: 'Enter your LTUID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              onEditingComplete: () async {
                final ltuid = hoyoverseLTUIDController.text;
                await SettingsRepository.hoyoverseLTUID.set(ltuid);
              },
              onTapOutside: (event) async {
                final ltuid = hoyoverseLTUIDController.text;
                await SettingsRepository.hoyoverseLTUID.set(ltuid);
              },
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.vpn_key),
          title: const Text('HoYoverse\'s LToken'),
          subtitle: const Text('Your LToken for HoYoLab.'),
          trailing: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 145),
            child: TextField(
              controller: hoyoverseLTokenController,
              decoration: const InputDecoration(
                hintText: 'Enter your LToken',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              onEditingComplete: () async {
                final ltuid = hoyoverseLTokenController.text;
                await SettingsRepository.hoyoverseLToken.set(ltuid);
              },
              onTapOutside: (event) async {
                final ltuid = hoyoverseLTokenController.text;
                await SettingsRepository.hoyoverseLToken.set(ltuid);
              },
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.phone_android),
          title: const Text('HoYoverse\'s Device ID'),
          subtitle: const Text('Your Device ID for HoYoLab.'),
          trailing: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 145),
            child: TextField(
              controller: hoyoverseDeviceIDController,
              decoration: const InputDecoration(
                hintText: 'Enter your Device ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              onEditingComplete: () async {
                final ltuid = hoyoverseDeviceIDController.text;
                await SettingsRepository.hoyoverseDeviceId.set(ltuid);
              },
              onTapOutside: (event) async {
                final ltuid = hoyoverseDeviceIDController.text;
                await SettingsRepository.hoyoverseDeviceId.set(ltuid);
              },
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.brightness_4),
          title: const Text('Theme Mode'),
          subtitle: const Text('Current theme mode for this app.'),
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
    );
  }
}
