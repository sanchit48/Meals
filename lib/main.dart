import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _filters = {

    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,

  };

  List<Meal> _avalaibleMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _saveFilters(Map<String, bool> filterData) {

    setState(() {

      _filters = filterData;

      _avalaibleMeals = DUMMY_MEALS.where((meal) {

        if(_filters['gluten'] && !meal.isGlutenFree)
          return false;

        if(_filters['lactose'] && !meal.isLactoseFree)
          return false;

        if(_filters['vegetarian'] && !meal.isVegetarian)
          return false;

        if(_filters['vegan'] && !meal.isVegan)
          return false;

        return true;

      }).toList();

    });

  }

  void _toggleFavorite(String mealId) {

      // gives -1 if not already there
    final existingIndex =  _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if(existingIndex >= 0) {

      setState(() {

        _favoriteMeals.removeAt(existingIndex);

      });

    }

    else {

      setState(() {

        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));

      });

    }

  }

  bool _isMealFavorite(String mealId) {

    return _favoriteMeals.any((meal) => meal.id == mealId);

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'DeliMeals',
      theme: ThemeData(

        primarySwatch: Colors.pink,
        // The foreground color for widgets (knobs, text, overscroll edge effect, etc).
        accentColor: Colors.orange,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(

          body1: TextStyle(
            // red green blue, orange
            color: Color.fromRGBO(20, 51, 51, 1),
          ),

          body2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),

          title: TextStyle(

            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,

          )

        )

      ),

      routes: {

        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_avalaibleMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _saveFilters),

      },

    );

  }
}