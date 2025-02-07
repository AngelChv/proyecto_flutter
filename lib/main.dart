import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/presentation/widgets/go_router_config.dart';
import 'package:proyecto_flutter/core/presentation/theme/theme_constants.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';
import 'package:proyecto_flutter/list/presentation/view_model/list_view_model.dart';
import 'package:proyecto_flutter/login/presentation/view_model/user_view_model.dart';
import 'package:proyecto_flutter/profile/presentation/view_model/profile_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Si se quieren manejar los snackbar de manera global
//final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

/// Punto de entrada de la APP
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserViewModel()),
      ChangeNotifierProvider(create: (_) => FilmViewModel()),
      ChangeNotifierProvider(create: (_) => ListViewModel()),
      ChangeNotifierProvider(create: (_) => ProfileViewModel()),
    ],
    child: const App(),
  ));
}

/// Widget principal, en el está el MaterialApp.
///
/// Configura las localizaciones, el tema y las rutas.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ProfileViewModel>().themeMode;
    final String localeKey = context.watch<ProfileViewModel>().language;

    return MaterialApp.router(
      //scaffoldMessengerKey: scaffoldKey,
      title: 'Filmoteca',
      locale: localeKey.isEmpty ? null : Locale(localeKey),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
    );
  }
}