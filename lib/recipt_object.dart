class Recipt {
  final String id;
  final String category;
  final String description;
  final String difficulty;
  final String image;
  final String ingredients_and_amount;
  final String kitchen_utensils;
  final String name;
  final String origin;
  final String persons;
  final String short_discription;
  final String spices;
  final String time;

  Recipt(
      this.id,
      this.category,
      this.description,
      this.difficulty,
      this.image,
      this.ingredients_and_amount,
      this.kitchen_utensils,
      this.name,
      this.origin,
      this.persons,
      this.short_discription,
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
