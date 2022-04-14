import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';

class StatisticsRow extends StatelessWidget {
  const StatisticsRow(
      {Key? key,
      this.isHeaderRow = false,
      this.lockFirstColumn = true,
      required this.values})
      : super(key: key);

  final bool isHeaderRow;
  final bool lockFirstColumn;
  final List values;

  @override
  Widget build(BuildContext context) {
    var firstValue = values.removeAt(0);

    var screenWidth = MediaQuery.of(context).size.width;
    var columnWidth = screenWidth * 0.25;
    var listViewWidth = screenWidth * 0.75;

    return Container(
        width: screenWidth,
        height: statisticsItemHeight,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: lockFirstColumn
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          child: Row(children: [
            Container(width: columnWidth, child: Text(firstValue.toString())),
            Container(
                width: listViewWidth,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: values.length,
                    padding: const EdgeInsets.only(right: 10),
                    itemBuilder: (context, index) {
                      return Container(
                          width: columnWidth,
                          height: statisticsItemHeight,
                          child: Text(values[index].toString()));
                    }))
          ]),
        ));
  }
}
