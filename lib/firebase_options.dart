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
    apiKey: 'AIzaSyDVvAOVgzKi-rg-avsgckHA47U_-TORYSY',
    appId: '1:82501261467:web:9071b7da6afd00d784ce3e',
    messagingSenderId: '82501261467',
    projectId: 'sustainx-9d820',
    authDomain: 'sustainx-9d820.firebaseapp.com',
    storageBucket: 'sustainx-9d820.appspot.com',
    measurementId: 'G-8CXVL6XTY4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCM2d_ioKhP7NmnW9gIu8thE0ghEhQD9yo',
    appId: '1:82501261467:android:e2f7930670d6350984ce3e',
    messagingSenderId: '82501261467',
    projectId: 'sustainx-9d820',
    storageBucket: 'sustainx-9d820.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC49Fc7EpfN1n49jilnyCzIpF76YFl5ym8',
    appId: '1:82501261467:ios:d6199adf50b2b12f84ce3e',
    messagingSenderId: '82501261467',
    projectId: 'sustainx-9d820',
    storageBucket: 'sustainx-9d820.appspot.com',
    iosClientId: '82501261467-n1g75uiia56e18krqb6g4jt3229ocbf8.apps.googleusercontent.com',
    iosBundleId: 'com.example.trashpickup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC49Fc7EpfN1n49jilnyCzIpF76YFl5ym8',
    appId: '1:82501261467:ios:068c71538244fa6a84ce3e',
    messagingSenderId: '82501261467',
    projectId: 'sustainx-9d820',
    storageBucket: 'sustainx-9d820.appspot.com',
    iosClientId: '82501261467-cdk3l553a54fh4cr5ll5nfmm8rht6nbt.apps.googleusercontent.com',
    iosBundleId: 'com.example.trashpickup.RunnerTests',
  );
}
