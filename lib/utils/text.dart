class MainPageText {
  static const String loading = 'Loading ...';
}

extension Capitalized on String {
  String get capitalize => this[0].toUpperCase() + substring(1);
}
