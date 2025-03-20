import 'package:diabetic/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductScreen extends StatefulWidget {
  final String name;
  final int productId;
  const ProductScreen({super.key, required this.name, required this.productId});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.name);
    print(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Stack(
        children: [
          // above icons

          SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image(image: ExactAssetImage("assets/images/land.jpeg")),
                  ],
                ),

                // title and text above the tweets
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Goverment of Iraq - الحكومه',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            'العراقية',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Icon(
                            Icons.check_circle_sharp,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        '@IraqiGovt',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      child: Text(
                        'A digital service of the Federal Goverment to Provide',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'news and information from governmental agencies ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'and bodies  ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              'Iraq',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 16)),
                          Icon(
                            Icons.insert_link_rounded,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              'gds.gov.iq',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.blueAccent),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 16)),
                          Icon(
                            Icons.calendar_month_rounded,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              'Joined December ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              '2 ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Following ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text(
                              '298K ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Followers ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // tweets
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    'Tweets',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 16),
                                  height: 3,
                                  width: 45,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    'Tweets and replies ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 16),
                                  height: 3,
                                  width: 45,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    'media ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 16),
                                  height: 3,
                                  width: 45,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    'Likes ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 16),
                                  height: 3,
                                  width: 45,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 7),
                            child: CircleAvatar(
                              backgroundImage:
                                  ExactAssetImage('assets/images/profile.jpg'),
                              radius: 37,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(7),
                                    child: Text(
                                      'Goverment of Iraq - الحكومه الع ... ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 3),
                                    child: Text(
                                      ' 19h',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: Text(
                                  'Prime Minister Mohammed arrived in the   ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: Text(
                                  'capital , Baghdad . after concluding his ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: Text(
                                  'two-day official visit to the islamic Republic ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: Text(
                                  'of Iran , where he had several meetings ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: Text(
                                  'and talks ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 16)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(padding: EdgeInsets.only(left: 7)),
                                  Icon(
                                    Icons.chat_bubble_outline,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(7),
                                    child: Text(
                                      '3',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 32)),
                                  Icon(
                                    Icons.repeat,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(7),
                                    child: Text(
                                      '2',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 32)),
                                  Icon(
                                    Icons.heart_broken,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(12),
                                    child: Text(
                                      '8',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 32)),
                                  Icon(
                                    Icons.share,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7),
                      height: 1,
                      width: 550,
                      // 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 7),
                            child: CircleAvatar(
                              backgroundImage:
                                  ExactAssetImage('assets/images/profile.jpg'),
                              radius: 37,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(7),
                                    child: Text(
                                      'Goverment of Iraq - الحكومه الع ... ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 3),
                                    child: Text(
                                      ' 19h',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: Text(
                                  'Prime Minister Mohammed arrived in the   ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: Text(
                                  'capital , Baghdad . after concluding his ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: Text(
                                  'two-day official visit to the islamic Republic ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: Text(
                                  'of Iran , where he had several meetings ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: Text(
                                  'and talks ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 16)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(padding: EdgeInsets.only(left: 7)),
                                  Icon(
                                    Icons.chat_bubble_outline,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(7),
                                    child: Text(
                                      '3',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 32)),
                                  Icon(
                                    Icons.repeat,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(7),
                                    child: Text(
                                      '2',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 32)),
                                  Icon(
                                    Icons.heart_broken,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(12),
                                    child: Text(
                                      '8',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 32)),
                                  Icon(
                                    Icons.share,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
           Positioned(
                top: 0,
                left: 0,
                 
                child: Padding(
                  padding: EdgeInsets.all(8),
                
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: primaryColor,
                           child: TextButton(
                    onPressed: ()=>{
                      print("object")
                    },
                          child: Icon(
                            
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      
                  ),
                      ],
                    ),
                ),
              ),
        ],
      ),
    );
  }
}
