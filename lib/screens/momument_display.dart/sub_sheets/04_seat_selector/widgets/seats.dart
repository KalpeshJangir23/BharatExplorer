import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/provider/booking_provider.dart';

class TheaterSeating extends ConsumerStatefulWidget {
  const TheaterSeating({super.key});

  @override
  ConsumerState<TheaterSeating> createState() => _TheaterSeatingState();
}

class _TheaterSeatingState extends ConsumerState<TheaterSeating> {
  final Set<String> selectedSeats = {};
  final Set<String> bookedSeats = {'L1-1', 'L1-2', 'R2-1', 'R2-2'};
  final Set<String> disabledSeats = {'L9-1', 'L9-2', 'R9-1', 'R9-2', 'R9-3'};

  // Generate seat ID with section prefix (L for left, R for right)
  String getSeatId(String section, int row, int col) {
    return '$section$row-$col';
  }

  String getSeatStatus(String seatId) {
    if (selectedSeats.contains(seatId)) return 'selected';
    if (bookedSeats.contains(seatId)) return 'booked';
    if (disabledSeats.contains(seatId)) return 'disabled';
    return 'available';
  }

  void onSeatTap(String seatId, int seatLimit, WidgetRef ref) {
    if (bookedSeats.contains(seatId) || disabledSeats.contains(seatId)) return;

    setState(() {
      if (selectedSeats.contains(seatId)) {
        selectedSeats.remove(seatId);
      } else if (selectedSeats.length < seatLimit) {
        selectedSeats.add(seatId);
      }

      String selectedSeatsString = selectedSeats.join(',');
      ref
          .read(bookingProvider.notifier)
          .updateSeatSelection(selectedSeatsString);
    });
  }

  Widget buildSeatSection(String section, int rows, int cols, int seatLimit) {
    return Column(
      children: List.generate(rows, (row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: List.generate(cols, (col) {
              final seatId = getSeatId(section, row + 1, col + 1);
              final status = getSeatStatus(seatId);

              return GestureDetector(
                onTap: () => onSeatTap(seatId, seatLimit, ref),
                child: Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: SvgPicture.asset(
                    'assets/vectors/svg_${status}_seat.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final limit = ref.watch(bookingProvider);
    final seatLimit = (int.parse(limit.numberOfAdult ?? '1') +
        int.parse(limit.numberOfChild ?? '0'));

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 40,
          margin: const EdgeInsets.only(bottom: 20),
          child: SvgPicture.asset(
            'assets/vectors/theater_curve.svg',
            height: 20,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Left section (2x9)
              buildSeatSection('L', 9, 2, seatLimit),

              // Aisle
              const SizedBox(width: 20),

              // Right section (3x9)
              buildSeatSection('R', 9, 3, seatLimit),
              const SizedBox(width: 20),

              buildSeatSection('K', 9, 2, seatLimit),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Available', 'svg_available_seat.svg'),
              const SizedBox(width: 16),
              _buildLegendItem('Booked', 'svg_booked_seat.svg'),
              const SizedBox(width: 16),
              _buildLegendItem('Selected', 'svg_selected_seat.svg'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, String svgAsset) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/vectors/$svgAsset',
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
