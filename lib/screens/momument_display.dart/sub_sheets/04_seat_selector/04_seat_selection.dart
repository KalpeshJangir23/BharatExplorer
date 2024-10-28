// Seat Selection Sheet
import 'package:flutter/material.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/04_seat_selector/widgets/seats.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/ticket/ticket.dart';

class SeatSelectionSheet extends StatelessWidget {
  const SeatSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height * 0.75),
      decoration: const BoxDecoration(
        color: Appcolor.darkBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          const Text(
            'Select Seats',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          const TheaterSeating(),
          const SizedBox(height: 20),
          // Add your seat selection content here
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // Close all bottom sheets and proceed to confirmation
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const ConfirmationScreen(),
              ); // Add your booking confirmation logic here
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
            ),
            child: const Text('Confirm Booking' , style: TextStyle(color: Appcolor.white),),
          ),
        ],
      ),
    );
  }
}
