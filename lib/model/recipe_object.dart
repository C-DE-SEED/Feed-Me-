class Recipe {
  String id;
  String category;
  String description;
  String difficulty;
  String image;
  String ingredientsAndAmount;
  String kitchenStuff;
  String name;
  String origin;
  String persons;
  String shortDescription;
  String spices;
  String time;

  Recipe();

  Recipe.withAttributes(
      this.id,
      this.category,
      this.description,
      this.difficulty,
      this.image,
      this.ingredientsAndAmount,
      this.kitchenStuff,
      this.name,
      this.origin,
      this.persons,
      this.shortDescription,
      this.spices,
      this.time);

  @override
  String toString() {
    return 'Recipe{id: $id, category: $category, description: $description, difficulty: $difficulty, image: $image, ingredientsAndAmount: $ingredientsAndAmount, kitchenStuff: $kitchenStuff, name: $name, origin: $origin, persons: $persons, shortDescription: $shortDescription, spices: $spices, time: $time}';
  }
}
