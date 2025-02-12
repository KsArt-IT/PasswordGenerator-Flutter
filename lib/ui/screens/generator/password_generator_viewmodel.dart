import 'dart:math';

import 'package:flutter/material.dart';
import 'package:password_generator/models/constants.dart';
import 'package:password_generator/models/password_generator_action.dart';
import 'package:password_generator/models/password_generator_state.dart';

class PasswordGeneratorViewModel extends ChangeNotifier {
  PasswordGeneratorViewModel();

  PasswordGeneratorState get state => PasswordGeneratorState(
        password: _password,
        length: _length,
        canGenerate: _canGenerate,
        capitalLetters: _capitalLetters,
        lowercaseLetters: _lowercaseLetters,
        numbers: _numbers,
        specialCharacters: _specialCharacters,
        message: _message,
      );

  String _password = '';
  int _length = Constants.minLength.toInt();

  bool get _canGenerate => _capitalLetters || _lowercaseLetters || _numbers || _specialCharacters;
  bool _capitalLetters = false;
  bool _lowercaseLetters = false;
  bool _numbers = false;
  bool _specialCharacters = false;

  String _message = '';

  void action(PasswordGeneratorAction action) {
    _action(action).then((_) {
      notifyListeners();
    });
  }

  Future<void> _action(PasswordGeneratorAction action) async {
    switch (action) {
      case GenerateAction():
        _generatePassword();
      case CopyAction():
        _copyPassword();
      case ClearMessageAction():
        _showMessage('');
      case LengthAction(value: int value):
        _setLength(value);
      case CapitalLettersAction():
        _toggleCapitalLetters();
      case LowercaseLettersAction():
        _toggleLowercaseLetters();
      case NumbersAction():
        _toggleNumbers();
      case SpecialCharactersAction():
        _toggleSpecialCharacters();
    }
  }

  void _generatePassword() {
    String? password = _generatePasswordWithLength(_length);
    if (password != null) {
      _password = password;
    } else {
      _password = '';
      _showMessage('Error generating password!');
    }
  }

  String? _generatePasswordWithLength(int length) {
    if (!_canGenerate) return null;
    final chars = _getChars();
    final random = Random.secure();
    List<String> list = [];
    int i = 10;
    do {
      list = List.generate(length, (index) => chars[random.nextInt(chars.length)]);
      i--;
    } while (i > 0 && !_isAllSymbolsUsed(list));
    return list.join();
  }

  bool _isAllSymbolsUsed(List<String> list) {
    final countCategories = _getCountOfCategories();

    if (countCategories > list.length) {
      return true;
    }

    Set<int> foundCategories = {};

    for (final char in list) {
      final category = _getCategoryByChar(char);
      if (category < 0) {
        return false;
      }
      foundCategories.add(category);

      if (foundCategories.length == countCategories) {
        return true;
      }
    }

    return false;
  }

  int _getCountOfCategories() {
    return [
      _capitalLetters,
      _lowercaseLetters,
      _numbers,
      _specialCharacters
    ].where((element) => element).length;
  }

  int _getCategoryByChar(String char) {
    if (Constants.capitalLetters.contains(char)) {
      return 0;
    } else if (Constants.lowercaseLetters.contains(char)) {
      return 1;
    } else if (Constants.numbers.contains(char)) {
      return 2;
    } else if (Constants.specialCharacters.contains(char)) {
      return 3;
    }
    return -1;
  }

  String _getChars() {
    String chars = '';
    if (_capitalLetters) chars += Constants.capitalLetters;
    if (_lowercaseLetters) chars += Constants.lowercaseLetters;
    if (_numbers) chars += Constants.numbers;
    if (_specialCharacters) chars += Constants.specialCharacters;
    return chars;
  }

  void _copyPassword() {
    _showMessage('Password copied to clipboard!');
  }

  void _clearPassword() {
    _password = '';
  }

  void _setLength(int value) {
    _length = value;
    _clearPassword();
  }

  void _toggleCapitalLetters() {
    _capitalLetters = !_capitalLetters;
    _checkAndShowCantGenerate();
  }

  void _toggleLowercaseLetters() {
    _lowercaseLetters = !_lowercaseLetters;
    _checkAndShowCantGenerate();
  }

  void _toggleNumbers() {
    _numbers = !_numbers;
    _checkAndShowCantGenerate();
  }

  void _toggleSpecialCharacters() {
    _specialCharacters = !_specialCharacters;
    _checkAndShowCantGenerate();
  }

  void _checkAndShowCantGenerate() {
    if (_canGenerate) {
      return;
    }
    _password = '';
    _showMessage('Select at least one option!');
  }

  void _showMessage(String message) {
    _message = message;
  }
}
