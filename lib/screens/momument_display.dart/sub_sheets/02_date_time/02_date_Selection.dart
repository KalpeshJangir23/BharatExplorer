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
  bool isDateRangeSelected = false;

  bool get isFormValid => selectedTimeIndex != -1 && isDateRangeSelected;

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(bookingProvider);
    return Container(
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height * 0.95),
      decoration: const BoxDecoration(
        color: Appcolor.darkBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          CurrentlocationDestination(
            current_city: name.currentLocation ?? 'Mumbai',
            current_location: name.currentArea ?? "Maharashtra",
            distination_city:
                ref.watch(destinationListProvider)[widget.index].title,
            distination_location:
                ref.watch(destinationListProvider)[widget.index].city,
          ),
          const SizedBox(height: 10),
          Divider(
            thickness: 2,
            color: Appcolor.GREY_COLOR.withOpacity(0.2),
          ),
          const Text(
            'Trip Calender',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 380,
            child: Calendar(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  final PickerDateRange selectedRange = args.value;
                  if (selectedRange.startDate != null) {
                    setState(() {
                      isDateRangeSelected = true;
                    });
                    ref.read(bookingProvider.notifier).updateDates(
                          startDate: selectedRange.startDate,
                          endDate: selectedRange.endDate,
                        );
                  } else {
                    setState(() {
                      isDateRangeSelected = false;
                    });
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Departure Time',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
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
                                : Appcolor.secondary,
                            border: Border.all(
                              color: isSelected
                                  ? Appcolor.primary
                                  : Appcolor.GREY_COLOR.withOpacity(0.3),
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
          const Spacer(),
          Column(
            children: [
              if (!isFormValid)
                const Text(
                  'Please select both date range and time slot to continue',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 8),
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
                  minimumSize: const Size(double.infinity, 60),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  backgroundColor:
                      isFormValid ? Appcolor.primary : Appcolor.secondary,
                ),
                child: Text(
                  'Continue to Traveller Selection',
                  style: TextStyle(
                    color: isFormValid ? Appcolor.white : Colors.white54,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
