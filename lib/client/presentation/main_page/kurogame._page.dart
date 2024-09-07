import 'package:flutter/material.dart';

class KurogamePage extends StatefulWidget {
  const KurogamePage({super.key});

  @override
  State<KurogamePage> createState() => KurogamePageState();
}

class KurogamePageState extends State<KurogamePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Hello, World! Kuro Game'),
    );
  }
}