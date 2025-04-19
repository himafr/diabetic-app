import 'package:diabetic/screens/home/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import 'dashboardScreen.dart';

class PresplashScreen extends StatefulWidget {
  const PresplashScreen({super.key, required this.title});
  final String title;
  @override
  State<PresplashScreen> createState() => _PresplashScreenState();
}

class _PresplashScreenState extends State<PresplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateTo();
  }

  _navigateTo() async {
    // Wait for 3 seconds before navigating to the home screen
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    // تحميل التوكن من الذاكره و التاكد انها تعمل
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token;
    if (prefs.containsKey("token")) {
      token = prefs.getString("token") ?? "";
    } else {
      token = "";
    }
    try {
      // فك التوكن للحصول علي بيانات المستخدم
      JwtDecoder.decode(token);
      if (JwtDecoder.isExpired(token)) {
        throw const FormatException("Expired token");
      }
      // داله للذهاب الي الصفحة الرئيسيه للتطبيق
      _goHome();
    } catch (e) {
      // داله للذهاب الي صفحة التسجيل للتطبيق
      _goLogin();
    }
  }

  _goLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(
          title: "welcome",
        ),
      ),
    );
  }

  _goHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(title: "DashboardScreen"),
      ),
    );
  }

  @override
  // اللوجو اللي بيتعرض اثناء العمليت اللي بتم فوق
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: Image.asset("assets/images/logo1.png",
            width: screenWidth / 1.25, height: screenHeight / 1.25),
      ),
    );
  }
}
