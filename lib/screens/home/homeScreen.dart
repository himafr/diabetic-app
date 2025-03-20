// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, prefer_interpolation_to_compose_strings


import 'package:diabetic/components/pie_chart.dart';
import 'package:diabetic/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {

  const HomeScreen(
      {super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
      return Stack(
      children: [
        SingleChildScrollView(
          //physics: ScrollPhysics(),
          primary: true,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text("Home Page",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white,
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.notifications_none_sharp,
                                  color: Colors.white)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.access_time_sharp,
                                  color: Colors.white)),
                          Builder(
                            builder: (context) => IconButton(
                                icon: const Icon(Icons.settings_outlined,
                                    color: Colors.white),
                                onPressed: () =>
                                    Scaffold.of(context).openDrawer()),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
                // Expanded(child: 
                // Row(
                //   children: [
                // LineChartSample()

                //   ],
                // )
                // )
                const Row(
                  children: [
                    Expanded(
                      // It takes 5/6 part of the screen
                      flex: 5,
                      child: DashboardScreen(),
                    ),
                  ],
                ),
              ]),
        ),
        // Positioned(
        //   bottom: 70,
        //   left: 10,
        //   child: Container(
        //     decoration: BoxDecoration(
        //         color: Colors.indigo.shade900,
        //         borderRadius: BorderRadius.circular(10)),
        //     width: MediaQuery.of(context).size.width - 20,
        //     height: 60,
        //     child: Padding(
        //       padding: const EdgeInsets.all(8),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           ClipRRect(
        //             borderRadius: BorderRadius.circular(5),
        //             child: Image.asset("assets/songs/arijitSingh/images/tamasha.jpg"),
        //           ),
        //           const SizedBox(width: 10),
        //           Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisSize: MainAxisSize.max,
        //             children: [
        //               SizedBox(
        //                   width: MediaQuery.of(context).size.width - 46 - 194,
        //                   height: 20,
        //                   child: Marquee(0
        //                     text: "Agar Tum Saath Ho (From Tamasha)",
        //                     style: const TextStyle(
        //                         fontSize: 15,
        //                         fontFamily: "SpotifyCircularBold",
        //                         color: Colors.white),
        //                     scrollAxis: Axis.horizontal,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     blankSpace: 70,
        //                     velocity: 20.0,
        //                     startPadding: 5.0,
        //                   )),
        //               const Text(
        //                 "Arijit Singh",
        //                 style: TextStyle(
        //                     fontSize: 14,
        //                     fontFamily: "SpotifyCircularMedium",
        //                     color: Colors.white),
        //                 textAlign: TextAlign.left,
        //               )
        //             ],
        //           ),
        //           IconButton(
        //               onPressed: () {},
        //               icon:
        //                   const Icon(Icons.devices_sharp, color: Colors.grey)),
        //           IconButton(
        //               onPressed: () {},
        //               icon: Icon(Icons.favorite_outlined,
        //                   color: Colors.greenAccent[400])),
        //           IconButton(
        //               onPressed: () {},
        //               icon: const Icon(Icons.play_arrow_rounded,
        //                   color: Colors.white))
        //         ],
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
