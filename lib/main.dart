import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:markus/Screens/bottom_nav_bar.dart';

import 'Utilities/firebase_api.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseApi firebaseApi = FirebaseApi(); // Create an instance of FirebaseApi
  await firebaseApi
      .initNotifications(); // Call initNotifications on the instance
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        home: BottomNavBar());
  }
}
