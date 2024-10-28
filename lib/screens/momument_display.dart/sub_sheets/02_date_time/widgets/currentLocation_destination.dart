import 'package:flutter/material.dart';
import 'package:trip_show_planner/core/config/assets/iconImages.dart';

class CurrentlocationDestination extends StatelessWidget {
  final String current_location;
  final String current_city;
  final String distination_location;
  final String distination_city;

  const CurrentlocationDestination({
    super.key,
    required this.current_location,
    required this.current_city,
    required this.distination_location,
    required this.distination_city,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLocationRow(
            icon: Iconimages.current_location,
            location: current_location,
            subtitle: 'From $current_city',
          ),
          const SizedBox(height: 8),
          _buildLocationRow(
            icon: Iconimages.destination,
            location: distination_location,
            subtitle: 'To $distination_city',
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow({
    required String icon,
    required String location,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 32,
          height: 80,
          child: Image.asset(
            icon,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
