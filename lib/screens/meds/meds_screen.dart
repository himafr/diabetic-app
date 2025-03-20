// ignore_for_file: camel_case_types, file_names, avoid_print

import 'dart:math';

import 'package:diabetic/screens/books/components/book_list_view.dart';
import 'package:diabetic/screens/dashboard/components/storage_info_card.dart';
import 'package:diabetic/screens/meds/medicine_screen.dart';
import 'package:diabetic/services/networking.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/utils/urls.dart';
import 'package:diabetic/widgets/state/loading_state/book_shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
// import 'package:marquee/marquee.dart';

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:diabetic/utils/constants.dart';

// import 'package:marquee/marquee.dart';

class MedsScreen extends StatefulWidget {
  
  const MedsScreen({super.key});

  @override
  State<MedsScreen> createState() => _MedsScreenState();
}

class _MedsScreenState extends State<MedsScreen> {
ScrollController scrollController = ScrollController();
  List<dynamic> _data = [];
  int _last = 6;
  int _now = 0;
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadMeds();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  void loadMeds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    NetworkHelper networkHelper =
        NetworkHelper(url: medsUrl, token: prefs.getString("token") ?? "");
    try {
      dynamic data = await networkHelper.getData();
      if (data["status"] == "success") {
        setState(() {
          _now =  data["data"]["meds"].length;
          _data = data["data"]["meds"];
          _last = data["data"]["nums"][0]["nums"];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  dynamic loadMoreMeds(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    NetworkHelper networkHelper = NetworkHelper(
        url: "$medsUrl?page=$page", token: prefs.getString("token") ?? "");
    try {
      dynamic data = await networkHelper.getData();
      if (data["status"] == "success") {
        setState(() {
          _data.addAll(data["data"]["meds"]);
        });
      }
      return 1;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loadMoreData() async {
    // Check if we are already loading or if we have loaded all items.
    if (_data.length >= _last) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have reached the end of the list'),
        ),
      );
    }
    
    if (_isLoading || _data.length >= _last) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate a delay for fetching new data.
    // await Future.delayed(Duration(seconds: 2));
    // Determine the number of new items to load without exceeding _last.
    int page = (_now / 6).round();
    await loadMoreMeds(page);
    int itemsLeft = _last - _data.length;
    int itemsToLoad = min(6, itemsLeft);

    setState(() {
      _now = _now + itemsToLoad;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
return Column(
  children: [
          //هنا 
    Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Medicine Page",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_sharp),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.access_time_sharp),
                ),
                IconButton(
                            onPressed: () {Scaffold.of(context).openDrawer();},
                  icon: const Icon(Icons.settings_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    //لحد هنا 
    const Padding(
      padding: EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 5),
      child: SizedBox(
        width: double.infinity,
        child: Text("الادويه المتاحة ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: TextAlign.left),
      ),
    ),
    Expanded(
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: _now,
              itemBuilder: (context, index) {
                final int dataLength = _data.length;
                final int validIndex = index.clamp(0, dataLength - 1);
                return InkWell(
                  onTap: () => {
                     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MedicineScreen(medId: _data[validIndex]["med_id"] )))
      
                  },
                  child: Padding(
                   padding: const EdgeInsets.only(bottom: 10.0 ,right: 10.0,left: 10.0),
                   child: Center(
                     child: Card(
                       color: secondaryColor,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(30.0),
                       ),
                       elevation: 10,
                       child: Container(
                         width: 300,
                         height: 300,
                         padding: const EdgeInsets.all(10.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Image.network(
                               "${k_host}get/${_data[validIndex]["med_photo"]}",
                               width: double.infinity,
                               height: 130,
                               
                               fit: BoxFit.cover,
                             ),
                             const SizedBox(height: 5),
                              Text(
                                _data[validIndex]["med_name"],
                               style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             const SizedBox(height: 8),
                              Text( _data[validIndex]["med_summary"],
                              overflow: TextOverflow.ellipsis,
                               style: TextStyle(
                                 fontSize: 16,
                               ),
                             ),
                             const Spacer(),
                             ElevatedButton(
                               onPressed: () {},
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: Colors.blue,
                               ),
                               child: const Text(
                                 'Add To Cart',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 14,
                                 ),
                               ),
                         ),
                            ],
                       ),
                     ),
                   ),
                                 ),                        
                  ),
                );
                //  Container(
                //   constraints: BoxConstraints(
                //     maxWidth: MediaQuery.of(context).size.width * 0.99,
                //     maxHeight: MediaQuery.of(context).size.height * 0.5,
                //   ),
                //   child: BookListCard(
                //     svgSrc: ,
                //     title:,
                //     amountOfFiles: "1.3GB",
                //     numOfFiles: 1328,
                //   ),
                // );
              },
            ),
    ),
    Expanded(child: Container()),
    if (_data.length >= _last)
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("No more medicines to display"),
      ),
  ],
);
  }}
  //    return Stack(
  //     children: [
  //       SingleChildScrollView(
  //         primary: true,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(top: 35),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   const Padding(
  //                     padding: EdgeInsets.only(left: 15),
  //                     child: Text(
  //                       "meds Page",
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 25,
  //                         fontFamily: "SpotifyCircularBold",
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 15),
  //                     child: Row(
  //                       children: [
  //                         IconButton(
  //                           onPressed: () {},
  //                           icon: const Icon(Icons.notifications_none_sharp),
  //                         ),
  //                         IconButton(
  //                           onPressed: () {},
  //                           icon: const Icon(Icons.access_time_sharp),
  //                         ),
  //                         IconButton(
  //                           onPressed: () {},
  //                           icon: const Icon(Icons.settings_outlined),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //      SingleChildScrollView(
  //        scrollDirection: Axis.horizontal,
  //        child: Row(
  //          children: [
  //            for (int i = 0; i < 8; i++)
  //              Padding(
  //                padding: const EdgeInsets.all(10.0),
  //                child: Center(
  //                  child: Card(
  //                    color: secondaryColor,
  //                    shape: RoundedRectangleBorder(
  //                      borderRadius: BorderRadius.circular(30.0),
  //                    ),
  //                    elevation: 10,
  //                    child: Container(
  //                      width: 300,
  //                      height: 300,
  //                      padding: const EdgeInsets.all(10.0),
  //                      child: Column(
  //                        crossAxisAlignment: CrossAxisAlignment.start,
  //                        children: [
  //                          Image.asset(
  //                            'assets/images/user_3.png',
  //                            width: double.infinity,
  //                            height: 130,
                             
  //                            fit: BoxFit.cover,
  //                          ),
  //                          const SizedBox(height: 5),
  //                          const Text(
  //                            'NovoRapid',
  //                            style: TextStyle(
  //                              fontSize: 20,
  //                              fontWeight: FontWeight.bold,
  //                            ),
  //                          ),
  //                          const SizedBox(height: 8),
  //                          const Text(
  //                            'قارورة أنسولين أمريكية نوفولوغ وأخرى كندية نوفورابيد لعلاج السكري',
  //                            style: TextStyle(
  //                              fontSize: 16,
  //                            ),
  //                          ),
  //                          const Spacer(),
  //                          ElevatedButton(
  //                            onPressed: () {},
  //                            style: ElevatedButton.styleFrom(
  //                              backgroundColor: Colors.blue,
  //                            ),
  //                            child: const Text(
  //                              'Add To Cart',
  //                              style: TextStyle(
  //                                color: Colors.white,
  //                                fontSize: 14,
  //                              ),
  //                            ),
  //                          ),
  //                        ],
  //                      ),
  //                    ),
  //                  ),
  //                ),
  //              ),
  //          ],
  //        ),
  //      ),
  //       ],
  //         ),
  //       ),
  //     ]
  //    );
  // }
  // }
