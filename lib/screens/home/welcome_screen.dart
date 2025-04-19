// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diabetic/screens/auth/login_screen.dart';
import 'package:diabetic/screens/auth/signup_screen.dart';
import 'package:diabetic/widgets/buttons/buttons.dart';
import 'package:flutter/material.dart';
import 'package:diabetic/utils/constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.title});
  final String title;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // متغير ليحدد ماذا يعرض علي شاشة التطبيق
  String myView = "welcome";

  // Internet Connection Checker :---
  late ConnectivityResult result;
  late StreamSubscription subscription;
  var isDeviceConnected = false;

  @override
  void initState() {
    super.initState();
    checkInternet();
    startStreaming();
  }

// دالة لتغير ما يعرض
  changeMyView(view) {
    setState(() {
      myView = view;
    });
  }

// التحقق من اتصال النت
  checkInternet() async {
    result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      isDeviceConnected = true;
    } else {
      isDeviceConnected = false;
      showDialogBox();
    }
    setState(() {});
  }

// عمل ايفينت مستمر للتحقق من النت اثناء عمل التطبيق
  startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      backgroundColor: Theme.of(context).canvasColor,
      // عرض التطبيق علي حسب حالة المتغير
      body: (myView == "login"
          ? LoginScreen(
              view: changeMyView,
            )
          : myView == "signup"
              ? SignupScreen(view: changeMyView)
              :
              // صفحة الترحيب
              Column(
                  children: [
                    Expanded(
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("assets/images/logo.png"),
                        radius: 110,
                      ),
                    ),
                    Text(
                      "Welcome to Diabetic ",
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Container(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          MyButton(
                            text: Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                myView = "login";
                              });
                            },
                            buttonColor: kPrimaryColor,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          MyButton(
                            text: Text("Signup",
                                style: TextStyle(
                                    fontSize: 21, color: Colors.white)),
                            onPressed: () {
                              setState(() {
                                myView = "signup";
                              });
                            },
                            buttonColor: kSecondaryColor,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                    )
                  ],
                )),
      // نهاية صفحة الترحيب
      extendBody: true,
    );
  }

  // Internet error Dialog Box
  showDialogBox() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                "No internet connection",
                style: TextStyle(
                    fontFamily: "SpotifyCircularBold", color: Colors.white),
              ),
              content: const Text(
                "Turn on mobile data or connect to Wi-Fi.",
                style: TextStyle(
                    fontFamily: "SpotifyCircularLight",
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              backgroundColor: kSecondarySwatchColor,
              actionsAlignment: MainAxisAlignment.center,
              surfaceTintColor: Colors.red,
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      checkInternet();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.white,
                        elevation: 10,
                        textStyle: const TextStyle(
                            fontFamily: "SpotifyCircularBold",
                            color: Colors.white,
                            fontSize: 18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        fixedSize: const Size(250, 50)),
                    child: const Text("Try Again"))
              ],
            ));
  }
}
