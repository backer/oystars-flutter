import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';
import 'package:oystars_flutter_app/widgets/stats_item.dart';

class StatsTable extends StatelessWidget {
  const StatsTable(
      {Key? key,
      this.lockFirstColumn = true,
      required this.headers,
      required this.values,
      required this.tableHeight,
      required this.columnWidth,
      this.rowHeight = statsItemHeight})
      : super(key: key);

  final bool lockFirstColumn;
  final List headers;
  final List<List> values;
  final double tableHeight;
  final double columnWidth;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    var tableWidth = columnWidth * headers.length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(children: [
        Row(
          children: [
            ...headers
                .map((e) => StatsItem(
                      value: e.toString(),
                      width: columnWidth,
                      height: rowHeight,
                      isHeader: true,
                    ))
                .toList()
          ],
        ),
        Container(
            width: tableWidth,
            height: tableHeight - rowHeight,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: headers.length,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: columnWidth / rowHeight),
              children: [...getValuesWidgets(values, columnWidth)],
            ))
      ]),
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
