class IngredientsService {
  static final List<String> states = [
    'Apfel',
    'Karotte',
    'Zwiebel',
    'Mehl',
    'Salz',
    'Pfeffer',
    'Zucker',
    'Kokosmilch',
    'Mandelmilch'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
