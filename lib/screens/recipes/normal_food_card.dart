// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:diabetic/screens/recipes/recipe_screen.dart';
import 'package:flutter/material.dart';

class NormalFoodCard extends StatelessWidget {
  final String image;
  final String name;
  final int border_radius;
  final int recipeId;

  const NormalFoodCard(
      {super.key,
      required this.name,
      required this.image,
      required this.border_radius,
      required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeScreen(
                      recipeId: recipeId,
                    )));
      },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(double.parse(border_radius.toString())),
              child: Image.network(image,
                  errorBuilder: (context, error, stackTrace) {
                return const Text('Failed to load image');
              }, height: 120, width: 120),
            ),
            Container(
              width: 120,
              padding: const EdgeInsets.only(top: 10),
              child: Text(name,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.left,
                  softWrap: false,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