//    return Stack(
//       children: [
//         Scaffold(
//           appBar: AppBar(toolbarHeight: 0, backgroundColor: kSecondaryColor),
//           backgroundColor: kSecondaryColor,
//           body: Stack(
//             children: [
//               SingleChildScrollView(
//                 controller: scrollController,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 15, right: 15),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 35),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: const [
//                             Text("Search",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 25,
//                                     color: Colors.white,
//                                     fontFamily: "SpotifyCircularBold")),
//                             IconButton(
//                                 onPressed: h,
//                                 highlightColor: Colors.transparent,
//                                 splashColor: Colors.transparent,
//                                 icon: Icon(Icons.camera_alt_outlined,
//                                     color: Colors.white))
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {},
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 10),
//                           child: Container(
//                             height: 50,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: Colors.white,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: const [
//                                 SizedBox(width: 5),
//                                 Icon(Icons.search_sharp,
//                                     color: kSecondaryColor, size: 30),
//                                 SizedBox(width: 4),
//                                 Text("What do you want to listen to?",
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontFamily: "SpotifyCircularMedium",
//                                         color: kSecondarySwatchColor),
//                                     textAlign: TextAlign.start,
//                                     overflow: TextOverflow.ellipsis)
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 15, bottom: 15),
//                         child: Row(
//                           children: const [
//                             Text("Browse all",
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontFamily: "SpotifyCircularMedium",
//                                     color: Colors.white),
//                                 textAlign: TextAlign.left,
//                                 overflow: TextOverflow.ellipsis),
//                           ],
//                         ),
//                       ),
//                       GridView.builder(
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 mainAxisSpacing: 15,
//                                 crossAxisSpacing: 15,
//                                 childAspectRatio: 1.655),
//                         primary: false,
//                         shrinkWrap: true,
//                         itemCount: 12,
//                         itemBuilder: (BuildContext context, index) {
//                           return ClipRRect(
//                             borderRadius: BorderRadius.circular(5),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width:
//                                       (MediaQuery.of(context).size.width - 45) / 2,
//                                   height: 105,
//                                   decoration:
//                                       BoxDecoration(color: Colors.red.shade600),
//                                   child: Stack(
//                                     children: [
//                                       const Positioned(
//                                         top: 12,
//                                         left: 8,
//                                         child: Text("Podcasts",
//                                             style: TextStyle(
//                                                 fontSize: 17,
//                                                 fontFamily: "SpotifyCircularMedium",
//                                                 color: Colors.white)),
//                                       ),
//                                       Positioned(
//                                           top: 15,
//                                           left: 136,
//                                           child: Transform(
//                                               transform: Matrix4.rotationZ(
//                                                 (3.1415926535897932 / 7.2),
//                                               ),
//                                               child: ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(8),
//                                                 child: Image.asset(
//                                                   "assets/images/dissect.jpg",
//                                                   height: 78,
//                                                   width: 78,
//                                                 ),
//                                               )))
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 child: InkWell(
//                   child: AnimatedOpacity(
//                     duration: const Duration(milliseconds: 0),
//                     opacity: showSearchBar ? 1 : 0,
//                     child: Container(
//                       padding:
//                           const EdgeInsets.only(left: 15, right: 15, bottom: 10),
//                       color: kSecondaryColor,
//                       width: MediaQuery.of(context).size.width,
//                       child: Container(
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: Colors.white,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: const [
//                             SizedBox(width: 5),
//                             Icon(Icons.search_sharp,
//                                 color: kSecondaryColor, size: 30),
//                             SizedBox(width: 4),
//                             Text("What do you want to listen to?",
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontFamily: "SpotifyCircularMedium",
//                                     color: kSecondarySwatchColor),
//                                 textAlign: TextAlign.start,
//                                 overflow: TextOverflow.ellipsis)
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           bottom: 70,
//           left: 10,
//           child: Container(
//             decoration: BoxDecoration(
//                 color: Colors.indigo.shade900,
//                 borderRadius: BorderRadius.circular(10)),
//             width: MediaQuery.of(context).size.width - 20,
//             height: 60,
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: Image.asset("assets/songs/arijitSingh/images/tamasha.jpg"),
//                   ),
//                   const SizedBox(width: 10),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       SizedBox(
//                           width: MediaQuery.of(context).size.width - 46 - 194,
//                           height: 20,
//                           child: Marquee(
//                             text: "Agar Tum Saath Ho (From Tamasha)",
//                             style: const TextStyle(
//                                 fontSize: 15,
//                                 fontFamily: "SpotifyCircularBold",
//                                 color: Colors.white),
//                             scrollAxis: Axis.horizontal,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             blankSpace: 70,
//                             velocity: 20.0,
//                             startPadding: 5.0,
//                           )),
//                       const Text(
//                         "Arijit Singh",
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: "SpotifyCircularMedium",
//                             color: Colors.white),
//                         textAlign: TextAlign.left,
//                       )
//                     ],
//                   ),
//                   IconButton(
//                       onPressed: () {},
//                       icon:
//                           const Icon(Icons.devices_sharp, color: Colors.grey)),
//                   IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.favorite_outlined,
//                           color: Colors.greenAccent[400])),
//                   IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.play_arrow_rounded,
//                           color: Colors.white))
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// h() {}


// GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 10,
//                       crossAxisSpacing: 10,
//                       childAspectRatio: 3.125),

//                   //physics: NeverScrollableScrollPhysics(),
//                   primary: false,
//                   padding: const EdgeInsets.only(left: 15, right: 15),
//                   //controller: ScrollController(keepScrollOffset: false),
//                   shrinkWrap: true,
//                   itemCount: widget.recentPlaylistItems.length,
//                   itemBuilder: (BuildContext context, index) {
//                     return recentPlaylistContainer(
//                         name: widget.recentPlaylistItems[index]["name"],
//                         image: widget.recentPlaylistItems[index]["image"],
//                         artistAndPodcastersItems: widget.artistAndPodcastersItems);
//                   },
//                 ),

//                 const Padding(
//                     padding: EdgeInsets.only(
//                         top: 30, left: 15, right: 15, bottom: 15),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Text("Recently played",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 25,
                              
//                               fontFamily: "SpotifyCircularBold"),
//                           textAlign: TextAlign.left),
//                     )),
//                 Padding(
//                     padding: const EdgeInsets.only(left: 15, right: 15),
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           for (int i = 0;
//                               i < widget.recentPlayedItems.length;
//                               i++)
//                             recentlyPlayed(
//                                 name: widget.recentPlayedItems[i]['name'],
//                                 image: widget.recentPlayedItems[i]['image'],
//                                 border_radius: widget.recentPlayedItems[i]
//                                     ['border_radius'],
//                                 artistAndPodcastersItems:
//                                     widget.artistAndPodcastersItems),
//                         ],
//                       ),
//                     )),
//                 const Padding(
//                     padding: EdgeInsets.only(
//                         top: 15, left: 15, right: 15, bottom: 15),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Text(
//                         "Artists and Podcasters",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 25,
                            
//                             fontFamily: "SpotifyCircularBold"),
//                         textAlign: TextAlign.left,
//                         maxLines: 2,
//                       ),
//                     )),
//                 Padding(
//                     padding: const EdgeInsets.only(left: 15, right: 15),
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           for (int i = 0;
//                               i < widget.artistAndPodcastersItems.length;
//                               i++)
//                             artistAndPodcastersColumn(
//                                 name: widget.artistAndPodcastersItems[i]
//                                     ['name'],
//                                 image: widget.artistAndPodcastersItems[i]
//                                     ['image'],
//                                 border_radius:
//                                     widget.artistAndPodcastersItems[i]
//                                         ['border_radius'],
//                                 artistAndPodcastersItems:
//                                     widget.artistAndPodcastersItems),
//                         ],
//                       ),
//                     )),