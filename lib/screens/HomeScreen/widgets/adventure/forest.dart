import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/core/config/common/appbar.dart';
import 'package:trip_show_planner/models/image_descrip.dart';
import 'package:trip_show_planner/provider/image_provider.dart';
import 'package:trip_show_planner/screens/HomeScreen/widgets/ImageWithDescriptionCard.dart';

class ForestScreen extends ConsumerWidget {
  final String title;
  const ForestScreen({super.key, required this.title});

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
              imageUrl: 'assets/images/sundarbans.jpg', // Image for Sundarbans
              description:
                  'The Sundarbans, a UNESCO World Heritage site, is the largest mangrove forest in the world, located in West Bengal. Home to the Bengal tiger and unique wildlife, it is famous for its intricate network of waterways and dense mangroves.',
              onLike: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(ImageDescription(
                    imageUrl: 'assets/images/sundarbans.jpg',
                    description:
                        'The Sundarbans, a UNESCO World Heritage site, is the largest mangrove forest in the world, located in West Bengal. Home to the Bengal tiger and unique wildlife, it is famous for its intricate network of waterways and dense mangroves.'));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ImageWithDescriptionCard(
              imageUrl: 'assets/images/kaziranga.jpg', // Image for Kaziranga Forest
              description:
                  'Kaziranga Forest in Assam is renowned for its dense population of one-horned rhinoceroses and rich biodiversity. This protected area is a UNESCO World Heritage site and an important habitat for tigers, elephants, and various bird species.',
              onLike: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(ImageDescription(
                    imageUrl: 'assets/images/kaziranga.jpg',
                    description:
                        'Kaziranga Forest in Assam is renowned for its dense population of one-horned rhinoceroses and rich biodiversity. This protected area is a UNESCO World Heritage site and an important habitat for tigers, elephants, and various bird species.'));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ImageWithDescriptionCard(
              imageUrl: 'assets/images/ghats.jpg', // Image for Western Ghats
              description:
                  'The Western Ghats, extending along the western coast of India, is a biodiversity hotspot with a vast array of flora and fauna. Spanning multiple states, it supports endangered species and lush rainforests.',
              onLike: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(ImageDescription(
                    imageUrl: 'assets/images/ghats.jpg',
                    description:
                        'The Western Ghats, extending along the western coast of India, is a biodiversity hotspot with a vast array of flora and fauna. Spanning multiple states, it supports endangered species and lush rainforests.'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
