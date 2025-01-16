import 'package:flutter/material.dart';

abstract class AbstractScreen {
  String get title;
  IconData get icon;
  List<Widget>? get appBarActions;
  FloatingActionButton? floatingActionButton(BuildContext context);
}