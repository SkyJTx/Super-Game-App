import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 200 * 1.414,
          ),
          child: CarouselView(
            itemExtent: min(90.w, 400),
            itemSnapping: true,
            elevation: 4,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(8),
            children: List.generate(
              4,
              (index) {
                return Container(
                  alignment: Alignment.center,
                  color: theme.colorScheme.surfaceContainerHigh,
                  child: Text(
                    'Claim Daily Login!',
                    style: theme.textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
