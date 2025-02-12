import 'package:flutter/material.dart';
import 'package:password_generator/ui/screens/generator/password_generator_viewmodel.dart';
import 'package:password_generator/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'ui/screens/generator/password_generator_screen.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
    
class PasswordGeneratorApp extends StatelessWidget {
  const PasswordGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PasswordGeneratorViewModel>(context);

    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: PasswordGeneratorScreen(viewModel: viewModel),
    );
  }
}
