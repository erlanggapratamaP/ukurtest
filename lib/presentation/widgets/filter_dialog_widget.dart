import 'package:fake_json/presentation/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class FilterDialogWidget extends StatefulWidget {
  const FilterDialogWidget({super.key});

  @override
  State<FilterDialogWidget> createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  DateTimeRange? _dateRange;
  String _dateStart = '';
  String _dateEnd = '';
  bool isChecked = false;
  List<String> listGender = <String>['Male', 'Female'];
  String? valueGender = 'Male';
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blue;
  }

  Future<DateTimeRange?> dateTimeRangePicker() async {
    DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: DateTimeRange(
          end: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 13),
          start: DateTime.now(),
        ),
        builder: (context, child) {
          return Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400.0,
                ),
                child: child,
              )
            ],
          );
        });

    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Builder(
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return SizedBox(
            height: height - 500,
            width: width - 60,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Filter',
                    style: Styles().bigSizeBoldText(Colors.black),
                  ),
                  SizedBox(
                    height: height / 15,
                    width: width / 1.5,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                          onPressed: () async {
                            _dateRange = await dateTimeRangePicker();
                            setState(() {
                              _dateStart = DateFormat('dd-MM-yyyy')
                                  .format(_dateRange!.start);
                              _dateEnd = DateFormat('dd-MM-yyyy')
                                  .format(_dateRange!.end);
                            });
                          },
                          child: _dateRange == null
                              ? const Text('Pilih Date Range')
                              : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('start : $_dateStart'),
                                    Text(' end:  $_dateEnd'),
                                  ],
                                )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: DropdownButton<String>(
                        value: valueGender,
                        elevation: 16,
                        style: Styles().normalSizeBoldText(Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.blue,
                        ),
                        items: listGender
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            debugPrint(value);
                            valueGender = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Row(
                      children: [
                        Text(
                          'is Active ?',
                          style: Styles().normalSizeBoldText(Colors.black),
                        ),
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
