import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/models/image_descrip.dart';

// A provider to manage the favorite items
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<ImageDescription>>((ref) {
  return FavoritesNotifier();
});

// The FavoritesNotifier to manage adding/removing favorites
class FavoritesNotifier extends StateNotifier<List<ImageDescription>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(ImageDescription item) {
    if (state.contains(item)) {
      state = state.where((element) => element != item).toList();
    } else {
      state = [...state, item];
    }
  }

  bool isFavorite(ImageDescription item) {
    return state.contains(item);
  }
}
