import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/core/config/common/appbar.dart';
import 'package:trip_show_planner/models/image_descrip.dart';
import 'package:trip_show_planner/provider/image_provider.dart';
import 'package:trip_show_planner/screens/HomeScreen/widgets/ImageWithDescriptionCard.dart';

class Desert extends ConsumerWidget {
  final String title;
  const Desert({super.key, required this.title});

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
              imageUrl: 'assets/images/thar_desert.jpg', // Add Thar Desert image
              description:
                  'The Thar Desert, also known as the Great Indian Desert, spans Rajasthan with vast sand dunes and vibrant Rajasthani culture. Famous for its camel safaris and the Desert Festival in Jaisalmer.',
              onLike: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(ImageDescription(
                    imageUrl: 'assets/images/thar_desert.jpg',
                    description:
                        'The Thar Desert, also known as the Great Indian Desert, spans Rajasthan with vast sand dunes and vibrant Rajasthani culture. Famous for its camel safaris and the Desert Festival in Jaisalmer.'));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ImageWithDescriptionCard(
              imageUrl:
                  'assets/images/rann_of_kutch.jpg', // Add Rann of Kutch image
              description:
                  'The Rann of Kutch, known for its white salt plains, comes alive during the Rann Utsav in Gujarat, showcasing Kutchi music, dance, and local handicrafts under the beautiful moonlit sky.',
              onLike: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(ImageDescription(
                    imageUrl: 'assets/images/rann_of_kutch.jpg',
                    description:
                        'The Rann of Kutch, known for its white salt plains, comes alive during the Rann Utsav in Gujarat, showcasing Kutchi music, dance, and local handicrafts under the beautiful moonlit sky.'));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ImageWithDescriptionCard(
              imageUrl:
                  'assets/images/spiti_valley.jpg', // Add Spiti Valley image
              description:
                  'The Spiti Valley Desert in Himachal Pradesh offers breathtaking high-altitude views, ancient monasteries, and a unique cold desert landscape in the Himalayas.',
              onLike: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(ImageDescription(
                    imageUrl: 'assets/images/spiti_valley.jpg',
                    description:
                        'The Spiti Valley Desert in Himachal Pradesh offers breathtaking high-altitude views, ancient monasteries, and a unique cold desert landscape in the Himalayas.'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
