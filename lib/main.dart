import 'package:flutter/material.dart';
import 'package:proyecto_flutter/ui/screens/abstract_screen.dart';
import 'package:proyecto_flutter/ui/screens/films_screen.dart';
import 'package:proyecto_flutter/ui/screens/lists_screen.dart';
import 'package:proyecto_flutter/ui/screens/profile_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmoteca',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Home(),
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
        title: Text(_screens[_currentPageIndex].title), // TODO: usar provider
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
