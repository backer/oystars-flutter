import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';

class StatisticsColumn extends StatelessWidget {
  const StatisticsColumn(
      {Key? key, this.lockFirstRow = true, required this.values})
      : super(key: key);

  final bool lockFirstRow;
  final List values;

  @override
  Widget build(BuildContext context) {
    var firstValue = values.removeAt(0);

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var columnWidth = screenWidth * 0.25;
    var listViewHeight = screenHeight - statisticsItemHeight;

    return Container(
        width: columnWidth,
        height: screenHeight,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: lockFirstRow
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          child: Column(children: [
            Container(
                width: columnWidth,
                height: statisticsItemHeight,
                child: Text(firstValue.toString())),
            Container(
                width: columnWidth,
                height: listViewHeight,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: values.length,
                    padding: const EdgeInsets.only(
                        bottom: statisticsItemVerticalSpacing),
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
