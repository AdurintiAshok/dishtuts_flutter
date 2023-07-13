import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/provider/favorite_provider.dart';

class MealItemData extends ConsumerWidget {
  const MealItemData({super.key, required this.meals});
  // final void Function(Meal meal) favouriteMeal;
  final Meal meals;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealContains=ref.watch(favoriteProvider);
    final mealIsExisted=mealContains.contains(meals);
    void makefavorite() {
      final boolData =
          ref.read(favoriteProvider.notifier).toggleFavoriteDish(meals);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(boolData
              ? "Item Added to Favorites"
              : "Item Removed From Favorites")));
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(meals.title),
          actions: [IconButton(onPressed:makefavorite, icon:  Icon( mealIsExisted ? Icons.star : Icons.star_border))],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meals.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Ingrediants",
                style: TextStyle(
                    fontSize: 17, fontFamily: AutofillHints.birthdayDay),
              ),
              const SizedBox(
                height: 5,
              ),
              for (final ingrediants in meals.ingredients)
                Text(
                  ingrediants,
                ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Steps",
                style: TextStyle(
                    fontSize: 17, fontFamily: AutofillHints.birthdayDay),
              ),
              for (final steps in meals.steps)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    steps,
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ));
  }
}
