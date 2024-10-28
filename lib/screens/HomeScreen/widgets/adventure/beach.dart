import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/core/config/common/appbar.dart';
import 'package:trip_show_planner/models/image_descrip.dart';
import 'package:trip_show_planner/provider/image_provider.dart';
import 'package:trip_show_planner/screens/HomeScreen/widgets/ImageWithDescriptionCard.dart';

class Beach extends ConsumerWidget {
  final String title;
  const Beach({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(title),
      ),
      body: Column(
        children: [
          ImageWithDescriptionCard(
            imageUrl: 'assets/images/desert.jpg',
            description: 'sadasfasdf',
            onLike: () {
              ref.read(favoritesProvider.notifier).toggleFavorite(
                  ImageDescription(
                      imageUrl: 'assets/images/desert.jpg',
                      description: 'sadasfasdf'));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ImageWithDescriptionCard(
            imageUrl: 'assets/images/desert.jpg',
            description: 'sadasfasdf',
            onLike: () {
              ref.read(favoritesProvider.notifier).toggleFavorite(
                  ImageDescription(
                      imageUrl: 'assets/images/desert.jpg',
                      description: 'sadasfasdf'));
            },
          )
        ],
      ),
    );
  }
}
