import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/config/app_theme.dart';
import 'package:myenglish/core/utils/services/fcm.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/features/onboarding/presentation/common/screens/splash_screen.dart';
import 'package:resize/resize.dart';

// The following functionalities are disabled to resolve compilation issues:
// file_picker, video_thumbnail, omni_jitsi_meet, intl_phone_field
// Their related imports and any usage have been removed.
// import 'package:file_picker/file_picker.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
// import 'package:omni_jitsi_meet/omni_jitsi_meet.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

import 'di/di.dart';

var didReceiveLocalNotificationStream = StreamController.broadcast();

@pragma('vm:entry-point')
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    print("212121 Handling a background message:");
    didReceiveLocalNotificationStream.add('refresh');
    PushNotificationService().sendNotification(message);
  } catch (e) {
    print('2121 catch:$e');
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlDownloader.initialize();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ),
  );
  await Prefs().instance();

  await PushNotificationService().setupInteractedMessage();

  // To handle any interaction when App is not open
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    print('212121 App received a notification when it was killed');
    PushNotificationService().sendNotification(initialMessage);
  }

  // Triggered on receiving a Message when App is in background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const ProviderScope(child: MyApp()));
}

final GlobalKey navigatorKey = GlobalKey();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // The internetProvider remains in use if defined in your dependency injection.
    var mInternetProvider = ref.watch(internetProvider);
    return Resize(
      size: const Size(393, 852),
      builder: () => MaterialApp(
        title: 'Ramasser Group Virtual Academy',
        theme: AppTheme().themeData,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        home: const SplashScreen(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
