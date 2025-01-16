import 'package:flutter/material.dart';

class FilmForm extends StatefulWidget {
  const FilmForm({super.key});

  @override
  State<FilmForm> createState() => _FilmFormState();
}

class _FilmFormState extends State<FilmForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Título"
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Introduzca un título";
              }
              return null;
            },
          ),

          TextFormField(
            decoration: const InputDecoration(
                hintText: "Director"
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Introduzca un título";
              }
              return null;
            },
          ),

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enviando formulario..."))
                );
              }
            },
            child: const Text("Enviar"),
          ),
        ],
      ),
    );
  }
}
