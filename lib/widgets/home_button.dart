import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key, required this.label, this.onPressed})
      : super(key: key);

  final String label;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var buttonWidth = screenWidth * 0.6;

    return Container(
      width: buttonWidth,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(label,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    );
  }
}
