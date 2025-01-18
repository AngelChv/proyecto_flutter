import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_flutter/core/domain/app_routes.dart';
import 'package:proyecto_flutter/core/presentation/widgets/scaffold_with_nested_navigation.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_form_screen.dart';
import 'package:proyecto_flutter/film/presentation/widgets/films_screen.dart';
import 'package:proyecto_flutter/list/presentation/widgets/lists_screen.dart';
import 'package:proyecto_flutter/profile/presentation/widgets/profile_screen.dart';

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
  initialLocation: AppRoutes.films,
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
              path: AppRoutes.films,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: FilmsScreen(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.addFilm.toRelativeRoute(),
                  // Importante las subpáginas se deben construir
                  // con builder no Pagebuilder
                  builder: (context, state) => const FilmFormScreen(),
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
              path: AppRoutes.lists,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ListsScreen(),
              ),
            ),
          ],
        ),
        // Perfil
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProfileScreen(),
              ),
            ),
          ],
        ),
      ],
    )
  ],
);
