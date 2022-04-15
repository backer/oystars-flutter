import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';
import 'package:oystars_flutter_app/widgets/stats_column.dart';

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
    List<List> columns = getColumnsData();
    var firstColumn = columns.removeAt(0);

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
            Container(
                width: columnWidth,
                child: StatsColumn(
                  values: firstColumn,
                )),
            Container(
                width: listViewWidth,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: columns.length,
                    itemBuilder: (context, index) {
                      return Container(
                          width: columnWidth,
                          child: StatsColumn(
                            values: columns[index],
                          ));
                    }))
          ]),
        ));
  }

  getColumnsData() {
    var numColumns = headers.length;
    List<List> columns = [];
    for (var i = 0; i < numColumns; i++) {
      List column = [];
      column.add(headers[i]);
      for (var element in values) {
        column.add(element[i]);
      }
      columns.add(column);
    }

    return columns;
  }
}
