

// Date Selection Sheet
import 'package:flutter/material.dart';
import 'package:trip_show_planner/screens/momument_display.dart/widgets/03_no_of_traveller.dart';

class DateSelectionSheet extends StatelessWidget {
  const DateSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height * 0.75),
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
            'Select Date',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
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
            child: const Text('Continue to Traveller Selection'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
