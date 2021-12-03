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
}
