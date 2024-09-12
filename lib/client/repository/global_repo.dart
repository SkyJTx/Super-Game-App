import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalRepository {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static GlobalRepository of(BuildContext context) {
    return RepositoryProvider.of<GlobalRepository>(context);
  }

  void showSnackBar(Widget content, {Color? color}) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: content,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
