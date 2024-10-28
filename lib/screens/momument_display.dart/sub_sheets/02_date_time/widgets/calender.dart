import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';

class Calendar extends StatelessWidget {
  final void Function(DateRangePickerSelectionChangedArgs)? onSelectionChanged;

  const Calendar({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final DateTime tomorrow = DateTime(today.year, today.month, today.day + 1);
    final theme = Theme.of(context);

    return SfDateRangePicker(
      view: DateRangePickerView.month,
      headerStyle: DateRangePickerHeaderStyle(
        backgroundColor: Appcolor.primary,
        textAlign: TextAlign.center,
        textStyle: theme.textTheme.titleMedium?.copyWith(
          color: Colors.white,
        ),
      ),
      backgroundColor: Appcolor.secondary,
      enablePastDates: false,
      minDate: tomorrow,
      monthCellStyle: const DateRangePickerMonthCellStyle(
        textStyle: TextStyle(
          color: Colors.white,
          fontFamily: "bold",
          fontSize: 14,
        ),
        disabledDatesTextStyle: TextStyle(
          color: Color(0xFFC8C9CC),
          fontFamily: "bold",
          fontSize: 14,
        ),
        blackoutDateTextStyle: TextStyle(
          color: Colors.red,
          fontFamily: "bold",
          fontSize: 14,
        ),
        weekendTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: "bold",
          fontSize: 14,
        ),
        todayTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: "bold",
          fontSize: 14,
        ),
      ),
      yearCellStyle: const DateRangePickerYearCellStyle(
        textStyle: TextStyle(
          color: Colors.white,
          fontFamily: "bold",
          fontSize: 14,
        ),
      ),
      selectionMode: DateRangePickerSelectionMode.range,
      selectionTextStyle: const TextStyle(
        color: Colors.white,
        fontFamily: "bold",
        fontSize: 14,
      ),
      selectionColor: Appcolor.primary,
      startRangeSelectionColor: Appcolor.primary,
      endRangeSelectionColor: Appcolor.primary,
      rangeSelectionColor: Appcolor.Range_color,
      rangeTextStyle: const TextStyle(
        color: Colors.white,
        fontFamily: "bold",
        fontSize: 14,
      ),
      onSelectionChanged: onSelectionChanged,
      monthViewSettings: const DateRangePickerMonthViewSettings(
        firstDayOfWeek: 1,
        viewHeaderStyle: DateRangePickerViewHeaderStyle(
          textStyle: TextStyle(
            color: Colors.white,
            fontFamily: "bold",
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
