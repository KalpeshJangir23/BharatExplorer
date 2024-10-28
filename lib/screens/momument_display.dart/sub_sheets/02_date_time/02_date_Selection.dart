// Date Selection Sheet
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
  final List<String> timeSlots = [
    '5:00 AM',
    '12:00 PM',
    '6:00 PM',
    '8:00 PM',
  ];
  int selectedTimeIndex = -1;
  @override
  Widget build(BuildContext context) {
    final dateRangeState = ref.watch(bookingProvider);
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
          CurrentlocationDestination(
            current_city:
                "Mumbai", //TODO : ADD RIVERPOD STATE FOR CURRENT LOCATION
            current_location: "Vasai",
            distination_city:
                ref.watch(destinationListProvider)[widget.index].title,
            distination_location:
                ref.watch(destinationListProvider)[widget.index].city,
          ),
          const SizedBox(height: 20),
          Calendar(
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              if (args.value is PickerDateRange) {
                final PickerDateRange selectedRange = args.value;
                if (selectedRange.startDate != null) {
                  ref.read(bookingProvider.notifier).updateDates(
                        startDate: selectedRange.startDate,
                        endDate: selectedRange.endDate,
                      );
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
                      ref
                          .read(bookingProvider.notifier)
                          .updateStartTime(timeSlots[index]);
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
