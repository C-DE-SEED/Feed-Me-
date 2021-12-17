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
            padding: EdgeInsets.all(16),
            child:

            TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(labelText: 'State'),
                  controller: this._typeAheadController,
                ),
                suggestionsCallback: (pattern) async {
                  return await IngredientsService.getSuggestions(pattern);
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
                  this._typeAheadController.text = suggestion;
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

  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
