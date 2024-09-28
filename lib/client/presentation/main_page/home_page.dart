import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const Divider(),
          Text(
            'Super Game App',
            style: theme.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 20.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('assets/images/logo/logo.png'),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  'Welcome to Super Game App!',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Open source hub for all your favourite games tools and resources.',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'From SkyJT, 28/9/2024',
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          Text(
            'Features Todo List',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ExpansionTile(
            title: const Text('HoYoverse'),
            children: [
              ListTile(
                title: const Text('Manual Check-in'),
                subtitle: const Text(
                  'Auto daily login for Honkai Impact 3rd, Tears of Themis, Genshin Impact, Honkai Star Rail and Zenless Zone Zero',
                ),
                trailing: Checkbox.adaptive(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
              ListTile(
                title: const Text('Auto Check-in (Android and iOS)'),
                subtitle: const Text(
                  'Auto daily login for Honkai Impact 3rd, Tears of Themis, Genshin Impact, Honkai Star Rail and Zenless Zone Zero',
                ),
                trailing: Checkbox.adaptive(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('KuroGame'),
            children: [
              ListTile(
                title: const Text('Manual Check-in'),
                subtitle: const Text(
                  'Auto daily login for Punishing: Gray Raven and Wuthering Waves',
                ),
                trailing: Checkbox.adaptive(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              ListTile(
                title: const Text('Auto Check-in (Android and iOS)'),
                subtitle: const Text(
                  'Auto daily login for Punishing: Gray Raven and Wuthering Waves',
                ),
                trailing: Checkbox.adaptive(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
