import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();

  static final key = GlobalKey<NavigatorState>();

  static BuildContext get context {
    if (key.currentContext == null) {
      throw Exception('Context is not available');
    }
    return key.currentContext!;
  }

  static Future<T?> push<T>(Widget screen) async {
    return await key.currentState?.push<T>(
      CupertinoPageRoute(builder: (_) => screen),
    );
  }

  static void replace(Widget screen) async {
    await key.currentState?.pushReplacement(
      CupertinoPageRoute(builder: (_) => screen),
    );
  }

  static void remove(Widget screen) async {
    await key.currentState?.pushAndRemoveUntil(
      CupertinoPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }

  static void pop() => key.currentState?.pop();

  static void sheet(Widget sheet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      // isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: sheet,
      ),
    );
  }

  static void dialog(Widget dialog) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => dialog,
    );
  }
}
