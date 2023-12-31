// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBiunuMtS6_izsjvyC9RgCOJClH-cxBeZg',
    appId: '1:558943473280:web:0e8fb3b61bc078e907e065',
    messagingSenderId: '558943473280',
    projectId: 'cls055-codoc',
    authDomain: 'cls055-codoc.firebaseapp.com',
    storageBucket: 'cls055-codoc.appspot.com',
    measurementId: 'G-D7B926295X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpcopR7yJL_Q-qhVfb0lOaus93TBsonzw',
    appId: '1:558943473280:android:0d958b431c1602ff07e065',
    messagingSenderId: '558943473280',
    projectId: 'cls055-codoc',
    storageBucket: 'cls055-codoc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB34Aimw3Req8rboMhP9WYYGs4KKfMzOfo',
    appId: '1:558943473280:ios:a3461bafa69a69b807e065',
    messagingSenderId: '558943473280',
    projectId: 'cls055-codoc',
    storageBucket: 'cls055-codoc.appspot.com',
    iosBundleId: 'com.example.codoc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB34Aimw3Req8rboMhP9WYYGs4KKfMzOfo',
    appId: '1:558943473280:ios:b93e30c0c039644f07e065',
    messagingSenderId: '558943473280',
    projectId: 'cls055-codoc',
    storageBucket: 'cls055-codoc.appspot.com',
    iosBundleId: 'com.example.codoc.RunnerTests',
  );
}
