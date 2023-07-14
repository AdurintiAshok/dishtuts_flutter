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
    final mealContains = ref.watch(favoriteProvider);
    final mealIsExisted = mealContains.contains(meals);
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
          actions: [
            IconButton(
                onPressed: makefavorite,
                icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        turns: Tween<double>(begin: 0.8, end: 1)
                            .animate(animation),
                        child: child,
                      );
                    },
                    child: Icon(
                      mealIsExisted ? Icons.star : Icons.star_border,
                      key: ValueKey(mealIsExisted),
                    )))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: meals.id,
                child: Image.network(
                  meals.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Ingrediants",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: AutofillHints.birthdayDay,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              for (final ingrediants in meals.ingredients)
                Container(
                    margin: const EdgeInsets.only(
                        bottom: 10, right: 10, left: 10, top: 10),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.blueGrey,
                          Color.fromRGBO(188, 186, 170, 1)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      ingrediants,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 8, 8, 8),
                          fontWeight: FontWeight.bold),
                    ))),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Steps",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: AutofillHints.birthdayDay,
                    fontWeight: FontWeight.bold),
              ),
              for (final steps in meals.steps)
                Container(
                    margin: const EdgeInsets.only(
                        bottom: 10, right: 10, left: 10, top: 10),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.blueGrey,
                          Color.fromRGBO(188, 186, 170, 1)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        steps,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 11, 10, 10),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
            ],
          ),
        ));
  }
}
