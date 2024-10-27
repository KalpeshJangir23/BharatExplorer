import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/04_seat_selector/04_seat_selection.dart';

class TravellerSelectionSheet extends StatefulWidget {
  const TravellerSelectionSheet({super.key});

  @override
  State<TravellerSelectionSheet> createState() =>
      _TravellerSelectionSheetState();
}

class _TravellerSelectionSheetState extends State<TravellerSelectionSheet> {
  int numberOfAdults = 1;
  bool hasChildren = false;
  int numberOfChildren = 0;

  Widget _buildNumberCarousel({
    required List<int> numbers,
    required int selectedNumber,
    required Function(int) onChanged,
    double fontSize = 120,
  }) {
    return CarouselSlider.builder(
      itemCount: numbers.length,
      options: CarouselOptions(
        height: hasChildren ? 120 : 180,
        viewportFraction: 0.4,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: selectedNumber - 1,
        onPageChanged: (index, reason) {
          onChanged(numbers[index]);
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final number = numbers[index];
        final isSelected = number == selectedNumber;

        return Text(
          '$number',
          style: TextStyle(
            height: 1.2,
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: isSelected ? Colors.white : Appcolor.Range_color,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Appcolor.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          const Text(
            'How many adults?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Text(
            '12 YEARS +',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20),

          _buildNumberCarousel(
            numbers: List.generate(13, (i) => i + 1),
            selectedNumber: numberOfAdults,
            onChanged: (value) {
              setState(() {
                numberOfAdults = value;
              });
            },
            fontSize: hasChildren ? 80 : 120,
          ),

          const SizedBox(height: 20),

          // Children Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: hasChildren,
                onChanged: (value) {
                  setState(() {
                    hasChildren = value ?? false;
                    if (!hasChildren) {
                      numberOfChildren = 0;
                    }
                  });
                },
                checkColor: Colors.white,
                fillColor: WidgetStateProperty.resolveWith(
                  (states) => Appcolor.primary,
                ),
              ),
              const Text(
                'Children',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          if (hasChildren) ...[
            const SizedBox(height: 10),
            _buildNumberCarousel(
              numbers: List.generate(6, (i) => i + 1),
              selectedNumber: numberOfChildren,
              onChanged: (value) {
                setState(() {
                  numberOfChildren = value;
                });
              },
              fontSize: 80,
            ),
          ],

          const Spacer(),
          Text(
            'Total: 0.6 BTC',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const SeatSelectionSheet(),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.blue,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'Continue to Seat Selection',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
