// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, prefer_const_constructors, avoid_print
import 'dart:math';

import 'package:diabetic/components/download_btn.dart';
import 'package:diabetic/screens/books/components/book_list_view.dart';
import 'package:diabetic/screens/books/components/book_screen.dart';
import 'package:diabetic/services/networking.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<dynamic> _data = [];
  int _last = 6;
  int _now = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadBooks();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  void loadBooks() async {
//  setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    NetworkHelper networkHelper =
        NetworkHelper(url: booksUrl, token: prefs.getString("token") ?? "");
    // print(networkHelper.url);
    try {
      dynamic data = await networkHelper.getData();
      if (data["status"] == "success") {
        setState(() {
          _now = data["data"]["books"].length;
          _data = data["data"]["books"];
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

  dynamic loadMoreBooks(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    NetworkHelper networkHelper = NetworkHelper(
        url: "$booksUrl?page=$page", token: prefs.getString("token") ?? "");
    try {
      dynamic data = await networkHelper.getData();
      if (data["status"] == "success") {
        setState(() {
          _data.addAll(data["data"]["books"]);
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
    await loadMoreBooks(page);
    int itemsLeft = _last - _data.length;
    int itemsToLoad = min(6, itemsLeft);

    setState(() {
      _now = _now + itemsToLoad;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          primary: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
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
                        "Books Page",
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BookSCreen(bookId: 35)));
                            },
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

                            return ListTile(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookSCreen(
                                              bookId: _data[validIndex]
                                                  ["book_id"],
                                            )))
                              },
                              title: BookListCard(
                                svgSrc:
                                    "${k_host}get/${_data[validIndex]["book_photo"]}",
                                title: _data[validIndex]["book_title"],
                                amountOfFiles: DownloadButton(
                                    fileUrl:
                                        "${k_host}get/${_data[validIndex]["book_url"]}"),
                                numOfFiles: _data[validIndex]["book_desc"],
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
                          child: Text("no more books to display"),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
