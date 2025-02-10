import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/domain/user.dart';
import 'package:proyecto_flutter/core/presentation/theme/style_constants.dart';
import 'package:proyecto_flutter/login/presentation/view_model/user_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:proyecto_flutter/util/validator.dart';

/// Pantalla para crear una nueva cuenta de usuario.
///
/// Es stateful por que hacer un viewmodel solo para un texto de error me parece demasiado.
class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _repeatPasswordController = TextEditingController();

  String? _usernameErrorMessage;
  bool _isObscurePassword = true;
  bool _isObscureRepeatPasswd = true;

  Future<void> _register(BuildContext context) async {
    if (widget._formKey.currentState!.validate()) {
      final user = User(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (await context.read<UserViewModel>().register(user) &&
          context.mounted) {
        context.pushNamed("films");
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.registerError),
          ),
        );
      }
    }
  }

  Future<void> _onUserNameChange(BuildContext context, String value) async {
    if (await context.read<UserViewModel>().existUserName(value)) {
      if (_usernameErrorMessage == null) {
        setState(() {
          _usernameErrorMessage = AppLocalizations.of(context)!.usernameExists;
        });
      }
    } else {
      if (_usernameErrorMessage != null) {
        setState(() {
          _usernameErrorMessage = null;
        });
      }
    }
  }

  String? _validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return AppLocalizations.of(context)!.insertUsername;
    }
    return null;
  }

  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AppLocalizations.of(context)!.insertEmail;
    } else if (!isValidEmail(email)) {
      return AppLocalizations.of(context)!.invalidEmail;
    }
    return null;
  }

  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppLocalizations.of(context)!.insertPassword;
    } else if (password.length < 8) {
      return AppLocalizations.of(context)!.shortPassword;
    }
    return null;
  }

  String? _validateRepeatPassword(String? repeatPsswd) {
    if (repeatPsswd == null || repeatPsswd.isEmpty) {
      return AppLocalizations.of(context)!.insertRepeatPassword;
    } else if (_passwordController.text != _repeatPasswordController.text) {
      return AppLocalizations.of(context)!.passwordsDontMatch;
    }
    return null;
  }

  List<Widget> _fields(BuildContext context) {
    return [
      Text(
        AppLocalizations.of(context)!.register,
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
      TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.username,
          label: Text(AppLocalizations.of(context)!.username),
          border: const OutlineInputBorder(),
          errorText: _usernameErrorMessage,
        ),
        onChanged: (value) => _onUserNameChange(context, value),
        validator: _validateUsername,
      ),
      TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.email,
          label: Text(AppLocalizations.of(context)!.email),
          border: const OutlineInputBorder(),
        ),
        validator: _validateEmail,
      ),
      TextFormField(
        controller: _passwordController,
        obscureText: _isObscurePassword,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.password,
          label: Text(AppLocalizations.of(context)!.password),
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscurePassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isObscurePassword = !_isObscurePassword;
              });
            },
          ),
        ),
        validator: _validatePassword,
      ),
      TextFormField(
        controller: _repeatPasswordController,
        obscureText: _isObscureRepeatPasswd,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.repeatPassword,
          label: Text(AppLocalizations.of(context)!.repeatPassword),
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscureRepeatPasswd ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isObscureRepeatPasswd = !_isObscureRepeatPasswd;
              });
            },
          ),
        ),
        validator: _validateRepeatPassword,
      ),
      FilledButton(
        onPressed: () => _register(context),
        child: Text(AppLocalizations.of(context)!.register),
      ),
      OutlinedButton(
        onPressed: () => context.pushNamed("login"),
        child: Text(AppLocalizations.of(context)!.login),
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
          maxHeight: 500
        ),
        child: Form(
          key: widget._formKey,
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
