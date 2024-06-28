import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            margin: null,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.6),
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.9)
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.fastfood_outlined,
                    size: 40,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Cooking Up',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 40,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surface,
            leading: Icon(
              Icons.restaurant,
              size: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
            ),
            onTap: () {},
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surface,
            leading: Icon(
              Icons.settings,
              size: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
