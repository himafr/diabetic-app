//import 'dart:js_util';
// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diabetic/screens/chats/chats_screen.dart';
import 'package:diabetic/screens/books/booksScreen.dart';
import 'package:diabetic/screens/main/components/side_menu.dart';
import 'package:diabetic/screens/main/main_screen.dart';
import 'package:diabetic/screens/recipes/recipesScreen.dart';
import 'package:diabetic/widgets/state/loading_state/loading_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/screens/recipes/recipes_screen.dart';
import 'package:diabetic/screens/home/homeScreen.dart';
import 'package:heroicons/heroicons.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.title});
  final String title;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int myView = 2;
  goToChatScreen() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatsScreen(),
        ));
  }
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
      _loadData();
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
    // recipeColor = Colors.white54;
    // homeColor = Colors.white54;
    // medColor = Colors.white54;
    // chatColor = Colors.white54;
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
  // :---

  // recent Playlist Data :---
  // var recentPlaylistData =
  //     FirebaseFirestore.instance.collection("recentPlaylistData");
  late List<Map<String, dynamic>> recentPlaylistItems;

  // var recentPlayedData =
  //     FirebaseFirestore.instance.collection("recentlyPlayed");
  late List<Map<String, dynamic>> recentPlayedItems;

  // var artistAndPodcasters =
  //     FirebaseFirestore.instance.collection("artistsAndPodcasters");
  late List<Map<String, dynamic>> artistAndPodcastersItems;

  bool isLoaded = false;

  _loadData() async {
    // List<Map<String, dynamic>> recentPlaylistTempList = [];
    // var data_recentPlaylist = await recentPlaylistData.get();

    // List<Map<String, dynamic>> recentPlayedTempList = [];
    // var data_recentPlayed = await recentPlayedData.get();

    // List<Map<String, dynamic>> artistAndPodcastersTempList = [];
    // var data_artistAndPodcasters = await artistAndPodcasters.get();

    // for (var element in data_recentPlaylist.docs) {
    //   recentPlaylistTempList.add(element.data());
    // }

    // for (var element in data_recentPlayed.docs) {
    //   recentPlayedTempList.add(element.data());
    // }

    // for (var element in data_artistAndPodcasters.docs) {
    //   artistAndPodcastersTempList.add(element.data());
    // }

    setState(() {
      recentPlaylistItems = [
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/recentPlaylistImages%2Farijit_singh.jpg?alt=media&token=739a3ad6-2fc9-499b-9a6b-090b6589fa58",
          "name": "Arijit Singh "
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/recentPlaylistImages%2Fkabir_singh.jpg?alt=media&token=5bdfc900-c064-4fa9-9102-aacdc281b3d1",
          "name": " Bollywood Mush "
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/recentPlaylistImages%2Fhardy_sandhu.jpg?alt=media&token=870289a7-69fb-46fd-b3ae-76f36bf46c4c",
          "name": " Hardy Sandhu "
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/recentPlaylistImages%2Fimagine_dragons.jpg?alt=media&token=5307c7e3-6482-4467-8109-48290e3f149d",
          "name": " Imagine Dragons "
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/recentPlaylistImages%2Fkk.jpg?alt=media&token=414cc0d4-88cb-4d9e-a148-dfc622776176",
          "name": " KK "
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/recentPlaylistImages%2Ftriggered_insaan.jpg?alt=media&token=92955770-597d-44a2-9fc0-f1ca25dfc599",
          "name": " Triggered Insaan "
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/recentPlaylistImages%2Ftrs.jpg?alt=media&token=7dbe7d88-ecce-40c7-9d35-71776877e8f1",
          "name": " The Ranveer Show "
        }
      ];
      recentPlayedItems = [
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/artists%2Farijit_singh.jpg?alt=media&token=fe82c1df-bb46-402a-aab8-a2b347b271ed",
          "name": " Arijit Singh",
          "border_radius": 60
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/artists%2Fhardy_sandhu.jpg?alt=media&token=5c5ffa51-70a0-4224-8aee-b7f80cb79b4b",
          "name": " Hardy Sandhu",
          "border_radius": 60
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/artists%2Fkk-artist.jpg?alt=media&token=33edfd81-e065-4205-9d6d-1fa34fb142d0",
          "name": " KK",
          "border_radius": 60
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/artists%2Ftrs-podcast.jpg?alt=media&token=71375af3-4ddd-4bb4-bc39-372f74da7b0f",
          "name": " The Ranveer Show",
          "border_radius": 10
        }
      ];
      artistAndPodcastersItems = [
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/artists%2Far_rahman-artist.jpg?alt=media&token=e3bd5572-8159-4b26-b14f-eeec6e43ce49",
          "name": " AR Rahman",
          "border_radius": 60
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/artists%2Farijit_singh.jpg?alt=media&token=fe82c1df-bb46-402a-aab8-a2b347b271ed",
          "name": " Arijit Singh",
          "border_radius": 60
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/artists%2Fchanakya-podcast.jpg?alt=media&token=68c80206-8815-4416-81b9-70081171029c",
          "name": " Chanakya Niti",
          "border_radius": 10
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/artists%2Fhardy_sandhu.jpg?alt=media&token=5c5ffa51-70a0-4224-8aee-b7f80cb79b4b",
          "name": " Hardy Sandhu",
          "border_radius": 60
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/artists%2Fiqlipse_nova-artist.jpg?alt=media&token=7d81f0d3-9513-43ff-91f7-465f6dcd5bb1",
          "name": " Iqlipse Nova",
          "border_radius": 60
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/artists%2Fkk-artist.jpg?alt=media&token=33edfd81-e065-4205-9d6d-1fa34fb142d0",
          "name": " KK",
          "border_radius": 60
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/artists%2Fpritam-artist.jpg?alt=media&token=0e0b139b-79e9-48c8-a5bb-122c4e1b31c6",
          "name": " Pritam",
          "border_radius": 60
        },
        {
          "image":
              "https://firebasestorage.googleapis.com/v0/b/spotify-179ec.appspot.com/o/artists%2Ftrs-podcast.jpg?alt=media&token=71375af3-4ddd-4bb4-bc39-372f74da7b0f",
          "name": " The Ranveer Show",
          "border_radius": 10
        }
      ];
      isLoaded = true;
    });
  }
  // :---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: kSecondaryColor,
        ),
      drawer:const SideMenu(),

        body: isLoaded
            ? (myView == 0
                ? const BooksScreen()
                : myView == 1
                    ? const RecipesScreen()
                    : myView == 2
                        ? HomeScreen(
                            recentPlayedItems: recentPlayedItems,
                            recentPlaylistItems: recentPlaylistItems,
                            artistAndPodcastersItems: artistAndPodcastersItems)
                        : myView == 3
                            ? const searchScreen()
                            : const LoadingChatsScreen())
            : Container(),
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
                        homeSize = 27;
                        myView = currentIndex;
                      }
                      if (currentIndex == 3) {
                        setDefault();
                        medSize = 27;
                        myView = currentIndex;
                      }
                      if (currentIndex == 4) {
                        chatSize = 27;
                        myView = currentIndex;
                        goToChatScreen();
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
                      icon: Icon(Icons.search, size: recipeSize),
                      label: "Recipes"),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled, size: homeSize),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.medication_liquid_sharp, size: medSize),
                      label: "Medication"),
                  BottomNavigationBarItem(
                      icon: HeroIcon(
                        HeroIcons.chatBubbleOvalLeftEllipsis,
                        style: HeroIconStyle.outline,
                        size: chatSize,
                      ),
                      label: "Chat"),
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
