import 'package:flutter/material.dart';
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
  final List<Widget> _screens = [
    FilmsScreen(),
    ListsScreen(),
    ProfileScreen(),
  ];

  final List<NavigationDestination> _navigations = [
    // Películas
    NavigationDestination(
      icon: Icon(Icons.movie),
      label: "Películas",
    ),

    // Listas
    NavigationDestination(
      icon: Icon(Icons.list),
      label: "Listas",
    ),

    // Perfil
    NavigationDestination(
      icon: Icon(Icons.person),
      label: "Perfil",
    ),
  ];

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_navigations[_currentPageIndex].label), // TODO: usar provider
      ),
      body: _screens[_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPageIndex,
        destinations: _navigations,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}
