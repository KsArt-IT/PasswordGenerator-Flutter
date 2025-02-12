import 'package:flutter/material.dart';
import 'package:password_generator/app.dart';
import 'package:password_generator/ui/screens/generator/password_generator_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PasswordGeneratorViewModel()),
      ],
      child: const PasswordGeneratorApp(),
    ),
  );
}
