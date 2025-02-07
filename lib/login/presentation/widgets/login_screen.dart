import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/login/presentation/view_model/user_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () {
          Provider.of<UserViewModel>(context, listen: false).login("", "");
          context.pushNamed("films");
        },
        child: Text("Login"),
      ),
    );
  }
}
