import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/widgets/meal_item.dart';
import 'package:meals_app/screens/meal_info.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      this.title,
      required this.meals,});

  final String? title;
  final List<Meal> meals;

  void selectedMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealInfo(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(
                meal: meals[index],
                onSelectedMeal: (meal) {
                  selectedMeal(context, meal);
                },
              ));
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
