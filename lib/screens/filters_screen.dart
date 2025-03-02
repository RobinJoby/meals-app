import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
// import 'package:meals_app/screens/tabs_screen.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreen();
  }
}

class _FiltersScreen extends ConsumerState<FiltersScreen> {
  var _glutterFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegeterianFilterSet = false;
  var _veganFilterSet = false;

  //widget can be accessed inside the initstate method

  @override
  void initState() {
    super.initState();
    final filters = ref.read(filtersProvider);
    _glutterFreeFilterSet = filters[Filter.gluttenFree]!;
    _lactoseFreeFilterSet = filters[Filter.lactosFree]!;
    _veganFilterSet = filters[Filter.vegan]!;
    _vegeterianFilterSet = filters[Filter.vegetarian]!;
  }

  @override
  Widget build(context) {
    return Scaffold(
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (ctx) => const TabsScreen()));
      //   }
      // }),
      appBar: AppBar(
        title: const Text(
          'Your Filters',
        ),
      ),
      //         WillPopScope(
//   onWillPop: () async {
//     Navigator.of(context).pop({
//       Filter.glutenFree: _glutenFreeFilterSet,
//       Filter.lactoseFree: _lactoseFreeFilterSet,
//       Filter.vegetarian: _vegetarianFilterSet,
//       Filter.vegan: _veganFilterSet,
//     });
//     return false;
//   },
//   child: Column(...) // same code as before
// ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          // if (didPop) {
          //   return;
          // }
          ref.read(filtersProvider.notifier).changeFilters({
            Filter.gluttenFree: _glutterFreeFilterSet,
            Filter.lactosFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _veganFilterSet,
            Filter.vegan: _vegeterianFilterSet,
          });
          return;
          // Navigator.of(context).pop({
          //   Filter.gluttenFree: _glutterFreeFilterSet,
          //   Filter.lactosFree: _lactoseFreeFilterSet,
          //   Filter.vegetarian: _veganFilterSet,
          //   Filter.vegan: _vegeterianFilterSet,
          // });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutterFreeFilterSet,
              onChanged: (newValue) {
                setState(() {
                  _glutterFreeFilterSet = newValue;
                });
              },
              title: Text(
                'Glutter-Free',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include glutten free meals',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (newValue) {
                setState(() {
                  _lactoseFreeFilterSet = newValue;
                });
              },
              title: Text(
                'Lactose-Free',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include lactose free meals',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _vegeterianFilterSet,
              onChanged: (newValue) {
                setState(() {
                  _vegeterianFilterSet = newValue;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include vegetarian meals',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (newValue) {
                setState(() {
                  _veganFilterSet = newValue;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include vegan meals',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
