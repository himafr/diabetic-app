import 'package:diabetic/utils/constants.dart';
import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.padding = const EdgeInsets.all(20 * 0.75),
  });

  final String text;
  final VoidCallback press;
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      padding: padding,
      color: color,
      minWidth: double.infinity,
      onPressed: press,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
