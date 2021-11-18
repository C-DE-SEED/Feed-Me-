class Recipe {
  final String id;
  final String category;
  final String description;
  final String difficulty;
  final String image;
  final String ingredientsAndAmount;
  final String kitchenStuff;
  final String name;
  final String origin;
  final String persons;
  final String shortDescription;
  final String spices;
  final String time;

  Recipe(
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

  // static List<Recipt> starters = [];
  // static List<Recipt> main = [];
  // static List<Recipt> dessert = [];
  // static List<Recipt> fast = [];
  //
  // static void setStartersRecipts(List<Recipt> recipts) {
  //   recipts.forEach((element) {
  //     if (element.category == "starter") {
  //       starters.add(element);
  //     }
  //   });
  // }
  //
  // static void setMainRecipts(List<Recipt> recipts) {
  //   recipts.forEach((element) {
  //     if (element.category == "Hauptgericht") {
  //       print("was here");
  //       main.add(element);
  //       print(main);
  //     }
  //   });
  // }
  //
  // static void setDessertRecipts(List<Recipt> recipts) {
  //   recipts.forEach((element) {
  //     if (element.category == "dessert") {
  //       dessert.add(element);
  //     }
  //   });
  // }
  //
  // static void setFastRecipts(List<Recipt> recipts) {
  //   recipts.forEach((element) {
  //     if (element.category == "fast") {
  //       fast.add(element);
  //     }
  //   });
  // }
}
