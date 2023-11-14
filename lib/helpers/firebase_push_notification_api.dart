import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:healthy/utils/app_strings.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('===========Title ${message.notification?.title}');
  print('===========Body: ${message.notification?.body}');
  print('===========Payload: ${message.data}');
}

class FirebasePushNotificationApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    print('=========handleMessage:: $message');
    if (message == null) return;

    Get.toNamed(kSplashRoute, arguments: message);
    /*navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => const SplashView(),
      settings: RouteSettings(arguments: message),
    ));*/
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            iOS: const DarwinNotificationDetails(),
            android: AndroidNotificationDetails(
              androidChannel.id,
              androidChannel.name,
              playSound: true, importance: Importance.high,
              channelDescription: androidChannel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future initLocalNotifications() async {
    const ios = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const settings = InitializationSettings(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.initialize(settings, onDidReceiveNotificationResponse: (response) {
      final message = RemoteMessage.fromMap(jsonDecode(response.payload ?? ""));
      handleMessage(message);
    });
    final platfrom = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platfrom?.createNotificationChannel(androidChannel);
  }

  Future<String> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("======fcm token $fcmToken");
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    await initPushNotifications();
    await initLocalNotifications();
    return fcmToken ?? "";
  }
}
