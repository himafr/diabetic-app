// import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:diabetic/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/screens/home/presplashScreen.dart';
import 'package:intl/intl_standalone.dart' if(dart.library.html)"package:intl/intl_browser.dart";
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabetic Care',
       theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme.copyWith(scaffoldBackgroundColor: kSecondaryColor),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const PresplashScreen(title: 'Diabetic - Presplash Screen'),
    );
  }
}
