// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyD8tejg7ysXBWHFt0OpEVXn94zYd_baa6Y',
    appId: '1:880067908733:web:82f6c65d466c30d4128d14',
    messagingSenderId: '880067908733',
    projectId: 'medicareplus-d444c',
    authDomain: 'medicareplus-d444c.firebaseapp.com',
    storageBucket: 'medicareplus-d444c.appspot.com',
    measurementId: 'G-61H5VX17L7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDmhsI-RQjR5OxmO7hvG6-kGmSrprSrI8',
    appId: '1:880067908733:android:8f113de7bcc5a332128d14',
    messagingSenderId: '880067908733',
    projectId: 'medicareplus-d444c',
    storageBucket: 'medicareplus-d444c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACYEJNfwVc_4JsZbv4ogST6fhMw4U8pH4',
    appId: '1:880067908733:ios:51ca4a14119483b5128d14',
    messagingSenderId: '880067908733',
    projectId: 'medicareplus-d444c',
    storageBucket: 'medicareplus-d444c.appspot.com',
    iosBundleId: 'com.example.mediCare',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD8tejg7ysXBWHFt0OpEVXn94zYd_baa6Y',
    appId: '1:880067908733:web:4e401cb430a92001128d14',
    messagingSenderId: '880067908733',
    projectId: 'medicareplus-d444c',
    authDomain: 'medicareplus-d444c.firebaseapp.com',
    storageBucket: 'medicareplus-d444c.appspot.com',
    measurementId: 'G-FX15DNDG86',
  );

}