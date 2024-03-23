import 'package:flutter/material.dart';
import 'package:mental_healthapp/features/auth/screens/create_profile.dart';
import 'package:mental_healthapp/features/auth/screens/splash_screen.dart';
import 'package:mental_healthapp/features/check%20in/intro.dart';
import 'package:mental_healthapp/theme/theme.dart';
import 'package:mental_healthapp/views/home.dart';
import 'package:mental_healthapp/views/navScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: EAppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: CheckInIntro());
  }
}
