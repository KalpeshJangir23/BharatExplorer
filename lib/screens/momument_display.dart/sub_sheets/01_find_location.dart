import 'package:flutter/material.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/02_date_time/02_date_Selection.dart';

// Main Location Bottom Sheet
class LocationBottomSheet extends StatefulWidget {
  final int index;
  const LocationBottomSheet({super.key, required this.index});

  @override
  _LocationBottomSheetState createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  @override
  void initState() {
    super.initState();
    // Delay for 5 seconds before showing the DateSelectionSheet
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop();
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => DateSelectionSheet(
          index: widget.index,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints.expand(height: MediaQuery.of(context).size.height),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Appcolor.darkBackground,
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
            'Select Location',
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(
            color: Appcolor.primary,
            strokeWidth: BorderSide.strokeAlignCenter,
          ),
          const Spacer(),
          // The button won't be used since we are auto-triggering the DateSelectionSheet
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
