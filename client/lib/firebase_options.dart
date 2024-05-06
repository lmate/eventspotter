// File generated by FlutterFire CLI.
/* 
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
        return macos;
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
    apiKey: 'AIzaSyDxgdHvIlohxPXcHdlkfhh6Zm38LSijqH4',
    appId: '1:592418559933:web:38de0b7568be7b530964d4',
    messagingSenderId: '592418559933',
    projectId: 'balmat-places',
    authDomain: 'balmat-places.firebaseapp.com',
    databaseURL: 'https://balmat-places-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'balmat-places.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJJ8vzdv18Xel3jTcN8bp7OVmb3eF3xgA',
    appId: '1:592418559933:android:d14ae5cece523c9f0964d4',
    messagingSenderId: '592418559933',
    projectId: 'balmat-places',
    databaseURL: 'https://balmat-places-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'balmat-places.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCcUsp9wCLFkpwAVRx6o3P96_TtD0KFIQE',
    appId: '1:592418559933:ios:ca8f5a50956b755a0964d4',
    messagingSenderId: '592418559933',
    projectId: 'balmat-places',
    databaseURL: 'https://balmat-places-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'balmat-places.appspot.com',
    iosBundleId: 'com.example.client',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCcUsp9wCLFkpwAVRx6o3P96_TtD0KFIQE',
    appId: '1:592418559933:ios:ca8f5a50956b755a0964d4',
    messagingSenderId: '592418559933',
    projectId: 'balmat-places',
    databaseURL: 'https://balmat-places-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'balmat-places.appspot.com',
    iosBundleId: 'com.example.client',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDxgdHvIlohxPXcHdlkfhh6Zm38LSijqH4',
    appId: '1:592418559933:web:b67dfcea982baad10964d4',
    messagingSenderId: '592418559933',
    projectId: 'balmat-places',
    authDomain: 'balmat-places.firebaseapp.com',
    databaseURL: 'https://balmat-places-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'balmat-places.appspot.com',
  );

} */