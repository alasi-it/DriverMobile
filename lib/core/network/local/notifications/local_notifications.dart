import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  log('Background notification tap: ${notificationResponse.payload}');
}

class LocalNotificationService {
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    try {
      if (Platform.isAndroid) {
        final androidPlugin = _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
        if (androidPlugin != null) {
          await androidPlugin.requestNotificationsPermission();

          await androidPlugin.createNotificationChannel(
            AndroidNotificationChannel(
              'PushNotificationApp',
              'PushNotificationAppChannel',
              description: 'notifications.channel_description'.tr(),
              importance: Importance.max,
              playSound: true,
              enableVibration: true,
              showBadge: true,
            ),
          );
        }
      }

      if (Platform.isIOS) {
        final iosPlugin = _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();
        if (iosPlugin != null) {
          await iosPlugin.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
        }

        final settings = await FirebaseMessaging.instance.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );

        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
          if (apnsToken == null) {
            log("APNS token not available yet.");
          } else {
            log("APNS Token: $apnsToken");
          }
        } else {
          log("Notification permission not granted");
        }
      }

      const initialSettings = InitializationSettings(
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      );

      await _notificationsPlugin.initialize(
        initialSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          if (response.payload != null && response.payload!.isNotEmpty) {
            receiveNotification(response);
          }
        },
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );

      log("Notification service initialized successfully.");
    } catch (e) {
      log("Error initializing notification service: $e");
    }
  }

  static void receiveNotification(NotificationResponse response) {
    try {
      if (response.payload != null && response.payload!.isNotEmpty) {
        Map<String, dynamic> data = jsonDecode(response.payload!);
        navigateNotification(data);
      }
    } catch (e) {
      log("Error handling notification response: $e");
    }
  }

  static void navigateNotification(Map<String, dynamic> data) {
    log("Navigating with data: $data");
  }

  static Future<void> displayNotification(RemoteMessage message) async {
    try {
      final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final androidDetails = AndroidNotificationDetails(
        'PushNotificationApp',
        'PushNotificationAppChannel',
        channelDescription: 'notifications.channel_description'.tr(),
        priority: Priority.high,
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
        icon: '@mipmap/ic_launcher',
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notificationsPlugin.show(
        id,
        message.notification?.title ?? 'notifications.new_notification'.tr(),
        message.notification?.body ?? '',
        notificationDetails,
        payload: jsonEncode(message.data),
      );

      log("Notification displayed successfully with id: $id");
    } catch (e) {
      log('Error creating and displaying notification: $e');
    }
  }

  static Future<void> displayPopNotification(
    NotificationModel notification,
  ) async {
    try {
      final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final androidDetails = AndroidNotificationDetails(
        'PushNotificationApp',
        'PushNotificationAppChannel',
        channelDescription: 'notifications.channel_description'.tr(),
        priority: Priority.high,
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
        icon: '@mipmap/ic_launcher',
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final notificationDetailsPop = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final Map<String, dynamic> data = {
        'id': notification.sId ?? '',
        'type': notification.type ?? '',
        'status': notification.status ?? '',
      };

      await _notificationsPlugin.show(
        id,
        notification.title ?? 'notifications.new_notification'.tr(),
        notification.message ?? '',
        notificationDetailsPop,
        payload: jsonEncode(data),
      );

      log("Pop notification displayed successfully with id: $id");
    } catch (e) {
      log('Error displaying pop notification: $e');
    }
  }

  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  static Future<List<ActiveNotification>> getActiveNotifications() async {
    if (Platform.isAndroid) {
      final androidPlugin = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (androidPlugin != null) {
        return await androidPlugin.getActiveNotifications();
      }
    }
    return [];
  }

  static Future<List<PendingNotificationRequest>>
  getPendingNotifications() async {
    return await _notificationsPlugin.pendingNotificationRequests();
  }

  static String convertJsonFormat(String? jsonStr) {
    if (jsonStr == null || jsonStr.isEmpty) return '{}';

    try {
      return jsonStr.replaceAllMapped(RegExp(r'(\w+)(\s*:\s*)(\w+)'), (match) {
        String key = match.group(1)!;
        String colon = match.group(2)!;
        String value = match.group(3)!;
        bool isNumeric = double.tryParse(value) != null;
        bool isBoolean = value == 'true' || value == 'false';
        if (!isNumeric && !isBoolean) value = '"$value"';
        return '"$key"$colon$value';
      });
    } catch (e) {
      log('Error converting JSON format: $e');
      return '{}';
    }
  }
}

class NotificationModel {
  String? sId;
  String? type;
  String? status;
  String? priority;
  String? readAt;
  String? createdAt;
  String? updatedAt;
  String? notificationImage;
  String? title;
  String? message;

  NotificationModel({
    this.sId,
    this.type,
    this.status,
    this.priority,
    this.readAt,
    this.createdAt,
    this.updatedAt,
    this.notificationImage,
    this.title,
    this.message,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    title = json['title'];
    message = json['message'];
    priority = json['priority'];
    notificationImage = json['notificationImage'];
    status = json['status'];
    readAt = json['readAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'type': type,
      'title': title,
      'message': message,
      'priority': priority,
      'notificationImage': notificationImage,
      'status': status,
      'readAt': readAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  static List<NotificationModel> fromListJson(List data) {
    return data.map((e) => NotificationModel.fromJson(e)).toList();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final NotificationModel otherCategory = other as NotificationModel;
    return sId == otherCategory.sId;
  }

  @override
  int get hashCode => sId.hashCode;

  @override
  String toString() {
    return 'NotificationModel(id: $sId, title: $title, message: $message)';
  }
}
