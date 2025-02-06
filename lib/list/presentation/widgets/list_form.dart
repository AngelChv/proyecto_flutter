import 'package:flutter/material.dart';

import '../../../core/presentation/theme/style_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Formulario para crear o editar una lista.
class ListForm extends StatelessWidget {
  ListForm({
    super.key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  GlobalKey<FormState> get formKey => _formKey;

  final _nameController = TextEditingController();
  String get name => _nameController.text;

  List<Widget> _buildFields(BuildContext context) {
    return [
      TextFormField(
        controller: _nameController,
        decoration: InputDecoration(
          // TODO: crear localización para nombre
          hintText: AppLocalizations.of(context)!.title,
          labelText: AppLocalizations.of(context)!.title,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            // TODO: cambiar localización.
            return AppLocalizations.of(context)!.insertTheTitle;
          }
          return null;
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
    final fields = _buildFields(context);

    return Form(
      key: _formKey,
      child: ListView.separated(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        itemCount: fields.length,
        itemBuilder: (context, index) => fields[index],
        separatorBuilder: (context, index) => SizedBox(height: 12),
      ),
    );
  }
}
