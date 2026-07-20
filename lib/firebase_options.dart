// File generated to configure Firebase without relying on the native
// GoogleService-Info.plist / google-services.json being present in the app
// bundle. Values mirror the Firebase project `influerax-c6eda`.
//
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
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
    apiKey: 'AIzaSyBVEXYUWnVQlRGRlBzBzE0PG490256smdg',
    appId: '1:275276598948:android:61fd0fa66eed7612c06031',
    messagingSenderId: '275276598948',
    projectId: 'influerax-c6eda',
    storageBucket: 'influerax-c6eda.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnnGtgcqGEd0Qf4IOEEqcSsONTkgU7Gc8',
    appId: '1:275276598948:ios:8759efbc076ad221c06031',
    messagingSenderId: '275276598948',
    projectId: 'influerax-c6eda',
    storageBucket: 'influerax-c6eda.firebasestorage.app',
    iosBundleId: 'com.digitalx.influerax',
  );
}
