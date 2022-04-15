import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';
import 'package:oystars_flutter_app/widgets/stats_item.dart';

class StatsTable extends StatelessWidget {
  const StatsTable(
      {Key? key,
      this.lockFirstColumn = true,
      required this.headers,
      required this.values})
      : super(key: key);

  final bool lockFirstColumn;
  final List headers;
  final List<List> values;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var columnWidth = screenWidth * 0.25;

    return Container(
      width: screenWidth,
      height: screenHeight,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
              width: columnWidth * headers.length,
              height: screenHeight,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: headers.length,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: columnWidth / statsItemHeight),
                children: [
                  ...headers
                      .map((e) => StatsItem(
                            value: e.toString(),
                            width: columnWidth,
                            height: statsItemHeight,
                            isHeader: true,
                          ))
                      .toList(),
                  ...getValuesWidgets(values, columnWidth)
                ],
              ))),
    );
  }

  getValuesWidgets(List<List> values, double columnWidth) {
    List<Widget> singleList = [];
    for (var list in values) {
      for (var item in list) {
        singleList.add(StatsItem(
            value: item.toString(),
            width: columnWidth,
            height: statsItemHeight));
      }
    }

    return singleList;
  }
}
