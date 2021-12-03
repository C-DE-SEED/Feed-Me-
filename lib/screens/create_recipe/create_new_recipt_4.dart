import 'package:feed_me/constants/custom_widgets/button_row.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/custom_widgets/show_steps_widget.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/recipe_db_object.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/screens/create_recipe/create_new_recipe_5.dart';
import 'package:feed_me/screens/home.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:flutter/material.dart';

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
  List<String> items = ["test"];
  List<TextEditingController> controller = [];
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ShowSteps(
                      colors: step4,
                      step: "4.Schritt: Schritte der Zubereitung"),
                  SizedBox(height: size.height * 0.01),
                  AnimatedList(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    key: listKey,
                    initialItemCount: items.length,
                    itemBuilder: (context, index, anim) {
                      return SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(1, 0), end: Offset.zero)
                            .animate(anim),
                        child: ListTile(
                          title: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20)),
                            height: size.height * 0.1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      width: size.width * 0.1,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.4,
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
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              items.remove(items.elementAt(index));
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
                                        borderRadius: const BorderRadius.all(
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
                  SizedBox(height: size.height * 0.2)
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: ButtonRow(
                  onPressed: () async {


                    await RecipeDbObject().updateRecipe(
                        "1",
                        widget.recipe.category,
                        widget.recipe.description,
                        widget.recipe.difficulty,
                        widget.recipe.image,
                        widget.recipe.ingredientsAndAmount,
                        '',
                        widget.recipe.name,
                        '',
                        widget.recipe.persons,
                        widget.recipe.shortDescription,
                        '',
                        widget.recipe.time,
                        widget.cookbook.name);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  },
                ))
          ],
        ),
      ),
    );
  }

  void insertItem(int index, String item) {
    items.insert(index, item);
    listKey.currentState.insertItem(index);
  }

  Widget addNewStep(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height * 0.05,
          width: size.width * 0.7,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: deepOrange),
              borderRadius: BorderRadius.circular(20)),
          child: TextButton(
              onPressed: () {
                setState(() {
                  insertItem(items.length, counter.toString());
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
}
