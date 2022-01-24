import 'package:feed_me/model/recipe_object.dart';

class SearchService {

  final List<Recipe> recipes;

  SearchService({this.recipes});

  List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(getRecipesNames(recipes));
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  List<String> getRecipesNames(List<Recipe> recipes){
    List<String> recipeNames = [];
    recipes.forEach((recipe) {
      recipeNames.add(recipe.name);
    });
    return recipeNames;
  }
}
