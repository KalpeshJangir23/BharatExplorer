import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';
import 'package:trip_show_planner/provider/booking_provider.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/02_date_time/02_date_Selection.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationBottomSheet extends ConsumerStatefulWidget {
  final int index;
  const LocationBottomSheet({super.key, required this.index});

  @override
  _LocationBottomSheetState createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends ConsumerState<LocationBottomSheet> {
  String? _currentAddress;
  Position? _currentPosition;

  Future<void> _showLocationServicesDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Appcolor.darkBackground,
          title: const Text(
            'Location Services Disabled',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your location services are disabled. To use this feature, please:',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.settings, color: Appcolor.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '1. Go to Settings',
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Appcolor.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '2. Tap Location',
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.toggle_on, color: Appcolor.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '3. Turn on Location services',
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Close bottom sheet
              },
            ),
            TextButton(
              child: const Text('Open Settings',
                  style: TextStyle(color: Appcolor.primary)),
              onPressed: () async {
                await Geolocator.openLocationSettings();
                Navigator.of(context).pop();
                // Wait briefly before checking location status again
                await Future.delayed(const Duration(seconds: 2));
                if (mounted) {
                  _getCurrentPosition();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showLocationServicesDialog();
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
      ref
          .read(bookingProvider.notifier)
          .updateCurrentArea(place.subAdministrativeArea.toString());

      ref
          .read(bookingProvider.notifier)
          .updateCurrentLocation(place.subLocality.toString());

      Navigator.of(context).pop();
      showModalBottomSheet(
        context: context,
        backgroundColor: Appcolor.darkBackground,
        isScrollControlled: true,
        builder: (context) => DateSelectionSheet(
          index: widget.index,
        ),
      );
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height * 0.95),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      decoration: const BoxDecoration(
        color: Appcolor.darkBackground,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 80),
          const Text(
            'Finding your location',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'One moment while we get\nyour location',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Appcolor.GREY_COLOR),
          ),
          const SizedBox(height: 20),
          const SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: Appcolor.primary,
              strokeWidth: 8,
            ),
          ),
          const Spacer(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
