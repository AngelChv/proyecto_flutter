import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/data/service/film_sqlite_service.dart';
import 'package:proyecto_flutter/film/domain/film.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';
import 'package:proyecto_flutter/list/presentation/view_model/list_view_model.dart';
import 'package:proyecto_flutter/login/presentation/view_model/user_view_model.dart';
import 'package:proyecto_flutter/main.dart';
import 'package:proyecto_flutter/profile/presentation/view_model/profile_view_model.dart'; // Asegúrate de importar el punto de entrada correcto

void main() {
  // Importante !!! Tiene que estar la sesión iniciada!
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final film = Film(
    id: null,
    title: 'Test Integración',
    director: 'director',
    year: 2010,
    duration: 148,
    description: 'descripción',
    posterPath: 'https://placehold.co/900x1600/png',
  );

  // NO se si va a ser necesario qu el token no sea nulo.
  final token = null;

  testWidgets('Navegar a detalles de película y eliminarla', (WidgetTester tester) async {
    // Iniciar la aplicación.
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => FilmViewModel()),
        ChangeNotifierProxyProvider<UserViewModel, ListViewModel>(
          create: (_) => ListViewModel(),
          update: (_, userVM, listVM) {
            final user = userVM.currentUser;
            listVM!.setCurrentUserId(user?.token, userVM.currentUserId);
            return listVM;
          },
        ),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: const App(),
    ));

    // Espero a que la pantalla inicial se cargue completamente.
    await tester.pumpAndSettle();

    // Crear una película:
    await FilmSqliteService().insert(token, film);
    await tester.pumpAndSettle();

    // Asegurar que se actualiza la lista de películas.
    final filmViewModel = Provider.of<FilmViewModel>(tester.element(find.byType(App)), listen: false);
    await filmViewModel.loadFilms(token);
    await tester.pumpAndSettle();


    // Busca una película en la lista y la toca.
    final Finder lastFilm = find.byType(Card).last;
    expect(lastFilm, findsOneWidget);

    await tester.tap(lastFilm);
    await tester.pumpAndSettle();

    // Verificar que se cargó la pantalla de detalles:
    expect(find.textContaining('Test Integración'), findsAtLeastNWidgets(1));

    // Tocar el botón de eliminar.
    final Finder deleteButton = find.byIcon(Icons.delete);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    // Confirmar la eliminación en el diálogo.
    // Hay que tener cuidado con la localización. Tiene que estar en español.
    final Finder confirmButton = find.text('SI');
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    // Verificar que el SnackBar aparece con el mensaje de eliminación exitosa
    // En español!
    expect(find.textContaining('Película eliminada'), findsOneWidget);
  });
}
