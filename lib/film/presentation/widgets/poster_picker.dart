import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_card.dart';

import '../view_model/film_view_model.dart';

/// Permite visualizar y elegir el poster para una película.
class PosterPicker extends StatelessWidget {
  const PosterPicker({super.key});

  // Método para abrir la galería o cámara
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      if (context.mounted) {
        context.read<FilmViewModel>().selectPoster(File(pickedFile.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedImage = context.watch<FilmViewModel>().selectedPoster;

    return Column(
      children: [
        selectedImage != null
            ? Poster(imagePath: selectedImage.path)
            : const Placeholder(
                fallbackHeight: 200,
                fallbackWidth: double.infinity,
              ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(context, ImageSource.gallery),
              icon: const Icon(Icons.photo),
              label: const Text('Galería'),
            ),
            // Todo: en web da error
            if (!Platform.isWindows)
              ElevatedButton.icon(
                onPressed: () => _pickImage(context, ImageSource.camera),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Cámara'),
              ),
          ],
        ),
      ],
    );
  }
}
