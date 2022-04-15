import 'package:flutter/material.dart';

class StatsItem extends StatelessWidget {
  const StatsItem(
      {Key? key,
      required this.value,
      this.isHeader = false,
      required this.width,
      required this.height})
      : super(key: key);

  final String value;
  final bool isHeader;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        alignment: Alignment.center,
        child: Text(
          value,
          style: TextStyle(
            color: isHeader ? Colors.purple : Colors.black,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ));
  }
}
