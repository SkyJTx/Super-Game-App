import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sga/server/repository/settings_repository.dart';
import 'package:sizer/sizer.dart';

class ListTileTextField extends StatefulWidget {
  const ListTileTextField({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.hintText,
    required this.controller,
    required this.setting,
  });

  final Icon leading;
  final String title;
  final String subtitle;
  final String hintText;
  final TextEditingController controller;
  final SettingsRepository setting;

  @override
  State<ListTileTextField> createState() => ListTileTextFieldState();
}

class ListTileTextFieldState extends State<ListTileTextField> {
  @override
  Widget build(BuildContext context) {
    final leading = widget.leading;
    final title = widget.title;
    final subtitle = widget.subtitle;
    final hintText = widget.hintText;
    final controller = widget.controller;
    final setting = widget.setting;
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
            ],
          ),
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
}
