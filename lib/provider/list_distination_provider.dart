import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/core/config/assets/appImages.dart';
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
      imagePath: Appimages.tajMahal,
    ),
    const DestinationCard(
      discription:
          'Jaipur, the capital of Rajasthan, is famous for its distinctive pink-colored architecture, earning it the nickname "Pink City." \n\n'
          'Founded in 1727 by Maharaja Sawai Jai Singh II, Jaipur is known for its rich history, vibrant culture, and stunning palaces.\n\n'
          'Key attractions include the Hawa Mahal, City Palace, and Amber Fort, making it a popular destination for tourists seeking to explore Rajasthan\'s heritage.\n\n'
          'Jaipur is also part of India\'s Golden Triangle tourist circuit, attracting millions of visitors each year.',
      title: 'Jaipur',
      city: 'Rajasthan',
      price: '₹32k',
      imagePath: Appimages.jaipur, // Update the image path as needed
    ),
    const DestinationCard(
      discription:
          'The Char Minar is a historic monument located in Hyderabad, India, built in 1591. \n\n'
          'It is recognized for its four grand arches and intricate architecture, symbolizing the city\'s rich cultural heritage.\n\n'
          'Originally constructed to commemorate the end of a deadly plague, the Char Minar has become an iconic landmark and a center for bustling bazaars.\n\n'
          'Visitors can explore the vibrant streets surrounding the monument, offering a glimpse into the local lifestyle and history.',
      title: 'Char Minar',
      city: 'Hyderabad',
      price: '₹12k',
      imagePath:
         Appimages.charMinar, // Update the image path as needed
    ),
  ];
});
