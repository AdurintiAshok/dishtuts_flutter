import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meals/provider/meal_provider.dart';
enum NavigatorData { gulten, veg, lactose, vegan }
class FilterStateNotifier extends StateNotifier<Map<NavigatorData,bool>>
{
  FilterStateNotifier():super({
    NavigatorData.gulten:false,
    NavigatorData.lactose:false,
    NavigatorData.veg:false,
    NavigatorData.vegan:false
  });

  void setFilter(Map<NavigatorData,bool> choosenFilter)
  {
    state=choosenFilter;
  }
  void setFilters(NavigatorData data,bool isChecked)
  {
    state={
      ...state,
   data:isChecked
    };
  }
}
final filterProvider=StateNotifierProvider<FilterStateNotifier,Map<NavigatorData,bool>>((ref){
  return FilterStateNotifier();
});
final filteredMeals=Provider((ref) { 
  final meals=ref.watch(mealProvider);
  final activefilters=ref.watch(filterProvider);
return meals.where((meal) {
      if (activefilters[NavigatorData.gulten]! && !meal.isGlutenFree) {
        return false;
      }
      if (activefilters[NavigatorData.veg]! && !meal.isVegan) {
        return false;
      }
      if (activefilters[NavigatorData.lactose]! && !meal.isGlutenFree) {
        return false;
      }
      if (activefilters[NavigatorData.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();});
    