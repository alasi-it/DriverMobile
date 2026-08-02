import 'dart:async';

import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService {
  static final OneSignalService _instance = OneSignalService._internal();
  factory OneSignalService() => _instance;
  OneSignalService._internal();

  Future<void> init(String appId) async {
    OneSignal.initialize(appId);
    // a2358585-e446-46d0-918e-b8ee6de67fc7
    await OneSignal.Notifications.requestPermission(true);

    await _waitForPlayerId();
  }

  Future<String?> _waitForPlayerId() async {
    final id = OneSignal.User.pushSubscription.id;
    if (id != null) {
      print('Player ID: $id');
      return id;
    }

    final completer = Completer<String?>();

    OneSignal.User.pushSubscription.addObserver((state) {
      final newId = state.current.id;
      if (newId != null && !completer.isCompleted) {
        print('Player ID: $newId');
        completer.complete(newId);
      }
    });

    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        print('Timeout: User not subscribed');
        return null;
      },
    );
  }
}
