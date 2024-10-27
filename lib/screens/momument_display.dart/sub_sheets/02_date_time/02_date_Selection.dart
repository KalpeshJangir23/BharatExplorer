// Date Selection Sheet
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/02_date_time/widgets/calender.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/02_date_time/widgets/currentLocation_destination.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/03_no_of_traveller/03_no_of_traveller.dart';

class DateSelectionSheet extends StatefulWidget {
  const DateSelectionSheet({super.key});

  @override
  State<DateSelectionSheet> createState() => _DateSelectionSheetState();
}

class _DateSelectionSheetState extends State<DateSelectionSheet> {
  final List<String> timeSlots = [
    '5:00 AM',
    '12:00 PM',
    '6:00 PM',
    '8:00 PM',
  ];
  int selectedTimeIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height * 0.95),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Appcolor.secondary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Appcolor.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Date',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const CurrentlocationDestination(
            current_city: "Mumbai",
            current_location: "Vasai",
            distination_city: "Agra",
            distination_location: "Taj Mahal",
          ),
          const SizedBox(height: 20),
          Calender(
            funct: (DateRangePickerSelectionChangedArgs args) {
              if (args.value is PickerDateRange) {
                final PickerDateRange selectedRange = args.value;
                final DateTime today = DateTime.now();
                final DateTime todayWithoutTime =
                    DateTime(today.year, today.month, today.day);

                // Check if start date is selected and is today or before
                if (selectedRange.startDate != null) {
                  final DateTime startDate = DateTime(
                    selectedRange.startDate!.year,
                    selectedRange.startDate!.month,
                    selectedRange.startDate!.day,
                  );

                  if (startDate.compareTo(todayWithoutTime) <= 0) {
                    // Show dialog for invalid selection
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Invalid Date Selection',
                            style: TextStyle(
                              fontFamily: "bold",
                              fontSize: 18,
                            ),
                          ),
                          content: const Text(
                            'Please select a start date from tomorrow onwards.',
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  color: Appcolor.primary,
                                  fontFamily: "bold",
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                }
              }
            },
          ),

          const SizedBox(height: 20),
          SizedBox(
            height: 60, // Fixed height for the ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                final isSelected = selectedTimeIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeIndex = index;
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Appcolor.primary
                                : Colors.transparent,
                            border: Border.all(
                              color: isSelected
                                  ? Appcolor.primary
                                  : Colors.grey.withOpacity(0.3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              timeSlots[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected ? Colors.white : Colors.black,
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
          const SizedBox(height: 20),
          // Add your date picker content here
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const TravellerSelectionSheet(),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'Continue to Traveller Selection',
              style: TextStyle(color: Appcolor.white),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
