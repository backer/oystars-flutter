import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';
import 'package:oystars_flutter_app/widgets/stats_item.dart';

class StatsColumn extends StatelessWidget {
  const StatsColumn({Key? key, this.lockFirstRow = true, required this.values})
      : super(key: key);

  final bool lockFirstRow;
  final List values;

  @override
  Widget build(BuildContext context) {
    var firstValue = values.removeAt(0);

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var columnWidth = screenWidth * 0.25;
    var listViewHeight = screenHeight - statsItemHeight;

    return Container(
        width: columnWidth,
        height: screenHeight,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: lockFirstRow
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          child: Column(children: [
            StatsItem(
              width: columnWidth,
              height: statsItemHeight,
              value: firstValue.toString(),
              isHeader: true,
            ),
            Container(
                width: columnWidth,
                height: listViewHeight,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: values.length,
                    padding:
                        const EdgeInsets.only(bottom: statsItemVerticalSpacing),
                    itemBuilder: (context, index) {
                      return StatsItem(
                          width: columnWidth,
                          height: statsItemHeight,
                          value: values[index].toString());
                    }))
          ]),
        ));
  }
}
