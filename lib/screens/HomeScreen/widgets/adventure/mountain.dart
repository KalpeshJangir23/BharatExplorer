import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/core/config/common/appbar.dart';
import 'package:trip_show_planner/models/image_descrip.dart';
import 'package:trip_show_planner/provider/image_provider.dart';
import 'package:trip_show_planner/screens/HomeScreen/widgets/ImageWithDescriptionCard.dart';

class MountainScreen extends ConsumerWidget {
  final String title;
  const MountainScreen({super.key, required this.title});

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
              imageUrl: 'assets/images/kangchenjunga.jpg', // Image for Kangchenjunga
              description:
                  'Kangchenjunga, the third highest mountain in the world, lies in the Himalayas along the India-Nepal border. Known for its majestic peak and cultural significance, it is revered by locals and offers stunning views from Sikkim.',
              onLike: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(ImageDescription(
                    imageUrl: 'assets/images/kangchenjunga.jpg',
                    description:
                        'Kangchenjunga, the third highest mountain in the world, lies in the Himalayas along the India-Nepal border. Known for its majestic peak and cultural significance, it is revered by locals and offers stunning views from Sikkim.'));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ImageWithDescriptionCard(
              imageUrl: 'assets/images/nanda_devi.jpg', // Image for Nanda Devi
              description:
                  'Nanda Devi, the second highest mountain in India, is situated in Uttarakhand. Surrounded by the Nanda Devi National Park, a UNESCO World Heritage site, it is known for its rich biodiversity and scenic beauty.',
              onLike: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(ImageDescription(
                    imageUrl: 'assets/images/nanda_devi.jpg',
                    description:
                        'Nanda Devi, the second highest mountain in India, is situated in Uttarakhand. Surrounded by the Nanda Devi National Park, a UNESCO World Heritage site, it is known for its rich biodiversity and scenic beauty.'));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ImageWithDescriptionCard(
              imageUrl: 'assets/images/k2.jpg', // Image for K2
              description:
                  'K2, the second highest mountain in the world, is part of the Karakoram Range along the India-Pakistan-China border. Known for its challenging climbing routes, K2 attracts adventurers from around the globe.',
              onLike: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(ImageDescription(
                    imageUrl: 'assets/images/k2.jpg',
                    description:
                        'K2, the second highest mountain in the world, is part of the Karakoram Range along the India-Pakistan-China border. Known for its challenging climbing routes, K2 attracts adventurers from around the globe.'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
