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
    apiKey: 'AIzaSyArNBw2nGYvjkV1xxDKhICaIMpM4wGYIZY',
    appId: '1:680904674263:web:7e76098302b7d3a0121992',
    messagingSenderId: '680904674263',
    projectId: 'ovide-notes',
    authDomain: 'ovide-notes.firebaseapp.com',
    storageBucket: 'ovide-notes.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCS-jgMRDMMCGdJSLA2mwNF_1RraqcGnx4',
    appId: '1:680904674263:android:520f645651a6cdb3121992',
    messagingSenderId: '680904674263',
    projectId: 'ovide-notes',
    storageBucket: 'ovide-notes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmTdN7tbgtCBbwQtjhz3NFSkfPZZVEF6Q',
    appId: '1:680904674263:ios:768ad1a1f1b6c28f121992',
    messagingSenderId: '680904674263',
    projectId: 'ovide-notes',
    storageBucket: 'ovide-notes.appspot.com',
    iosBundleId: 'com.example.notesapp',
  );
}
