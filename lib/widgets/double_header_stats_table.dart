import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';
import 'package:oystars_flutter_app/widgets/stats_item.dart';

class DoubleHeaderStatsTable extends StatelessWidget {
  const DoubleHeaderStatsTable(
      {Key? key,
      this.lockFirstColumn = true,
      required this.headersMap,
      required this.values,
      required this.tableHeight,
      required this.columnWidth,
      this.rowHeight = statsItemHeight})
      : super(key: key);

  final bool lockFirstColumn;
  final Map<String, List<String>> headersMap;
  final List<List> values;
  final double tableHeight;
  final double columnWidth;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    var totalColumns = calculateTotalColumns(headersMap);
    var tableWidth = columnWidth * totalColumns;
    List<String> secondaryHeaders = generateSecondaryHeaders(headersMap);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(children: [
        Row(
          children: [
            ...headersMap.keys
                .map((e) => StatsItem(
                      value: e.toString(),
                      width: columnWidth *
                          (headersMap[e]!.isNotEmpty
                              ? headersMap[e]!.length
                              : 1),
                      height: rowHeight,
                      isHeader: true,
                    ))
                .toList()
          ],
        ),
        Row(
          children: [
            ...secondaryHeaders.map((e) => StatsItem(
                  value: e.toString(),
                  width: columnWidth,
                  height: rowHeight,
                  isHeader: true,
                ))
          ],
        ),
        Container(
            width: tableWidth,
            height: tableHeight - (rowHeight * 2),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: totalColumns,
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

  calculateTotalColumns(Map<String, List<String>> headersMap) {
    var totalCount = 0;
    for (var element in headersMap.values) {
      var columnCount = element.isNotEmpty ? element.length : 1;
      totalCount += columnCount;
    }

    return totalCount;
  }

  generateSecondaryHeaders(Map<String, List<String>> headersMap) {
    List<String> secondaryHeaders = [];

    for (var e in headersMap.keys) {
      if (headersMap[e]?.isNotEmpty == true) {
        for (var item in headersMap[e]!) {
          secondaryHeaders.add(item);
        }
      } else {
        secondaryHeaders.add("");
      }
    }

    return secondaryHeaders;
  }
}
