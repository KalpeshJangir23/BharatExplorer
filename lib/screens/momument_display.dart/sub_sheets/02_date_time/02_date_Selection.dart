import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';
import 'package:trip_show_planner/provider/booking_provider.dart';
import 'package:trip_show_planner/provider/list_distination_provider.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/02_date_time/widgets/calender.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/02_date_time/widgets/currentLocation_destination.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/03_no_of_traveller/03_no_of_traveller.dart';

class DateSelectionSheet extends ConsumerStatefulWidget {
  final int index;
  const DateSelectionSheet({super.key, required this.index});

  @override
  ConsumerState<DateSelectionSheet> createState() => _DateSelectionSheetState();
}

class _DateSelectionSheetState extends ConsumerState<DateSelectionSheet> {
  final List<String> timeSlots = ['5:00 AM', '12:00 PM', '6:00 PM', '8:00 PM'];
  int selectedTimeIndex = -1;
  bool isDateRangeSelected = false;

  bool get isFormValid => selectedTimeIndex != -1 && isDateRangeSelected;

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(bookingProvider);
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    
    // Calculate responsive dimensions
    final verticalSpacing = size.height * 0.015;
    final calendarHeight = size.height * 0.45;
    final timeSlotHeight = size.height * 0.06;
    final buttonHeight = size.height * 0.07;
    final fontSize = size.width * 0.04;

    return Container(
      decoration: BoxDecoration(
        color: Appcolor.darkBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(size.width * 0.1),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Draggable handle
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: verticalSpacing,
                    horizontal: size.width * 0.4,
                  ),
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Location Info
                CurrentlocationDestination(
                  current_city: name.currentLocation ?? 'Mumbai',
                  current_location: name.currentArea ?? "Maharashtra",
                  distination_city: ref.watch(destinationListProvider)[widget.index].title,
                  distination_location: ref.watch(destinationListProvider)[widget.index].city,
                ),

                Divider(
                  thickness: 2,
                  color: Appcolor.GREY_COLOR.withOpacity(0.2),
                ),

                // Calendar Section
                Text(
                  'Trip Calender',
                  style: TextStyle(
                    fontSize: fontSize * 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: verticalSpacing),
                SizedBox(
                  height: calendarHeight,
                  child: Calendar(
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      if (args.value is PickerDateRange) {
                        final PickerDateRange selectedRange = args.value;
                        setState(() {
                          isDateRangeSelected = selectedRange.startDate != null;
                        });
                        if (isDateRangeSelected) {
                          ref.read(bookingProvider.notifier).updateDates(
                            startDate: selectedRange.startDate,
                            endDate: selectedRange.endDate,
                          );
                        }
                      }
                    },
                  ),
                ),

                // Time Slots Section
                Text(
                  'Departure Time',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: verticalSpacing),
                SizedBox(
                  height: timeSlotHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: timeSlots.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedTimeIndex == index;
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() => selectedTimeIndex = index);
                            ref.read(bookingProvider.notifier)
                                .updateStartTime(timeSlots[index]);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(size.width * 0.03),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05,
                                  vertical: size.height * 0.012,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? Appcolor.primary 
                                      : Appcolor.secondary,
                                  border: Border.all(
                                    color: isSelected
                                        ? Appcolor.primary
                                        : Appcolor.GREY_COLOR.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(size.width * 0.03),
                                ),
                                child: Center(
                                  child: Text(
                                    timeSlots[index],
                                    style: TextStyle(
                                      fontSize: fontSize * 0.9,
                                      color: Colors.white,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Button
                SizedBox(height: verticalSpacing * 2),
                ElevatedButton(
                  onPressed: isFormValid
                      ? () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => TravellerSelectionSheet(
                              index: widget.index,
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(double.infinity, buttonHeight),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size.width * 0.1),
                        topRight: Radius.circular(size.width * 0.1),
                      ),
                    ),
                    backgroundColor: isFormValid 
                        ? Appcolor.primary 
                        : Appcolor.secondary,
                  ),
                  child: Text(
                    'Continue to Traveller Selection',
                    style: TextStyle(
                      color: isFormValid ? Appcolor.white : Colors.white54,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}