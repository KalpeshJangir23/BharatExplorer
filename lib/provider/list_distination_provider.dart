import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/screens/HomeScreen/widgets/distinationCard.dart';

// Define a provider for a list of DestinationCard objects
final destinationListProvider = Provider<List<DestinationCard>>((ref) {
  return [
    const DestinationCard(
      discription:
          'The Taj Mahal is an Islamic ivory-white marble mausoleum located in Agra, India.\n\n'
          'It was commissioned in 1632 by Mughal emperor Shah Jahan to house the tomb of his favorite wife, Mumtaz Mahal.\n\n'
          'The Taj Mahal is widely considered one of the most beautiful buildings in the world and a symbol of India\'s rich history.\n\n'
          'It is a UNESCO World Heritage Site and attracts millions of visitors each year.',
      title: 'Taj Mahal',
      city: "Agra",
      price: '18k',
      imagePath: 'assets/images/taj_mahal.jpg',
    ),
    const DestinationCard(
      discription: "Jaipur is known as pink City ",
      title: 'Jaipur',
      city: 'Raj',
      price: '₹32k',
      imagePath: 'assets/images/taj_mahal.jpg',
    ),
    const DestinationCard(
      discription: 'it has 4 pillar',
      title: 'Char Minar',
      city: "HYD",
      price: '₹12k',
      imagePath: 'assets/images/taj_mahal.jpg',
    ),
  ];
});
