import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proyecto_flutter/film/data/repository/film_repository.dart';
import 'package:proyecto_flutter/film/domain/film.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../util/conversor.dart';
import '../widgets/film_form.dart';

class FilmViewModel extends ChangeNotifier {
  final FilmRepository filmRepository = FilmRepository();

  List<Film> _films = [];
  List<Film> get films => List.unmodifiable(_films);

  Film? _selectedFilm;
  Film? get selectedFilm => _selectedFilm;
  selectFilm(Film filmToSelect) {
    _selectedFilm = filmToSelect;
    notifyListeners();
  }

  FilmViewModel() {
    filmRepository.getAll().then((result) {
      _films = result;
      notifyListeners();
    });
  }

  Future<bool> createFilm(Film newFilm) async {
    final int? id = await filmRepository.insert(newFilm);
    // todo realizar comprobaciones
    bool isSuccess = false;
    if (id != null) {
      newFilm.id = id;
      _films.add(newFilm);
      isSuccess = true;
    }
    notifyListeners();
    return isSuccess;
  }

  Future<bool> editFilm(Film newFilm) async {
    bool isSuccess = false;
    if (selectedFilm != null) {
      newFilm.id = selectedFilm?.id;
      isSuccess = await filmRepository.update(newFilm);
      if (isSuccess) {
        final int filmIndex = _films.indexOf(_selectedFilm!);
        if (filmIndex >= 0) {
          _films[_films.indexOf(_selectedFilm!)] = newFilm;
          _selectedFilm = newFilm;
          notifyListeners();
        } else {
          isSuccess = false;
        }
      }
    }
    return isSuccess;
  }

  Future<bool> deleteFilm(Film film) async {
    if (await filmRepository.delete(film.id!)) {
      _films.remove(film);
      notifyListeners();
      return true;
    }
    return false;
  }

  // Form
  /// Valida el formulario y devuelve la nueva película.
  /// Si el formulario no se valida devuelve null.
  /// Si al editar una película no se modifica nada, devuelve null
  /// y lanza un snackbar.
  Film? submitForm(BuildContext context, FilmForm filmForm, GlobalKey<FormState> formKey) {
    Film? newFilm;
    if (formKey.currentState!.validate()) {
      final oldFilm = _selectedFilm;
      final duration = parseTimeOfDay(filmForm.duration);
      final String? posterPath = selectedPoster?.path;
      newFilm = Film(
        title: filmForm.title,
        director: filmForm.director,
        year: int.parse(filmForm.year),
        duration: timeOfDayToMinutes(duration),
        description: filmForm.director,
        // Todo: guardar las imágenes en el directorio de documentos de la app
        posterPath: posterPath ?? "https://placehold.co/900x1600/png",
      );

      // Comprobar si se ha modificado algo;
      if (newFilm == oldFilm) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.nothingHasBeenChanged),
          ),
        );
        newFilm = null;
      } else {
        selectPoster(null);
      }
    }
    return newFilm;
  }

  // Poster
  // Todo: moverlo al formulario.
  // Todo: no se si es mejor guardar el path directamente en un string
  File? _selectedPoster;
  File? get selectedPoster => _selectedPoster;

  void selectPoster(File? image) {
    _selectedPoster = image;

    // Evita que se llame a notifyListeners() antes de que se termine de
    // construir el widget del formulario, programando la función para el
    // siguiente ciclo.
    // Todo: no me parece del todo consistente, habría que ver si se puede hacer de otra manera.
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }
}
