class MainPageText {
  static const String forecast = 'forecast';
}

extension Capitalized on String {
  String get capitalize => this[0].toUpperCase() + substring(1);
}
