import 'package:flutter/material.dart';
import 'package:sga/client/controller/theme/theme_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  final TextEditingController themeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final themeMode = ThemeProvider.of(context)?.state;
    themeController.text = formatThemeMode(themeMode);
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
