import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meals/provider/filter_provider.dart';



class Filters extends ConsumerWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final activeFilters=ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          ref.read(filterProvider.notifier).setFilter(
            {
               NavigatorData.gulten:  activeFilters[NavigatorData.gulten]!,
            NavigatorData.veg:  activeFilters[NavigatorData.veg]!,
            NavigatorData.lactose:  activeFilters[NavigatorData.lactose]!,
            NavigatorData.vegan:  activeFilters[NavigatorData.vegan]!
            }
          );
          // Navigator.of(context).pop();
          return true;
        },
        child: Column(children: [
          SwitchListTile(
            value: activeFilters[NavigatorData.gulten]!,
            onChanged: (isChecked) {
             ref.read(filterProvider.notifier).setFilters(NavigatorData.gulten,isChecked);
            },
            title: const Text(
              'Gulten-Free',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text('Only Gulten Free',
                style: TextStyle(color: Colors.white)),
            activeColor: Colors.amber,
            contentPadding: const EdgeInsets.all(10),
          ),
          SwitchListTile(
            value:  activeFilters[NavigatorData.vegan]!,
            onChanged: (isChecked) {
              ref.read(filterProvider.notifier).setFilters(NavigatorData.vegan,isChecked);
            },
            title: const Text(
              'Vegan',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text('Only Vegan Free',
                style: TextStyle(color: Colors.white)),
            activeColor: Colors.amber,
            contentPadding: const EdgeInsets.all(10),
          ),
          SwitchListTile(
            value:  activeFilters[NavigatorData.veg]!,
            onChanged: (isChecked) {
              ref.read(filterProvider.notifier).setFilters(NavigatorData.veg,isChecked);
            },
            title: const Text(
              'Vegetarian-Free',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text('Only Vegetarian Free',
                style: TextStyle(color: Colors.white)),
            activeColor: Colors.amber,
            contentPadding: const EdgeInsets.all(10),
          ),
          SwitchListTile(
            value:  activeFilters[NavigatorData.lactose]!,
            onChanged: (isChecked) {
              ref.read(filterProvider.notifier).setFilters(NavigatorData.lactose,isChecked);
            },
            title: const Text(
              'Lactose-Free',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text('Only Lactose Free Included',
                style: TextStyle(color: Colors.white)),
            activeColor: Colors.amber,
            contentPadding: const EdgeInsets.all(10),
          )
        ]),
      ),
    );
  }
}
