import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TextfieldWithSuggestion extends StatelessWidget {
  TextfieldWithSuggestion({Key key}) : super(key: key);
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: const InputDecoration(
                  hintText: 'Zutat eingeben',
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.white)),
                ),
                  controller: _typeAheadController,
                ),
                suggestionsCallback: (pattern) {
                  return IngredientsService.getSuggestions(pattern);
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  _typeAheadController.text = suggestion;
                })
        ),
      ),
    );
  }
}

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

  static List<String> getSuggestions(String pattern) {
    List<String> matches = [];
    matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(pattern.toLowerCase()));
    return matches;
  }
}
