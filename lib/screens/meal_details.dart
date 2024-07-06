import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/providers/favourite_meal_provider.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealProvider);
    final isFav = favouriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final isAdded = ref
                  .read(favouriteMealProvider.notifier)
                  .onToggleFavouriteMeal(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Text(
                    isAdded ? 'Added to Favourites' : 'Removed form favourites',
                  ),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 500,
              ),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.85, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFav ? Icons.star : Icons.star_border,
                key: ValueKey(isFav),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              height: 300,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Hero(
                tag: meal.id,
                child: Image.network(
                  fit: BoxFit.cover,
                  meal.imageUrl,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Incredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiaryFixed,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiaryFixed,
                  ),
            ),
            for (final step in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 1),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
              )
          ],
        ),
      ),
    );
  }
}
