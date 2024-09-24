import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final Widget leading;
  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  State<CustomListTile> createState() => CustomListTileState();
}

class CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                widget.leading,
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          widget.trailing,
        ],
      ),
    );
  }
}
