import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCoL6B8gBVn3ig3rZM0e1CP6vKpSVqX5Tk",
    appId: '1:367786877911:android:a83feaf9bd2fead34d2192',
    messagingSenderId: '367786877911',
    projectId: 'ramasser-99a1f',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyCoL6B8gBVn3ig3rZM0e1CP6vKpSVqX5Tk",
    appId: '1:367786877911:android:a83feaf9bd2fead34d2192',
    messagingSenderId: '367786877911',
    projectId: 'ramasser-99a1f',
    // iosBundleId: 'com.allotaxi.driver',
  );
}
