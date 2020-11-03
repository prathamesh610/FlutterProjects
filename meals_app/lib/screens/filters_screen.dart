import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  // Used to define route
  static const namedRoutes = '/filters';
  // for constructor
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegeterian = false;
  bool _lactoseFree = false;
  bool _vegan = false;

  /*
   init state is being called. we check for the filters updated by the user
   and then display the meals accordingly. Here we change the filters value as
   the user updates it in the app
  */
  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegeterian = widget.currentFilters['vegeterian'];
    super.initState();
  }

  // Just to save some space and make code clean and lean
  Widget _buildSwitchTile(
      String title, String subtitle, bool variable, Function update) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: variable,
      onChanged: update,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final setFilters = {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegan': _vegan,
                    'vegeterian': _vegeterian,
                  };
                  widget.saveFilters(setFilters);
                })
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchTile('Gluten-Free',
                    'Only include gluten free meals', _glutenFree, (newValue) {
                  setState(
                    () {
                      _glutenFree = newValue;
                    },
                  );
                }),
                _buildSwitchTile(
                    'Lactose-Free',
                    'Only include lactose free meals',
                    _lactoseFree, (newValue) {
                  setState(
                    () {
                      _lactoseFree = newValue;
                    },
                  );
                }),
                _buildSwitchTile(
                    'Vegeterian', 'Only include vegeterian meals', _vegeterian,
                    (newValue) {
                  setState(
                    () {
                      _vegeterian = newValue;
                    },
                  );
                }),
                _buildSwitchTile('Vegan', 'Only include vegan meals', _vegan,
                    (newValue) {
                  setState(
                    () {
                      _vegan = newValue;
                    },
                  );
                }),
              ],
            )),
          ],
        ));
  }
}
