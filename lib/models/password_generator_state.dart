final class PasswordGeneratorState {
  final String password;
  final int length;
  final bool canGenerate;
  final bool capitalLetters;
  final bool lowercaseLetters;
  final bool numbers;
  final bool specialCharacters;
  final String message;

  const PasswordGeneratorState({
    required this.password,
    required this.length,
    required this.canGenerate,
    required this.capitalLetters,
    required this.lowercaseLetters,
    required this.numbers,
    required this.specialCharacters,
    required this.message,
  });
}
