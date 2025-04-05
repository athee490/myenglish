import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/main.dart';
import 'package:path_provider/path_provider.dart';

class PushNotificationService {
  PushNotificationService();

  static getFcmToken() async {
    if (Prefs().getString(Prefs.fcmDeviceToken) == null) {
      FirebaseMessaging firebaseMessaging =
          FirebaseMessaging.instance; // Change here
      firebaseMessaging.getToken().then((token) {
        Prefs().setString(Prefs.fcmDeviceToken, token ?? '');
        print("212121 fcm token is $token");
      });
    }
  }

  Future<void> setupInteractedMessage() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      getFcmToken();
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      //   AppSettings.openNotificationSettings();
      // User denied permission to receive notifications.
      print('User denied permission to receive notifications.');
    }

    await registerNotificationListeners();
  }

  Future<void> registerNotificationListeners() async {
    // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('212121 message ${message.toMap()}');
      log('212121 onMessage Received on foreground ${message.notification!}');
      didReceiveLocalNotificationStream.add('refresh');
      sendNotification(message);
    });

    // To handle any interaction when App is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('212121 handle message on Background ${message.notification}');
/*      Navigator.pushNamed(
          navigatorKey.currentState!.context, AppRoutes.home);*/
    });
  }

  void notificationTapForeGround(NotificationResponse? response) {
    if (response != null) {
      Navigator.pushNamed(navigatorKey.currentState!.context, AppRoutes.splash);
    }
  }

  void sendNotification(RemoteMessage message) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final String attachmentPicturePath =
        await getImageFilePathFromAssets(AppImages.splashBg);
    enableIOSNotifications();

    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: notificationTapForeGround,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '123456', // id
      'Ramasser Group Virtual Academy', // title
      priority: Priority.high,
      largeIcon: FilePathAndroidBitmap(attachmentPicturePath),
      channelDescription: 'This channel is used for important notifications.',
    );
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(sound: 'slow_spring_board.aiff');
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title!,
      message.notification!.body!,
      notificationDetails,
    );
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  Future<String> getImageFilePathFromAssets(String asset) async {
    final byteData = await rootBundle.load(asset);

    final file = File(
        '${(await getTemporaryDirectory()).path}/${asset.split('/').last}');
    if (!file.existsSync()) {
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }

    return file.path;
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  didReceiveLocalNotificationStream.add('refresh');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    Navigator.pushNamed(navigatorKey.currentState!.context, AppRoutes.splash);
  }
}
