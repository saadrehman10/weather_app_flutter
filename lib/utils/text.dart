class MainPageText {
  static const String forecast = 'Weather Update';
}

extension Capitalized on String {
  String get capitalize => this[0].toUpperCase() + substring(1);
}
