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
    apiKey: 'AIzaSyAntG1kZq3nu3Hn5ScbDcpjtS9GQvfNLb8',
    appId: '1:425581425786:web:7266f515458b80273777c3',
    messagingSenderId: '425581425786',
    projectId: 'flutterproject-ae729',
    authDomain: 'flutterproject-ae729.firebaseapp.com',
    databaseURL: 'https://flutterproject-ae729-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterproject-ae729.appspot.com',
    measurementId: 'G-8RZGSJ9KY3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIV01lYSYSKpcXkj4_6haPK7kSf7B4YnA',
    appId: '1:425581425786:android:d794bdc7f89300543777c3',
    messagingSenderId: '425581425786',
    projectId: 'flutterproject-ae729',
    databaseURL: 'https://flutterproject-ae729-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterproject-ae729.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUgk66aVxjAJGaFczwsDOgryj9xVc-hwY',
    appId: '1:425581425786:ios:80c69e25d2ecdbb33777c3',
    messagingSenderId: '425581425786',
    projectId: 'flutterproject-ae729',
    databaseURL: 'https://flutterproject-ae729-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterproject-ae729.appspot.com',
    iosClientId: '425581425786-1hulf5bo63ql26on1sn8k8o8slt3viet.apps.googleusercontent.com',
    iosBundleId: 'com.example.musicApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUgk66aVxjAJGaFczwsDOgryj9xVc-hwY',
    appId: '1:425581425786:ios:80c69e25d2ecdbb33777c3',
    messagingSenderId: '425581425786',
    projectId: 'flutterproject-ae729',
    databaseURL: 'https://flutterproject-ae729-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterproject-ae729.appspot.com',
    iosClientId: '425581425786-1hulf5bo63ql26on1sn8k8o8slt3viet.apps.googleusercontent.com',
    iosBundleId: 'com.example.musicApp',
  );
}
