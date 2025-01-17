import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/presentation/go_router_config.dart';
import 'package:proyecto_flutter/core/presentation/view_model/app_view_model.dart';
import 'package:proyecto_flutter/core/presentation/theme/theme_constants.dart';
import 'package:proyecto_flutter/core/presentation/widgets/abstract_screen.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';
import 'package:proyecto_flutter/list/presentation/view_model/list_view_model.dart';
import 'package:proyecto_flutter/profile/presentation/view_model/profile_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppViewModel()),
      ChangeNotifierProvider(create: (_) => FilmViewModel()),
      ChangeNotifierProvider(create: (_) => ListViewModel()),
      ChangeNotifierProvider(create: (_) => ProfileViewModel()),
    ],
    child: const App(),
  ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ProfileViewModel>().themeMode;

    return MaterialApp.router(
      title: 'Filmoteca',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: routerConfig,
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
   changePage = context.read<AppViewModel>().changeNavigationPage;
  }

  @override
  Widget build(BuildContext context) {
    // todo: mover el switch a la configuración
    final profileVieModel = context.watch<ProfileViewModel>();

    final currentPage = context.watch<AppViewModel>().currentPage;
    final currentPageIndex = context.watch<AppViewModel>().currentPageIndex;

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
            value: profileVieModel.themeMode == ThemeMode.dark,
            onChanged: (newValue) => profileVieModel.toggleTheme(newValue),
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

      floatingActionButton: currentPage.floatingActionButton(context),

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
