import 'package:appsita/team_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAJMNfJ4YXI9mKl74Lr8fH6YRIZG1zav_k',
    appId: '1:23844375855:android:bc7fd7fb5f10a1323d25da',
    messagingSenderId: '23844375855',
    projectId: 'appsitabb',
    storageBucket: 'appsitabb.firebasestorage.app',
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const TeamsScreen(),
    );
  }
}
