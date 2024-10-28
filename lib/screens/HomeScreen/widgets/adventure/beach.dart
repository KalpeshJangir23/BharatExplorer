import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/core/config/common/appbar.dart';
import 'package:trip_show_planner/models/image_descrip.dart';
import 'package:trip_show_planner/provider/image_provider.dart';
import 'package:trip_show_planner/screens/HomeScreen/widgets/ImageWithDescriptionCard.dart';

class BeachScreen extends ConsumerWidget {
  final String title;
  const BeachScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageWithDescriptionCard(
              imageUrl: 'assets/images/goa_beach.jpg', // Image for Goa Beach
              description:
                  'Goa beaches are famous for their vibrant atmosphere, water sports, and lively nightlife. Baga, Calangute, and Anjuna are popular spots offering golden sands and scenic ocean views.',
              onLike: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(ImageDescription(
                    imageUrl: 'assets/images/goa_beach.jpg',
                    description:
                        'Goa beaches are famous for their vibrant atmosphere, water sports, and lively nightlife. Baga, Calangute, and Anjuna are popular spots offering golden sands and scenic ocean views.'));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ImageWithDescriptionCard(
              imageUrl: 'assets/images/marina_beach.jpg', // Image for Marina Beach
              description:
                  'Marina Beach in Chennai is one of India\'s longest beaches, stretching along the Bay of Bengal. It\'s famous for its sunrise views, local food stalls, and rich history.',
              onLike: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(ImageDescription(
                    imageUrl: 'assets/images/marina_beach.jpg',
                    description:
                        'Marina Beach in Chennai is one of India\'s longest beaches, stretching along the Bay of Bengal. It\'s famous for its sunrise views, local food stalls, and rich history.'));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ImageWithDescriptionCard(
              imageUrl: 'assets/images/radhanagar_beach.jpg', // Image for Radhanagar Beach
              description:
                  'Radhanagar Beach on Havelock Island in the Andaman and Nicobar Islands is known for its pristine white sand, crystal-clear waters, and lush greenery, making it one of Asia\'s most beautiful beaches.',
              onLike: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(ImageDescription(
                    imageUrl: 'assets/images/radhanagar_beach.jpg',
                    description:
                        'Radhanagar Beach on Havelock Island in the Andaman and Nicobar Islands is known for its pristine white sand, crystal-clear waters, and lush greenery, making it one of Asia\'s most beautiful beaches.'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
