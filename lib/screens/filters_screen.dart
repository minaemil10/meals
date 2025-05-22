import 'package:flutter/material.dart';
// import 'package:meals/screens/tabs_screen.dart';
// import 'package:meals/widgets/main_drawer.dart';

enum Filters { gluteenFree, lactoseFree, vageterian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.activeFilters});

  final Map<Filters, bool> activeFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeIsSet = false;
  var _lactoseFreeIsSet = false;
  var _vegeterianIsSet = false;
  var _veganIsSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeIsSet = widget.activeFilters[Filters.gluteenFree]!;
    _lactoseFreeIsSet = widget.activeFilters[Filters.lactoseFree]!;
    _veganIsSet = widget.activeFilters[Filters.vegan]!;
    _vegeterianIsSet = widget.activeFilters[Filters.vageterian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filters')),
      // drawer: MainDrawer(
      //   onChooseScreen: (name) {
      //     Navigator.of(context).pop();
      //     if (name == 'meals') {
      //       Navigator.of(context).pushReplacement( //used to pop previous screen and push a new one so that the back button can't go back to the previous screen
      //         MaterialPageRoute(builder: (ctx) => TabsScreen()),
      //       );
      //     }
      //   },
      // ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filters.gluteenFree: _glutenFreeIsSet,
            Filters.lactoseFree: _lactoseFreeIsSet,
            Filters.vageterian: _vegeterianIsSet,
            Filters.vegan: _veganIsSet,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeIsSet,
              onChanged: (value) {
                setState(() {
                  _glutenFreeIsSet = value;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Inlclude only gluten-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              contentPadding: EdgeInsets.only(left: 34, right: 22),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _lactoseFreeIsSet,
              onChanged: (value) {
                setState(() {
                  _lactoseFreeIsSet = value;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Inlclude only lactose-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              contentPadding: EdgeInsets.only(left: 34, right: 22),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _vegeterianIsSet,
              onChanged: (value) {
                setState(() {
                  _vegeterianIsSet = value;
                });
              },
              title: Text(
                'Vegeterian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Inlclude only vegeterian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              contentPadding: EdgeInsets.only(left: 34, right: 22),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _veganIsSet,
              onChanged: (value) {
                setState(() {
                  _veganIsSet = value;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Inlclude only Vegan meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              contentPadding: EdgeInsets.only(left: 34, right: 22),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
