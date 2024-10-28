import 'package:flutter_riverpod/flutter_riverpod.dart';

final ticketNotificationProvider =
    StateNotifierProvider<TicketNotificationNotifier, bool>(
  (ref) => TicketNotificationNotifier(),
);

class TicketNotificationNotifier extends StateNotifier<bool> {
  TicketNotificationNotifier() : super(false); // initially no ticket

  void addTicket() => state = true; // set notification to true
  void clearNotification() => state = false; // clear notification
}
