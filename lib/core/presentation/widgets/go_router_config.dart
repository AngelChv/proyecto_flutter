import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_flutter/core/presentation/widgets/scaffold_with_nested_navigation.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_details_screen.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_form_screen.dart';
import 'package:proyecto_flutter/film/presentation/widgets/films_screen.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/presentation/widgets/add_films_to_list_screen.dart';
import 'package:proyecto_flutter/list/presentation/widgets/list_details_screen.dart';
import 'package:proyecto_flutter/list/presentation/widgets/list_form_screen.dart';
import 'package:proyecto_flutter/list/presentation/widgets/lists_screen.dart';
import 'package:proyecto_flutter/profile/presentation/widgets/general_settings_screen.dart';
import 'package:proyecto_flutter/profile/presentation/widgets/profile_screen.dart';
import 'package:proyecto_flutter/profile/presentation/widgets/profile_settings_screen.dart';
import 'package:proyecto_flutter/profile/presentation/widgets/settings_menu_screen.dart';

/// Clave única del Gestor de rutas raíz de la app.
///
/// Se usa para acceder directamente al estado del Navigator desde cualquier
/// parte de la app, para controlar la navegación de forma global.
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Clave única del Gestor de rutas de la pantalla películas.
///
/// Se usa para acceder directamente al estado del Navigator desde cualquier
/// parte de la app, para controlar la navegación de forma global.
final GlobalKey<NavigatorState> _shellNavigatorFilmKey =
    GlobalKey<NavigatorState>();

/// Clave única del Gestor de rutas de la pantalla listas.
///
/// Se usa para acceder directamente al estado del Navigator desde cualquier
/// parte de la app, para controlar la navegación de forma global.
final GlobalKey<NavigatorState> _shellNavigatorListKey =
    GlobalKey<NavigatorState>();

/// Clave única del Gestor de rutas de la pantalla perfil.
///
/// Se usa para acceder directamente al estado del Navigator desde cualquier
/// parte de la app, para controlar la navegación de forma global.
final GlobalKey<NavigatorState> _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>();

/// GoRoute proporciona una forma más declarativa de gestionar la navegación.
/// Funciona en base a rutas, permite redirección, protección, pasar parámetros
/// y rutas anidadas.
final GoRouter routerConfig = GoRouter(
  // todo hacer que la ruta raíz "/" sea el login y la initialLocation
  initialLocation: "/films",
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        // Películas
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFilmKey,
          routes: [
            GoRoute(
              name: "films",
              path: "/films",
              pageBuilder: (context, state) => const NoTransitionPage(
                child: FilmsScreen(),
              ),
              routes: [
                // FilmForm
                GoRoute(
                  name: "filmForm",
                  path: "form/:isEditing",
                  // Importante las subpáginas se deben construir
                  // con builder no Pagebuilder
                  builder: (context, state) {
                    final isEditing =
                        state.pathParameters["isEditing"] == "true";
                    return FilmFormScreen(isEditing: isEditing);
                  },
                ),
                // FilmDetails
                GoRoute(
                  name: "filmDetails",
                  path: "details",
                  builder: (context, state) => const FilmDetailsScreen(),
                ),
              ],
            ),
          ],
        ),
        // Listas
        StatefulShellBranch(
          navigatorKey: _shellNavigatorListKey,
          routes: [
            GoRoute(
              name: "lists",
              path: "/lists",
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ListsScreen(),
              ),
              routes: [
                // ListForm
                GoRoute(
                  name: "listForm",
                  path: "form",
                  builder: (context, state) {
                    final list =
                        state.extra != null ? state.extra as FilmsList : null;
                    return ListFormScreen(oldList: list);
                  },
                ),
                // ListDetails
                GoRoute(
                  name: "listDetails",
                  path: "details",
                  builder: (context, state) {
                    return ListDetailsScreen();
                  },
                  routes: [
                    // AddFilmToList
                    GoRoute(
                      name: "addFilmToList",
                      path: "addFilmToList",
                      builder: (context, state) {
                        final list =
                        state.extra != null ? state.extra as FilmsList : null;
                        return AddFilmsToListScreen(selectedList: list);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // Perfil
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            GoRoute(
              name: "profile",
              path: "/profile",
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProfileScreen(),
              ),
              routes: [
                GoRoute(
                  // Settings
                  name: "settings",
                  path: "settings",
                  builder: (context, state) => const SettingsMenuScreen(),
                  routes: [
                    GoRoute(
                      // General
                      name: "generalSettings",
                      path: "general",
                      builder: (context, state) =>
                          const GeneralSettingsScreen(),
                    ),
                    GoRoute(
                      // Usuario
                      name: "userSettings",
                      path: "user",
                      builder: (context, state) =>
                          const ProfileSettingsScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    )
  ],
);
