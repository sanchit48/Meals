import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {

  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();

}

class _FiltersScreenState extends State<FiltersScreen> {

  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {

    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();

  }

  Widget _buildSwitchListTile(String title, String description, bool currentVal, Function updateValue) {

    return SwitchListTile(

      title: Text(title),
      value: currentVal,
      subtitle: Text(description),
      onChanged: updateValue,

    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text('Your filter'),
        actions: <Widget>[

          IconButton(icon: Icon(Icons.save), onPressed: () {

            final selectedFilters = {

              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegetarian': _vegetarian,
              'vegan': _vegan,

            };
            widget.saveFilters(selectedFilters);

          },

          )

        ],

      ),

      drawer: MainDrawer(),
      body: Column(

        children: <Widget>[

          Container(

            padding: EdgeInsets.all(20),
            child: Text(

              'Adjust your meal selction',
              style: Theme.of(context).textTheme.title,

            ),

          ),

          Expanded(

            child: ListView(

              children: <Widget>[

                _buildSwitchListTile('Gluten-Free', 'Only include gluten-free meals', _glutenFree, (newVal) {
                  _glutenFree = true;
                }),

                _buildSwitchListTile('Lactose-Free', 'Only include lactose-free meals', _lactoseFree, (newVal) {
                  _lactoseFree = true;
                }),

                _buildSwitchListTile('Vegetarian', 'Only include vegetarian meals', _vegetarian, (newVal) {
                  _vegetarian = true;
                }),

                _buildSwitchListTile('Vegan', 'Only include vegan meals', _vegan, (newVal) {
                  _vegan = true;
                }),

              ],

            ),

          )

        ],

      )

    );

  }
}