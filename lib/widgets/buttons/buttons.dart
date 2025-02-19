import 'package:diabetic/utils/constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData? iconUrl;
  final Text text;
  final Color? buttonColor;
  const MyButton(
      {super.key,
      this.onPressed,
      this.iconUrl = Icons.abc,
      required this.text,
      this.buttonColor=kSecondaryColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),
        backgroundColor:buttonColor ,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        if(iconUrl!=Icons.abc)Icon(
            iconUrl,
            size: 30.0,
          ),
          const SizedBox(width: 10),
          text,
          const Icon(
            Icons.abc,
            size: 50,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
