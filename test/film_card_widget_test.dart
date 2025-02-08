import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/domain/film.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_card.dart';

void main() {
  group('FilmCard Widget Tests', () {
    testWidgets('Muestra correctamente la información de la película', (WidgetTester tester) async {
      final film = Film(
        id: 1,
        title: 'Inception',
        director: 'Christopher Nolan',
        year: 2010,
        duration: 148,
        description: 'A mind-bending thriller',
        posterPath: 'https://placehold.co/900x1600/png',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FilmCard(film: film),
          ),
        ),
      );

      expect(find.text('Inception'), findsOneWidget);
      expect(find.text('Christopher Nolan'), findsOneWidget);
      expect(find.textContaining('2010'), findsOneWidget);
    });

    testWidgets('Ejecuta la función onTap cuando se toca la tarjeta', (WidgetTester tester) async {
      bool tapped = false;
      final film = Film(
        id: 1,
        title: 'Inception',
        director: 'Christopher Nolan',
        year: 2010,
        duration: 148,
        description: 'A mind-bending thriller',
        posterPath: 'https://placehold.co/900x1600/png',
      );

      await tester.pumpWidget(
        ChangeNotifierProvider<FilmViewModel>(
          create: (BuildContext context) => FilmViewModel(),
          child: MaterialApp(
            home: Scaffold(
              body: FilmCard(
                film: film,
                onTap: (film) => tapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FilmCard));
      expect(tapped, isTrue);
    });
  });

  group('FilmInfo Widget Tests', () {
    testWidgets('Muestra el título, director y descripción', (WidgetTester tester) async {
      final film = Film(
        id: 1,
        title: 'Interstellar',
        director: 'Christopher Nolan',
        year: 2014,
        duration: 169,
        description: 'Sci-fi space epic',
        posterPath: 'https://placehold.co/900x1600/png',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FilmInfo(film: film),
          ),
        ),
      );

      expect(find.text('Interstellar'), findsOneWidget);
      expect(find.text('Christopher Nolan'), findsOneWidget);
      expect(find.textContaining('Sci-fi space epic'), findsOneWidget);
    });
  });
}
