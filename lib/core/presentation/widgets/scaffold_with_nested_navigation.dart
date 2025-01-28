import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Scaffold que implementa la navegación de go_router
/// mediante StatefulNavigationShell _navigatorShell
///
/// Se adapta en función del tamaño del ancho de la pantalla para usar
/// NavigationBar si la pantalla es compacta
/// o NavigationRail si es grande.
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    super.key,
    required StatefulNavigationShell navigationShell,
  }) : _navigationShell = navigationShell;

  /// Encapsula el resto del body, permite gestionar la navegación.
  final StatefulNavigationShell _navigationShell;

  // TODO: usar recurso para el string
  // TODO: destinations en una lista, aunque son distintos tipos.
  List<Map<String, Widget>> _destinations(BuildContext context) => [
        {
          "icon": Icon(Icons.movie),
          "label": Text(AppLocalizations.of(context)!.films)
        },
        {
          "icon": Icon(Icons.list),
          "label": Text(AppLocalizations.of(context)!.lists)
        },
        {
          "icon": Icon(Icons.person),
          "label": Text(AppLocalizations.of(context)!.profile)
        },
      ];

  /// Navega a la rama con el indicie indicado, si es la rama actual, se va
  /// a la raíz de todas las sub-ramas de la rama.
  void _goBranch(int index) {
    _navigationShell.goBranch(
      index,
      initialLocation: index == _navigationShell.currentIndex,
    );
  }

  /// Encapsula el body con un row, que contiene el NavigationRail y el resto
  /// del body en un Expanded.
  Widget _navigationRailBody(BuildContext context, Widget body) {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          labelType: NavigationRailLabelType.all,
          destinations: _destinations(context).map((destination) {
            return NavigationRailDestination(
              icon: destination["icon"] as Icon,
              label: destination["label"] as Text,
            );
          }).toList(),
        ),
        Expanded(child: body),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
    return Scaffold(
      body: isWideScreen
          ? _navigationRailBody(context, _navigationShell)
          : _navigationShell,
      bottomNavigationBar: !isWideScreen
          ? NavigationBar(
              selectedIndex: _navigationShell.currentIndex,
              onDestinationSelected: _goBranch,
              destinations: _destinations(context).map((destination) {
                final Text text = destination["label"] as Text;
                return NavigationDestination(
                  icon: destination["icon"] as Icon,
                  label: text.data as String,
                );
              }).toList(),
            )
          : null,
    );
  }
}
