import 'package:flutter/material.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/04_seat_selector/widgets/seats.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/ticket/ticket.dart';

class SeatSelectionSheet extends StatelessWidget {
  const SeatSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final padding = MediaQuery.of(context).padding;

    // Calculate dynamic heights
    final sheetHeight = screenHeight * 0.75;
    final titleHeight = screenHeight * 0.05;
    final buttonHeight = screenHeight * 0.07;

    // Calculate dynamic spacing
    final verticalSpacing = screenHeight * 0.02;

    return Container(
      constraints: BoxConstraints.expand(height: sheetHeight),
      decoration: BoxDecoration(
        color: Appcolor.darkBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenWidth * 0.1), // Responsive border radius
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Draggable handle
            Container(
              margin: EdgeInsets.symmetric(
                vertical: verticalSpacing,
                horizontal: screenWidth * 0.4,
              ),
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Title
            Container(
              height: titleHeight,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Select Seats',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: verticalSpacing),

            // Theater seating area
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: const TheaterSeating(),
                ),
              ),
            ),

            SizedBox(height: verticalSpacing),

            // Bottom button
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const ConfirmationScreen(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.9, buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenWidth * 0.1),
                      topRight: Radius.circular(screenWidth * 0.1),
                    ),
                  ),
                ),
                child: Text(
                  'Confirm Booking',
                  style: TextStyle(
                    color: Appcolor.white,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}
