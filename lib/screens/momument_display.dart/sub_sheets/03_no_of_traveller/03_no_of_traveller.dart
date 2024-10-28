import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';
import 'package:trip_show_planner/provider/booking_provider.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/04_seat_selector/04_seat_selection.dart';

class TravellerSelectionSheet extends ConsumerStatefulWidget {
  final int index;
  const TravellerSelectionSheet({super.key, required this.index});

  @override
  ConsumerState<TravellerSelectionSheet> createState() =>
      _TravellerSelectionSheetState();
}

class _TravellerSelectionSheetState
    extends ConsumerState<TravellerSelectionSheet> {
  static const double ADULT_PRICE = 800.0;
  static const double CHILD_PRICE = 300.0;

  int numberOfAdults = 1;
  bool hasChildren = false;
  int numberOfChildren = 0;

  double get totalAmount {
    return (numberOfAdults * ADULT_PRICE) + (numberOfChildren * CHILD_PRICE);
  }

  String formatCurrency(double amount) {
    if (amount >= 1000) {
      return '₹${(amount / 1000).toStringAsFixed(1)}k';
    }
    return '₹${amount.toStringAsFixed(0)}';
  }

  bool get isFormValid => totalAmount > 0;

  Widget _buildNumberCarousel({
    required List<int> numbers,
    required int selectedNumber,
    required Function(int) onChanged,
    required String label,
    required String subtitle,
    double fontSize = 140,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 10),
        CarouselSlider.builder(
          itemCount: numbers.length,
          options: CarouselOptions(
            height: hasChildren ? 110 : 140,
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
                height: 0.7,
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
                color: isSelected ? Colors.white : Appcolor.Range_color,
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: Appcolor.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30,),
          _buildNumberCarousel(
            numbers: List.generate(13, (i) => i + 1),
            selectedNumber: numberOfAdults,
            label: 'Adults',
            subtitle: '12 YEARS +',
            onChanged: (value) {
              setState(() {
                numberOfAdults = value;
              });
              ref
                  .read(bookingProvider.notifier)
                  .updateTravelers(adults: value.toString());
            },
            fontSize: hasChildren ? 100 : 140,
          ),

          const SizedBox(height: 10),

          // Children Toggle
          Container(
            decoration: BoxDecoration(
              // color: Appcolor.Range_color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
                  fillColor: MaterialStateProperty.resolveWith(
                    (states) => Appcolor.Range_color,
                  ),
                ),
                const Text(
                  'Add Children',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          if (hasChildren) ...[
            const SizedBox(height: 20),
            _buildNumberCarousel(
              numbers: List.generate(6, (i) => i + 1),
              selectedNumber: numberOfChildren,
              label: 'Children',
              subtitle: 'UNDER 12 YEARS',
              onChanged: (value) {
                setState(() {
                  numberOfChildren = value;
                });
                ref
                    .read(bookingProvider.notifier)
                    .updateTravelers(children: value.toString());
              },
              fontSize: 100,
            ),
          ],

          const Spacer(),

          // Total Amount Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // color: Appcolor.Range_color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      formatCurrency(totalAmount),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${numberOfAdults + numberOfChildren} Travelers',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
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
              backgroundColor: Appcolor.secondary,
              minimumSize: const Size(double.infinity, 60),
              shape:const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
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
