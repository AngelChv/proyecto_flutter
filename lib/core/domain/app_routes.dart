abstract class AppRoutes {
  // TODO: comprobar si es necesario la ruta raiz "/"
  static const String films = '/films';
  static const String addFilm = '/films/addFilm';
  static const String filmDetails = '/films/details';
  static const String filmLists = '/films/lists';
  static const String addListsToFilm = '/films/lists/addListsToFilm';

  static const String lists = '/lists';
  static const String addList = '/lists/addList';
  static const String listDetails = '/lists/details';
  static const String addFilmsToList = '/lists/details/addFilmsToList';

  static const String profile = '/profile';
  static const String settingsMenu = '/profile/settings';
  static const String generalSettings = '/profile/settings/general';
  static const String userSettings = '/profile/settings/user';
}

extension RouteExtension on String {
  String toRelativeRoute() {
    return split('/').last;
  }
}