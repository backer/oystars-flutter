import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/dimens.dart';

class LabeledDropDown extends StatelessWidget {
  const LabeledDropDown(
      {Key? key,
      required this.label,
      required this.dropDownSelection,
      required this.dropDownOptions,
      this.onChanged})
      : super(key: key);

  final String label;
  final String dropDownSelection;
  final List<String> dropDownOptions;
  final onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        margin: EdgeInsets.only(
            left: dropdownLabelMarginLeft, right: dropdownLabelMarginRight),
        child: Text(label),
      ),
      Container(
          decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black, width: dropDownBorderWidth)),
          padding: EdgeInsets.all(dropDownPadding),
          child: DropdownButton<String>(
            value: dropDownSelection,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: dropDownButtonElevation,
            style: const TextStyle(color: Colors.purple),
            underline: Container(
              height: dropDownUnderlineHeight,
              color: Colors.purple,
            ),
            onChanged: onChanged,
            items:
                dropDownOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
    ]);
  }
}
