
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/services/search_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TextfieldWithSuggestion extends StatelessWidget {
  List<Recipe> recipes;
  TextfieldWithSuggestion({Key key, this.recipes}) : super(key: key);
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: const InputDecoration(
                  hintText: 'Nach Rezept suchen',
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
                  return SearchService(recipes: recipes).getSuggestions(pattern);
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
//
