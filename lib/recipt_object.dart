class Recipt {
  String id;
  String category;
  String description;
  String difficulty;
  String image;
  String ingredientsAndAmount;
  String kitchenUtensils;
  String name;
  String origin;
  String persons;
  String shortDescription;
  String spices;
  String time;

  Recipt();

  Recipt.withAttributes(
      this.id,
      this.category,
      this.description,
      this.difficulty,
      this.image,
      this.ingredientsAndAmount,
      this.kitchenUtensils,
      this.name,
      this.origin,
      this.persons,
      this.shortDescription,
      this.spices,
      this.time);
}

