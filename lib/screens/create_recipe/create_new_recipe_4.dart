import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/constants/custom_widgets/button_row.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/custom_widgets/show_steps_widget.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/favs_and_shopping_list_db.dart';
import 'package:feed_me/model/recipe_db_object.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../home.dart';

class CreateNewRecipe_4 extends StatefulWidget {
  const CreateNewRecipe_4(
      {Key key, @required this.recipe, @required this.cookbook})
      : super(key: key);
  final Recipe recipe;
  final Cookbook cookbook;

  @override
  _CreateNewRecipe_4State createState() => _CreateNewRecipe_4State();
}

class _CreateNewRecipe_4State extends State<CreateNewRecipe_4> {
  AuthService auth = AuthService();
  int counter = 1;
  List<String> steps = [""];
  List<TextEditingController> controller = [];
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: basicColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.9,
                  child: Column(
                    children: [
                      const Center(
                          child: Text(
                              '4. Schritt: Wie bereitet man das Rezept zu?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSize,
                                  fontFamily: openSansFontFamily))),
                      SizedBox(height: size.height * 0.01),
                      Hero(
                        tag: 'steps',
                        child: ShowSteps(colors: step4),
                      ),
                      SizedBox(height: size.height * 0.01),
                      AnimatedList(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        key: listKey,
                        initialItemCount: steps.length,
                        itemBuilder: (context, index, anim) {
                          return SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(1, 0), end: Offset.zero)
                                .animate(anim),
                            child: ListTile(
                              title: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15)),
                                height: size.height * 0.1,
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: size.width * 0.2,
                                        child: Text(
                                            (index + 1).toString() +
                                                ". Schritt",
                                            style: const TextStyle(
                                                color: deepOrange,
                                                fontSize: fontSize,
                                                fontFamily:
                                                    openSansFontFamily))),
                                    SizedBox(
                                      width: size.width * 0.6,
                                      child: TextFormField(
                                        obscureText: false,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize,
                                        ),
                                        decoration: const InputDecoration(
                                          hintText: 'Beschreibung',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: fontSize),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            steps[index] = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  steps.remove(steps.elementAt(index));
                                  listKey.currentState.removeItem(
                                    index,
                                    (context, animation) {
                                      return SizeTransition(
                                        sizeFactor: animation,
                                        axis: Axis.vertical,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(
                                              width: 1,
                                              style: BorderStyle.solid,
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(40)),
                                          ),
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 0.0, 0.0),
                                        ),
                                      );
                                    },
                                  );
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.01),
                      addNewStep(size),
                      const Spacer(),
                      Hero(
                        tag: 'buttonRow',
                        child: ButtonRow(
                          onPressed: () async {
                            var userCookbooks = await getUpdates() ;
                            if (steps.elementAt(0) == '') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return RoundedAlert(
                                    title: "❗️Achtung❗",
                                    text:
                                        "Gib bitte die Bearbeitungsschritte an ☺️",
                                  );
                                },
                              );
                            } else {
                              widget.recipe.description = buildDescription();
                              addToDatabase();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home(userCookbooks: userCookbooks)));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void insertItem(int index, String item) {
    steps.insert(index, item);
    listKey.currentState.insertItem(index);
  }

  String buildDescription() {
    String description = '';
    steps.forEach((element) {
      description = description + element;
      description = description + '/';
    });
    return description.substring(0, description.length - 1);
  }

  Widget addNewStep(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height * 0.05,
          width: size.width * 0.65,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: deepOrange),
              borderRadius: BorderRadius.circular(15)),
          child: TextButton(
              onPressed: () {
                setState(() {
                  insertItem(steps.length, counter.toString());
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, color: deepOrange),
                  Text("Weiteren Schritt hinzufügen",
                      style: TextStyle(
                          color: deepOrange,
                          fontSize: fontSize,
                          fontFamily: openSansFontFamily)),
                ],
              )),
        ),
        SizedBox(
          width: size.width * 0.15,
        )
      ],
    );
  }

  void addToDatabase() async {
    print('add to database is called');
    RecipeDbObject dbObject = RecipeDbObject();
    bool exist = await dbObject.checkIfDocumentExists(widget.cookbook.name);
    print('bool exist: $exist');
    print('widget.cookbook.name:');
    print(widget.cookbook.name);
    if (exist == true) {
      String imagePath =
          await dbObject.getCookBookAttributes(widget.cookbook.name);
      print('imagePath: $imagePath');

      await RecipeDbObject().updateRecipe(
          "1",
          widget.recipe.category,
          widget.recipe.description,
          widget.recipe.difficulty,
          widget.recipe.image,
          widget.recipe.ingredientsAndAmount,
          widget.recipe.name,
          widget.recipe.origin,
          widget.recipe.persons,
          widget.recipe.shortDescription,
          widget.recipe.time,
          widget.recipe.userNotes,
          widget.cookbook.name,
          imagePath);
    } else {
      await RecipeDbObject().updateRecipe(
          "1",
          widget.recipe.category,
          widget.recipe.description,
          widget.recipe.difficulty,
          widget.recipe.image,
          widget.recipe.ingredientsAndAmount,
          widget.recipe.name,
          widget.recipe.origin,
          widget.recipe.persons,
          widget.recipe.shortDescription,
          widget.recipe.time,
          widget.recipe.userNotes,
          widget.cookbook.name,
          widget.recipe.image);
    }
  }
  Future<List<Cookbook>> getUpdates() async {
    RecipeDbObject recipeDbObject = RecipeDbObject();
    FavsAndShoppingListDbHelper favsAndShoppingListDbHelper =
    FavsAndShoppingListDbHelper();

    List<Cookbook> tempCookbooks = [];
    List<Recipe> favs = [];
    favs = await favsAndShoppingListDbHelper
        .getRecipesFromUsersFavsCollection()
        .first;
    List<Cookbook> cookbooksUpdate =
    await await recipeDbObject.getAllCookBooksFromUser();

    cookbooksUpdate.removeWhere((element) =>
    element.image == 'none' || element.image == 'shoppingList');
    // FIXME check in database why this additional cookbook is inserted
    // remove additional Plant Food Factory Cookbook
    cookbooksUpdate
        .removeWhere((element) => element.name == 'Plant Food Factory');
    cookbooksUpdate
        .removeWhere((element) => element.name == 'plant_food_factory');

    tempCookbooks.addAll(cookbooksUpdate);
    cookbooksUpdate.clear();

    cookbooksUpdate.add(Cookbook('', 'users favorites', favs));
    cookbooksUpdate.addAll(tempCookbooks);
    cookbooksUpdate.add(Cookbook('', 'add', []));

    //setState is needed here. If we give back the recipes object directly the books will not appear instantly
    setState(() {});
    return cookbooksUpdate;
  }
}
