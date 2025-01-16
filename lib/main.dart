import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/ui/core/view_model/app_view_model.dart';
import 'package:proyecto_flutter/ui/core/theme/theme_constants.dart';
import 'package:proyecto_flutter/ui/core/theme/theme_manager.dart';
import 'package:proyecto_flutter/ui/core/widgets/abstract_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppViewModel()),
    ],
    child: const App(),
  ));
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
  late final List<AbstractScreen> screens;
  late void Function(int) changePage;

  @override
  void initState() {
   super.initState();
   // Leer solo una vez el valor, ya que es inmutable.
   screens = context.read<AppViewModel>().screens;
   changePage = context.read<AppViewModel>().changePage;
  }

  @override
  Widget build(BuildContext context) {
    final currentPageIndex = context.watch<AppViewModel>().currentPageIndex;
    final currentPage = screens[currentPageIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(currentPage.title),
        // TODO: añadir actions (buscar...)
        actions: [
          // Actions establecidos en la página actual
          // Se usa el operador ... para separar una lista en elementos individuales.
          // como puede ser nulo se usa ?
          ...?currentPage.appBarActions,

          Switch(
            value: _themeManager.themeMode == ThemeMode.dark,
            onChanged: (newValue) => _themeManager.toggleTheme(newValue),
          )
        ],
      ),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
              destinations: screens.map((screen) {
                return NavigationRailDestination(
                  icon: Icon(screen.icon),
                  label: Text(screen.title),
                );
              }).toList(),
              selectedIndex: currentPageIndex,
              onDestinationSelected: (index) {
                changePage(index);
              },
            ),

          // Screen
          Expanded(
            child: currentPage as Widget,
          ),
        ],
      ),
      bottomNavigationBar: (MediaQuery.of(context).size.width < 640)
          ? NavigationBar(
              selectedIndex: currentPageIndex,
              destinations: screens.map((screen) {
                return NavigationDestination(
                  icon: Icon(screen.icon),
                  label: screen.title,
                );
              }).toList(),
              onDestinationSelected: (int index) {
                changePage(index);
              },
            )
          : null,
    );
  }
}
