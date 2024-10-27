import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';

class Calender extends StatelessWidget {
  final void Function(DateRangePickerSelectionChangedArgs)? funct;
  const Calender({super.key, required this.funct});

  @override
  Widget build(BuildContext context) {
    // Set minimum date to tomorrow
    final DateTime today = DateTime.now();
    final DateTime tomorrow = DateTime(today.year, today.month, today.day + 1);

    final _datetimeController = DateRangePickerController();
    var theme = Theme.of(context);

    return SfDateRangePicker(
      controller: _datetimeController,
      view: DateRangePickerView.month,
      headerStyle: DateRangePickerHeaderStyle(
        backgroundColor: Appcolor.primary,
        textAlign: TextAlign.center,
        textStyle: theme.textTheme.titleMedium,
      ),
      backgroundColor: Appcolor.secondary,
      enablePastDates: true,
      minDate: tomorrow, // Set minimum date to tomorrow
      monthCellStyle: const DateRangePickerMonthCellStyle(
        textStyle: TextStyle(
          color: Colors.white,
          fontFamily: "bold",
          fontSize: 14,
        ),
        leadingDatesTextStyle:
            TextStyle(color: Colors.white, backgroundColor: Colors.white),
        trailingDatesTextStyle: TextStyle(
          color: Color(0xFFC8C9CC),
          backgroundColor: Colors.white,
          fontFamily: "bold",
          fontSize: 15,
        ),
        todayTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: "bold",
          fontSize: 15,
        ),
      ),
      selectionMode: DateRangePickerSelectionMode.range,
      selectionTextStyle: const TextStyle(
        color: Colors.white,
        fontFamily: "bold",
        fontSize: 14,
      ),
      selectionColor: Colors.black,
      startRangeSelectionColor: Appcolor.primary,
      endRangeSelectionColor: Appcolor.primary,
      rangeSelectionColor: Appcolor.Range_color,
      rangeTextStyle: const TextStyle(
        color: Colors.white,
        fontFamily: "bold",
        fontSize: 14,
      ),
      onSelectionChanged: funct,
    );
  }
}
