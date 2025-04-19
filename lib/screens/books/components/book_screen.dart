import 'package:diabetic/services/networking.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookSCreen extends StatefulWidget {
  const BookSCreen({super.key, required this.bookId});
  final int bookId;

  @override
  State<BookSCreen> createState() => _BookSCreenState();
}

class _BookSCreenState extends State<BookSCreen> {
  bool isLoading = true;
  dynamic _myBook;
  List<dynamic> _review = [];
  @override
  void initState() {
    super.initState();
    loadBook();
  }

  void loadBook() async {
//  setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    NetworkHelper networkHelper = NetworkHelper(
        url: '$booksUrl/${widget.bookId}',
        token: prefs.getString("token") ?? "");
    // print(networkHelper.url);
    try {
      dynamic data = await networkHelper.getData();
      print(data);
      // .postData({"username": username, "password": password});
      // print(data);
      if (data["status"] == "success") {
        setState(() {
          _myBook = data["data"]["book"];
          _review = data["data"]["review"];
          isLoading = false;
        });
        print(_myBook);
      }
    } catch (e) {
      //   setError(e.toString());
      // setLoading(false);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text(
                  'Book Page',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
              backgroundColor: Colors.blue,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // صورة المنتج مع التنقل لصفحة التفاصيل
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductDetailPage(),
                          ),
                        );
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.network(
                            "${k_host}get/${_myBook?["book_photo"]}",
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // اسم المنتج
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        _myBook["book_title"],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // وصف المنتج
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        _myBook["book_desc"],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    // قسم التقييم والمراجعات
                    Padding(
                      padding: EdgeInsets.all(20.0),
                     
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          );
  }
}

// صفحة تفاصيل المنتج
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: const Center(
        child: Text('تفاصيل المنتج هنا...'),
      ),
    );
  }
}
