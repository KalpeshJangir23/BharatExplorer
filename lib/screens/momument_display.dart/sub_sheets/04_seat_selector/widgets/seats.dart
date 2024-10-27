import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TheaterSeating extends StatefulWidget {
  const TheaterSeating({super.key});

  @override
  State<TheaterSeating> createState() => _TheaterSeatingState();
}

class _TheaterSeatingState extends State<TheaterSeating> {
  // Set to store selected seats
  final Set<String> selectedSeats = {};
  
  // Predefined set of booked seats
  final Set<String> bookedSeats = {'D1', 'D2', 'A6', 'A7'};
  
  // Predefined set of disabled seats
  final Set<String> disabledSeats = {
    'F1', 'F2', 'F3', 'F4',
    'E1', 'E2'
  };

  // Generate seat ID
  String getSeatId(int row, int col) {
    return '${String.fromCharCode(65 + row)}${col + 1}';
  }

  // Check seat status
  String getSeatStatus(String seatId) {
    if (selectedSeats.contains(seatId)) return 'selected';
    if (bookedSeats.contains(seatId)) return 'booked';
    if (disabledSeats.contains(seatId)) return 'disabled';
    return 'available';
  }

  // Handle seat selection
  void onSeatTap(String seatId) {
    if (bookedSeats.contains(seatId) || disabledSeats.contains(seatId)) return;
    
    setState(() {
      if (selectedSeats.contains(seatId)) {
        selectedSeats.remove(seatId);
      } else {
        selectedSeats.add(seatId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Theater curve SVG
        Container(
          width: double.infinity,
          height: 40,
          margin: const EdgeInsets.only(bottom: 20),
          child: SvgPicture.asset(
            'assets/vectors/theater_curve.svg',
            fit: BoxFit.contain,
          ),
        ),
        
        // Seats layout
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: List.generate(9, (row) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(10, (col) {
                    final seatId = getSeatId(row, col);
                    final status = getSeatStatus(seatId);
                    
                    return GestureDetector(
                      onTap: () => onSeatTap(seatId),
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
          ),
        ),
        
        // Legend
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