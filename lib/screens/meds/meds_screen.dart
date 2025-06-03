// ignore_for_file: camel_case_types, file_names, avoid_print, prefer_const_constructors, prefer_final_fields

import 'dart:math';
import 'package:diabetic/screens/meds/medicine_screen.dart';
import 'package:diabetic/services/networking.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

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
          _now = data["data"]["meds"].length;
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
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.settings_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
              //لحد هنا
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.99,
                    maxHeight: MediaQuery.of(context).size.height * 0.77,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: _now,
                          itemBuilder: (context, index) {
                            final int dataLength = _data.length;
                            // Ensure index is within the valid range
                            final int validIndex =
                                index.round().clamp(0, dataLength - 1);

                         return InkWell(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicineScreen(
                                    medId: _data[validIndex]["med_id"])))
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, right: 10.0, left: 10.0),
                        child: Center(
                          child: Card(
                            color: secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            elevation: 10,
                            child: Container(
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
                                  Text(
                                    _data[validIndex]["med_summary"],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
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
                          },
                        ),
                      ),
                      if (_isLoading)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      if (_data.length >= _last)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("no more medicines  to display"),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
