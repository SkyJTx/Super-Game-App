import 'package:flutter/material.dart';

class HoyoverseGameCard extends StatefulWidget {
  const HoyoverseGameCard({
    super.key,
    required this.enabled,
    required this.imageProvider,
    required this.title,
    required this.onCheckIn,
  });

  final bool enabled;
  final ImageProvider imageProvider;
  final String title;
  final void Function() onCheckIn;

  @override
  State<HoyoverseGameCard> createState() => HoyoverseGameCardState();
}

class HoyoverseGameCardState extends State<HoyoverseGameCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image(
              image: widget.imageProvider,
              width: 400,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4, left: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            end: 4,
            bottom: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  ),
                  onPressed: widget.enabled ? widget.onCheckIn : null,
                  child: const Text('Check-In'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
