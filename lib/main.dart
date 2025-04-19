import 'dart:async';
import 'package:diabetic/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/screens/home/presplash_screen.dart';
import 'package:intl/intl_standalone.dart' if(dart.library.html)"package:intl/intl_browser.dart";

// الداله الرئيسية لتشغيل التطبيق
Future<void> main() async{
  // متطلبات لتشغيل النظام
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  // خصائص سريعه لشكل التطبيق للتطبيق
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
      // عرض الصفحة المؤقته التي تحتوي علي اللوجو
      home: const PresplashScreen(title: 'Diabetic - Presplash Screen'),
    );
  }
}
