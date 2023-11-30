import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.selectedScreen});
  final void Function(String identifier) selectedScreen; 
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.onPrimary,
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.fastfood,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(
                'Cooking up!',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.restaurant, size: 24, color: Theme.of(context).colorScheme.onBackground,),
          title: Text(
            'Meals',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24,
                ),
          ),
          onTap: () {
            selectedScreen('Meals');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings, size: 24, color:Theme.of(context).colorScheme.onBackground),
          title: Text(
            'Filters',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24,
                ),
          ),
          onTap: () {
            selectedScreen('Filters');
          },
        )
      ]),
    );
  }
}
