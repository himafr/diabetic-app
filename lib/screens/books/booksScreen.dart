// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names
import 'package:diabetic/widgets/state/loading_state/book_shimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
// import 'package:marquee/marquee.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
    void initState() {
    super.initState();
  }

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
                        child: Text("Books Page",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                
                                fontFamily: "SpotifyCircularBold")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.notifications_none_sharp,
                                  )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.access_time_sharp,
                                  )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.settings_outlined,
                                  ))
                        ]),
                      )
                    ],
                  ),
                ),
            const MyBookShimmer()
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
        //                   child: Marquee(
        //                     text: "Agar Tum Saath Ho (From Tamasha)",
        //                     style: const TextStyle(
        //                         fontSize: 15,
        //                         fontFamily: "SpotifyCircularBold",
        //                         ),
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
        //                     ),
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
        //                   ))
        //         ],
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}

