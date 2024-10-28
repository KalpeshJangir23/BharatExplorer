import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/models/bookingModel.dart';
import 'package:trip_show_planner/provider/list_distination_provider.dart';

// Provider instance to be used across the app
final bookingProvider =
    StateNotifierProvider<BookingNotifier, Bookingmodel>((ref) {
  return BookingNotifier();
});

// BookingProvider using StateNotifierProvider to manage Bookingmodel state
class BookingNotifier extends StateNotifier<Bookingmodel> {
  BookingNotifier() : super(Bookingmodel());

  // Update price
  void updatePrice(String price) {
    state = state.copyWith(price: price);
  }

  // Update current location
  void updateCurrentLocation(String location) {
    state = state.copyWith(currentLocation: location);
  }

  // Update current area
  void updateCurrentArea(String area) {
    state = state.copyWith(currentArea: area);
  }

  void updateDistination(WidgetRef ref, index) {
    state = state.copyWith(
        distination: ref.watch(destinationListProvider)[index].title);
  }

  // Update start and end dates
  void updateDates({DateTime? startDate, DateTime? endDate}) {
    state = state.copyWith(startDate: startDate, endDate: endDate);
  }

  // Update start time
  void updateStartTime(String startTime) {
    state = state.copyWith(StartTime: startTime);
  }

  // Update number of adults and children
  void updateTravelers({String? adults, String? children}) {
    state = state.copyWith(numberOfAdult: adults, numberOfChild: children);
  }

  // Update seat selection
  void updateSeatSelection(String seat) {
    state = state.copyWith(seatSelected: seat);
  }

  // Update total price
  void updateTotalPrice(String totalPrice) {
    state = state.copyWith(totalPrice: totalPrice);
  }
}
