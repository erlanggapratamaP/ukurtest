import 'package:fake_json/presentation/bloc/user_bloc.dart';
import 'package:fake_json/presentation/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:rxdart/rxdart.dart';

class FilterDialogWidget extends StatefulWidget {
  final BuildContext ctx;
  final UserBloc? bloc;
  const FilterDialogWidget({required this.ctx, this.bloc, Key? key})
      : super(key: key);

  @override
  State<FilterDialogWidget> createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
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
                      child: StreamBuilder3<DateTimeRange, String, String>(
                        streams: StreamTuple3(widget.bloc!.dateRange,
                            widget.bloc!.dateStart, widget.bloc!.dateEnd),
                        builder: (context, snapshots) {
                          return ElevatedButton(
                              onPressed: () async {
                                var data = await dateTimeRangePicker();
                                widget.bloc!.setDateRange(data!);
                                widget.bloc!.setDateStart(
                                    DateFormat('dd-MM-yyyy')
                                        .format(data.start));
                                widget.bloc!.setDateEnd(
                                    DateFormat('dd-MM-yyyy').format(data.end));
                              },
                              child: snapshots.snapshot1.data == null
                                  ? const Text('Pilih Date Range')
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'start : ${snapshots.snapshot2.data}'),
                                        Text(
                                            ' end:  ${snapshots.snapshot3.data}'),
                                      ],
                                    ));
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: StreamBuilder<String>(
                          stream: widget.bloc!.valueGender,
                          builder: (context, snapshot) {
                            return DropdownButton<String>(
                              hint: const Text("Gender"),
                              value: snapshot.data,
                              elevation: 16,
                              style: Styles().normalSizeBoldText(Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.blue,
                              ),
                              items: widget.bloc!.listGender
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                    value: value, child: Text(value));
                              }).toList(),
                              onChanged: (String? value) {
                                debugPrint(value);
                                widget.bloc!.setValueGender(value!);
                              },
                            );
                          }),
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
                        StreamBuilder<bool>(
                            stream: widget.bloc!.isChecked,
                            initialData: false,
                            builder: (context, snapshot) {
                              return Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: snapshot.data,
                                onChanged: (bool? value) {
                                  widget.bloc!.setIsChecked(value!);
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: StreamBuilder4<String, String, String, bool>(
                            streams: StreamTuple4(
                                widget.bloc!.dateStart,
                                widget.bloc!.dateEnd,
                                widget.bloc!.valueGender,
                                widget.bloc!.isChecked),
                            builder: (context, snapshots) {
                              return ElevatedButton(
                                  onPressed: () {
                                    widget.bloc!.add(FilterUser(
                                        starDate:
                                            snapshots.snapshot1.data ?? "",
                                        endDate: snapshots.snapshot2.data ?? "",
                                        gender: snapshots.snapshot3.data ?? "",
                                        isActive:
                                            snapshots.snapshot4.data ?? false));
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Terapkan"));
                            }),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                            onPressed: () {
                              widget.bloc!.setDateRange(DateTimeRange(
                                  start: DateTime.now(), end: DateTime.now()));
                              widget.bloc!.setDateStart("");
                              widget.bloc!.setDateEnd("");
                              // widget.bloc!.setValueGender("");
                              widget.bloc!.setIsChecked(false);
                              widget.bloc!.add(GetUser());
                              Navigator.pop(context);
                            },
                            child: const Text('Reset')),
                      ),
                    ],
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
