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

  void showSuccessSnackBar(BuildContext context, {required String message}) {
    showSnackBar(
      Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
      ),
      color: Colors.green,
    );
  }

  void showWarningSnackBar(BuildContext context, {required String message}) {
    showSnackBar(
      Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
      ),
      color: Colors.orange,
    );
  }

  void showErrorSnackBar(BuildContext context, {required String message}) {
    showSnackBar(
      Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
      ),
      color: Colors.red,
    );
  }
}
