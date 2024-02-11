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
    apiKey: 'AIzaSyAmLhFjDZJRRxVnZwAusa5TKtcYiL0Om_Y',
    appId: '1:169802077515:web:9621c1a74caeb581c784ce',
    messagingSenderId: '169802077515',
    projectId: 'bazaar-8b2e0',
    authDomain: 'bazaar-8b2e0.firebaseapp.com',
    storageBucket: 'bazaar-8b2e0.appspot.com',
    measurementId: 'G-Z1EW01YTVW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDijlm-HvsmvS1PQQZak1WwiT6TSzxxaX8',
    appId: '1:169802077515:android:23536bff1b675196c784ce',
    messagingSenderId: '169802077515',
    projectId: 'bazaar-8b2e0',
    storageBucket: 'bazaar-8b2e0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2BkhZCF2tKMZYIO06FtXIilEEP-KmEuo',
    appId: '1:169802077515:ios:210b4fa2a83a90cfc784ce',
    messagingSenderId: '169802077515',
    projectId: 'bazaar-8b2e0',
    storageBucket: 'bazaar-8b2e0.appspot.com',
    iosBundleId: 'com.example.baazar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2BkhZCF2tKMZYIO06FtXIilEEP-KmEuo',
    appId: '1:169802077515:ios:aef06e2a78849458c784ce',
    messagingSenderId: '169802077515',
    projectId: 'bazaar-8b2e0',
    storageBucket: 'bazaar-8b2e0.appspot.com',
    iosBundleId: 'com.example.baazar.RunnerTests',
  );
}
