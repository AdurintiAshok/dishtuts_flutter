import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/meal.dart';

class NotifierSate extends StateNotifier<List<Meal>> {
  NotifierSate() : super([]);

  bool toggleFavoriteDish(Meal meal) {
    final isExisted = state.contains(meal);
    if (isExisted) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteProvider = StateNotifierProvider<NotifierSate,List<Meal>>((ref) {
  return NotifierSate();
});
