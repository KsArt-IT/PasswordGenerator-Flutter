import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/app.dart';
import 'package:password_generator/models/constants.dart';
import 'package:password_generator/models/password_generator_action.dart';
import 'package:password_generator/ui/screens/generator/password_generator_viewmodel.dart';
import 'package:password_generator/ui/theme/dimens.dart';

class PasswordGeneratorScreen extends StatelessWidget {
  const PasswordGeneratorScreen({super.key, required this.viewModel});

  final PasswordGeneratorViewModel viewModel;

  final String title = "Password Generator";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: SafeArea(
        child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              if (viewModel.state.message.isNotEmpty) {
                Future.microtask(() {
                  showSnackbar(viewModel.state.message);
                  viewModel.action(PasswordGeneratorAction.of(
                      PasswordGeneratorType.clearMessage));
                });
              }

              return SingleChildScrollView(
                  child: Column(children: <Widget>[
                ClipRect(
                  child: Container(
                    padding: EdgeInsets.all(Dimens.padding),
                    margin: EdgeInsets.all(Dimens.padding),
                    height: Dimens.containerHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: Dimens.border,
                      ),
                      borderRadius: BorderRadius.circular(Dimens.borderRadius),
                    ),
                    child: Center(
                      child: Text(
                        viewModel.state.password,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FilledButton.icon(
                    onPressed: !viewModel.state.canGenerate
                        ? null
                        : () {
                            viewModel.action(PasswordGeneratorAction.of(
                                PasswordGeneratorType.generate));
                          },
                    icon: Icon(Icons.refresh),
                    label: Text("Generate"),
                  ),
                  SizedBox(width: Dimens.paddingVertical),
                  FilledButton.icon(
                    onPressed: viewModel.state.password.isEmpty
                        ? null
                        : () {
                            Clipboard.setData(
                                ClipboardData(text: viewModel.state.password));
                            viewModel.action(PasswordGeneratorAction.of(
                                PasswordGeneratorType.copy));
                          },
                    icon: Icon(Icons.copy),
                    label: Text("Copy"),
                  ),
                ]),
                SizedBox(height: Dimens.paddingVertical),
                Slider(
                  value: viewModel.state.length.toDouble(),
                  label: viewModel.state.length.toString(),
                  min: Constants.minLength.toDouble(),
                  max: Constants.maxLength.toDouble(),
                  divisions: Constants.maxLength - Constants.minLength,
                  onChanged: (double value) {
                    viewModel.action(PasswordGeneratorAction.of(
                        PasswordGeneratorType.length, value.toInt()));
                  },
                ),
                Column(children: <Widget>[
                  CheckboxListTile(
                      title: Text("Capital Letters"),
                      value: viewModel.state.capitalLetters,
                      onChanged: (_) {
                        viewModel.action(PasswordGeneratorAction.of(
                            PasswordGeneratorType.capitalLetters));
                      }),
                  CheckboxListTile(
                      title: Text("Lowercase Letters"),
                      value: viewModel.state.lowercaseLetters,
                      onChanged: (_) {
                        viewModel.action(PasswordGeneratorAction.of(
                            PasswordGeneratorType.lowercaseLetters));
                      }),
                  CheckboxListTile(
                      title: Text("Numbers"),
                      value: viewModel.state.numbers,
                      onChanged: (_) {
                        viewModel.action(PasswordGeneratorAction.of(
                            PasswordGeneratorType.numbers));
                      }),
                  CheckboxListTile(
                      title: Text("Special Characters"),
                      value: viewModel.state.specialCharacters,
                      onChanged: (_) {
                        viewModel.action(PasswordGeneratorAction.of(
                            PasswordGeneratorType.specialCharacters));
                      }),
                ]),
              ]));
            }),
      ),
    );
  }

  void showSnackbar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
