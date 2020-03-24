import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/favorites_screen.dart';
import './categories_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();

}

class _TabsScreenState extends State<TabsScreen> {

  int selectedIndex = 0;

  List<Map<String, Object>> _pages;


  @override
  void initState() {
    // TODO: implement initState

    _pages = [

        {'pages': CategoriesScreen(), 'title': 'Categories'},
        {'pages': FavoritesScreen(widget.favoriteMeals), 'title': 'Favorites'},

    ];

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(

      length: 2,
      child: Scaffold(

        appBar: AppBar(


          title: Text(_pages[selectedIndex]['title']),
          bottom: TabBar(

            onTap: (index) {

              setState(() {

                selectedIndex = index;

              });

            },

            tabs: <Widget>[

              Tab(icon: Icon(Icons.category), text: 'Categories'),
              Tab(icon: Icon(Icons.star), text: 'Favorites'),

            ]

          ),

        ),

        drawer: MainDrawer(),

        body: TabBarView(

          children: <Widget>[

            _pages[selectedIndex]['pages'],
            _pages[selectedIndex]['pages'],

          ],

        ),

      ),

    );

  }

}