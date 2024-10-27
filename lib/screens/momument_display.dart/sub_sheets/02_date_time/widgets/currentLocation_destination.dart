import 'package:flutter/material.dart';
import 'package:trip_show_planner/core/config/assets/iconImages.dart';

class CurrentlocationDestination extends StatelessWidget {
  final String current_location;
  final String current_city;
  final String distination_location;
  final String distination_city;
  const CurrentlocationDestination(
      {super.key,
      required this.current_location,
      required this.current_city,
      required this.distination_location,
      required this.distination_city});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              Iconimages.current_location,
              height: 90,
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text('$current_location\nFrom$current_city'),
          ],
        ),
        Row(
          children: [
            Image.asset(
              Iconimages.destination,
              height: 90,
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text('$distination_location\nTo$distination_city'),
          ],
        )
      ],
    );
  }
}
