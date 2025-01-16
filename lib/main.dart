import 'package:flutter/material.dart';
import 'package:proyecto_flutter/theme/theme_constants.dart';
import 'package:proyecto_flutter/theme/theme_manager.dart';
import 'package:proyecto_flutter/ui/screens/abstract_screen.dart';
import 'package:proyecto_flutter/ui/screens/films_screen.dart';
import 'package:proyecto_flutter/ui/screens/lists_screen.dart';
import 'package:proyecto_flutter/ui/screens/profile_screen.dart';

void main() {
  runApp(const App());
}

final ThemeManager _themeManager = ThemeManager();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // todo usar provider en lugar de esto:

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmoteca',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<AbstractScreen> _screens = [
    FilmsScreen(),
    ListsScreen(),
    ProfileScreen(),
  ];

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(_screens[_currentPageIndex].title), // TODO: usar provider
        // TODO: añadir actions (buscar...)
        actions: [
          // Actions establecidos en la página actual
          // Se usa el operador ... para separar una lista en elementos individuales.
          // como puede ser nulo se usa ?
          ...?_screens[_currentPageIndex].appBarActions,
          Switch(
            value: _themeManager.themeMode == ThemeMode.dark,
            onChanged: (newValue) => _themeManager.toggleTheme(newValue),
          )
        ],
/*
        [

        ],
*/
      ),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
              destinations: _screens.map((screen) {
                return NavigationRailDestination(
                  icon: Icon(screen.icon),
                  label: Text(screen.title),
                );
              }).toList(),
              selectedIndex: _currentPageIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
            ),

          // Screen
          Expanded(
            child: _screens[_currentPageIndex] as Widget,
          ),
        ],
      ),
      bottomNavigationBar: (MediaQuery.of(context).size.width < 640)
          ? NavigationBar(
              selectedIndex: _currentPageIndex,
              destinations: _screens.map((screen) {
                return NavigationDestination(
                  icon: Icon(screen.icon),
                  label: screen.title,
                );
              }).toList(),
              onDestinationSelected: (int index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
            )
          : null,
    );
  }
}
