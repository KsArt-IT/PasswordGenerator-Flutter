enum PasswordGeneratorType {
  length,
  generate,
  capitalLetters,
  lowercaseLetters,
  numbers,
  specialCharacters,
  copy,
  clearMessage,
}

sealed class PasswordGeneratorAction {
  const PasswordGeneratorAction();

  factory PasswordGeneratorAction.of(PasswordGeneratorType actionType, [int value = 0]) {
    switch (actionType) {
      case PasswordGeneratorType.length:
        return LengthAction(value);
      case PasswordGeneratorType.generate:
        return GenerateAction();
      case PasswordGeneratorType.capitalLetters:
        return CapitalLettersAction();
      case PasswordGeneratorType.lowercaseLetters:
        return LowercaseLettersAction();
      case PasswordGeneratorType.numbers:
        return NumbersAction();
      case PasswordGeneratorType.specialCharacters:
        return SpecialCharactersAction();
      case PasswordGeneratorType.copy:
        return CopyAction();
      case PasswordGeneratorType.clearMessage:
        return ClearMessageAction();
    }
  }
}

final class LengthAction extends PasswordGeneratorAction {
  final int value;

  LengthAction(this.value);
}

final class GenerateAction extends PasswordGeneratorAction {}

final class CopyAction extends PasswordGeneratorAction {}

final class ClearMessageAction extends PasswordGeneratorAction {}

final class CapitalLettersAction extends PasswordGeneratorAction {}

final class LowercaseLettersAction extends PasswordGeneratorAction {}

final class NumbersAction extends PasswordGeneratorAction {}

final class SpecialCharactersAction extends PasswordGeneratorAction {}

/*
// in Swift this whole code looks simpler
enum PasswordGeneratorType {
  case length(Int)
  case generate
  case capitalLetters
  case lowercaseLetters
  case numbers
  case specialCharacters
  case copy
  case clearMessage
}
// use it like this
vm.action(.length(10))
*/