import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/domain/user.dart';
import 'package:proyecto_flutter/core/presentation/theme/style_constants.dart';
import 'package:proyecto_flutter/login/presentation/view_model/user_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  _login(BuildContext context) async {
    final userVM = context.read<UserViewModel>();
    final hashedPassword = User.hashPassword(_passwordController.text);
    final isAuthenticated = await userVM.login(
      _usernameController.text,
      hashedPassword,
    );
    if (isAuthenticated && context.mounted) {
      context.pushNamed("films");
    } else if (context.mounted) {
      // todo: cambiar localización.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.creatingFilmError),
        ),
      );
    }
  }

  List<Widget> _fields(BuildContext context) {
    return [
      Text(
        AppLocalizations.of(context)!.login,
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
      TextFormField(
        // Todo: cambiar localizaciones.
        controller: _usernameController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.username,
          label: Text(AppLocalizations.of(context)!.username),
          border: const OutlineInputBorder(),
        ),
      ),
      TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.password,
          label: Text(AppLocalizations.of(context)!.password),
          border: const OutlineInputBorder(),
        ),
      ),
      FilledButton(
        onPressed: () => _login(context),
        child: Text(AppLocalizations.of(context)!.login),
      ),
      OutlinedButton(
        onPressed: () => context.pushNamed("register"),
        child: Text(AppLocalizations.of(context)!.register),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(compactMargin),
        constraints: const BoxConstraints(
          maxWidth: 400,
          maxHeight: 400,
        ),
        child: Form(
          child: ListView.separated(
            itemCount: _fields(context).length,
            itemBuilder: (context, index) => _fields(context)[index],
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 8,
            ),
          ),
        ),
      ),
    );
  }
}
