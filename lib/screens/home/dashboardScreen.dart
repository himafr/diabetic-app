//import 'dart:js_util';
// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diabetic/screens/books/booksScreen.dart';
import 'package:diabetic/screens/main/components/side_menu.dart';
import 'package:diabetic/screens/main/main_screen.dart';
import 'package:diabetic/screens/recipes/recipesScreen.dart';
import 'package:diabetic/widgets/state/loading_state/loading_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/screens/meds/meds_screen.dart';
import 'package:diabetic/screens/home/homeScreen.dart';
import 'package:heroicons/heroicons.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.title});
  final String title;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int myView = 1;
  
  goToChartScreen() {
    // await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  MainScreen(),
        ));
  }

  int currentIndex = 2;
  bool bookColor = false;
  // Color recipeColor = Colors.white54;
  // Color homeColor = Colors.white;
  // Color medColor = Colors.white54;
  // Color chatColor = Colors.white54;
  double bookSize = 24;
  double bookTextSize = 13;
  double recipeSize = 24;
  double recipeTextSize = 13;
  double homeSize = 27;
  double homeTextSize = 15;
  double medSize = 24;
  double medTextSize = 13;
  double chatSize = 24;
  double chatTextSize = 13;

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

  startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternet();
    });
  }

  setDefault() {
    bookColor = false;
    bookSize = 24;
    bookTextSize = 13;
    recipeSize = 24;
    recipeTextSize = 13;
    homeSize = 24;
    homeTextSize = 13;
    medSize = 24;
    medTextSize = 13;
    chatSize = 24;
    chatTextSize = 13;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: kSecondaryColor,
        ),
      drawer:const SideMenu(),

        body:  (myView == 0
                ? const BooksScreen()
                : myView == 1
                    ? const RecipesScreen()
                    : myView == 2
                        ? const MedsScreen()
                        :    const LoadingChatsScreen()
                            )
          ,
        extendBody: true,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
          height: 70,
          child: Theme(
            data: Theme.of(context).copyWith(
                splashColor: Colors.white24,
                highlightColor: Colors.transparent),
            child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) => setState(() {
                      currentIndex = index;
                      if (currentIndex == 0) {
                        setDefault();
                        bookSize = 27;
                        bookColor = true;
                        myView = currentIndex;
                      }
                      if (currentIndex == 1) {
                        setDefault();
                        recipeSize = 27;
                        myView = currentIndex;
                        // goToChartScreen();
                      }
                    
                      if (currentIndex == 2) {
                        setDefault();
                        medSize = 27;
                        myView = currentIndex;
                      }
                     
                    }),
                type: BottomNavigationBarType.fixed,
                backgroundColor: Theme.of(context).canvasColor.withOpacity(0.5),
                // selectedItemColor: Colors.white,
                // unselectedItemColor: Colors.white54,
                selectedFontSize: 15,
                unselectedFontSize: 13,
                //useLegacyColorScheme: false,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Image.asset("assets/icons/library.png",
                          height: bookSize,
                          width: bookSize,
                          color: bookColor
                              ? BottomNavigationBarTheme.of(context)
                                  .selectedItemColor
                              : BottomNavigationBarTheme.of(context)
                                  .unselectedItemColor),
                      label: "Books"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.food_bank, size: recipeSize),
                      label: "Recipes"),
                  
                  BottomNavigationBarItem(
                      icon: Icon(Icons.medication_liquid_sharp, size: medSize),
                      label: "Medication"),
                ]),
          ),
        ));
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
                   color: Colors.white),
              ),
              content: const Text(
                "Turn on mobile data or connect to Wi-Fi.",
                style: TextStyle(
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
