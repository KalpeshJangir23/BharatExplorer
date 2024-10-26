// Seat Selection Sheet
import 'package:flutter/material.dart';

class SeatSelectionSheet extends StatelessWidget {
  const SeatSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height * 0.45),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Seats',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          // Add your seat selection content here
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // Close all bottom sheets and proceed to confirmation
              Navigator.of(context).popUntil((route) => route.isFirst);
              // Add your booking confirmation logic here
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Confirm Booking'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
