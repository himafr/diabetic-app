// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'package:diabetic/services/networking.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/utils/urls.dart';
import 'package:diabetic/screens/recipes/normal_food_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  List<dynamic> _healthyFood = [];
  List<dynamic> _normalFood = [];
  List<dynamic> _drinks = [];
  @override
  void initState() {
    super.initState();
    loadRecipe();
  }

  void loadRecipe() async {
//  setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    NetworkHelper networkHelper = NetworkHelper(
        url: "$recipesUrl/apk", token: prefs.getString("token") ?? "");
    // print(networkHelper.url);
    try {
      dynamic data = await networkHelper.getData();
      if (data["status"] == "success") {
        print(data["data"]["recipes"]);

        setState(() {
          _healthyFood = data["data"]["recipes"]
              .where((recipe) => recipe["category_name"] == "وصافات صحيه")
              .toList();

          _normalFood = data["data"]["recipes"]
              .where((recipe) => recipe["category_name"] == "وصافات عاديه")
              .toList();
          _drinks = data["data"]["recipes"]
              .where((recipe) => recipe["category_name"] == "مشروبات")
              .toList();
        });
      }
    } catch (e) {
      print(e);
    }
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
                //هنا
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text("Good morning",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notifications_none_sharp,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.access_time_sharp,
                              )),
                          IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: const Icon(
                                Icons.settings_outlined,
                              ))
                        ]),
                      )
                    ],
                  ),
                ),
                //لحد هنا
                const Padding(
                    padding: EdgeInsets.only(
                        top: 30, left: 15, right: 15, bottom: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text("وصافات صحية ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.left),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 200, // adjust based on your widget's desired height
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _healthyFood.length,
                      itemBuilder: (context, index) {
                        return NormalFoodCard(
                          name: _healthyFood[index]["recipe_name"],
                          image: k_host +
                              "get/" +
                              _healthyFood[index]['recipe_photo'],
                          border_radius: 30,
                          recipeId: _normalFood[index]['recipe_id'],
                        );
                      },
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 15, bottom: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "وصافات عادية ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 200, // adjust based on your widget's desired height
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _normalFood.length,
                      itemBuilder: (context, index) {
                        return NormalFoodCard(
                          name: _normalFood[index]["recipe_name"],
                          image: "${k_host}get/" +
                              _normalFood[index]['recipe_photo'],
                          border_radius: 30,
                          recipeId: _normalFood[index]['recipe_id'],
                        );
                      },
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 15, bottom: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "مشروبات",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 200, // adjust based on your widget's desired height
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _drinks.length,
                      itemBuilder: (context, index) {
                        return NormalFoodCard(
                          name: _drinks[index]["recipe_name"],
                          image:
                              k_host + "get/" + _drinks[index]['recipe_photo'],
                          border_radius: 30,
                          recipeId: _normalFood[index]['recipe_id'],
                        );
                      },
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: SizedBox(height: 140, width: double.infinity))
              ]),
        ),
      ],
    );
  }
}
