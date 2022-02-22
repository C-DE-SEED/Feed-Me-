import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/text_fields/password_text_form_field.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/text_fields/standard_text_form_field.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/favs_and_shopping_list_db.dart';
import 'package:feed_me/model/recipe_db_object.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/screens/user/set_profile_information.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/services/google_services/google_sign_in_button.dart';
import 'package:feed_me/services/loading.dart';
import 'package:feed_me/screens/registration_and_login/registration.dart';
import 'package:flutter/material.dart';
import '../home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key, this.toggleView, @required this.fromRegistration})
      : super(key: key);

  final Function toggleView;
  final bool fromRegistration;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  bool loading = false;
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? const Loading()
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Container(
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/welcome.gif'),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height * 0.01),
                            SizedBox(
                              height: size.height * 0.4,
                              width: size.width * 1,
                              child: FadeInDown(
                                from: 100,
                                duration: const Duration(milliseconds: 1000),
                                child: Center(
                                    child: Image.asset(
                                  "assets/FeedMeFreigestellt.png",
                                  height: size.height * 1.0,
                                )),
                              ),
                            ),
                            FadeInDown(
                              from: 100,
                              duration: const Duration(milliseconds: 1000),
                              child: StandardTextFormField(
                                hintText: "Bitte geben Sie Ihre E-Mail ein",
                                onChange: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            FadeInDown(
                              from: 100,
                              duration: const Duration(milliseconds: 1000),
                              child: PasswordTextFormField(
                                hintText: "Bitte geben Sie Ihr Passwort ein",
                                onChange: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            FadeInDown(
                              from: 100,
                              duration: const Duration(milliseconds: 1000),
                              child: StandardButton(
                                color: Colors.white,
                                text: "Login",
                                onPressed: () async {
                                  if (widget.fromRegistration) {
                                    await _auth.getUser().reload();
                                    if (_auth.getUser().emailVerified) {
                                      if (isUserInformationComplete()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        dynamic result = await _auth
                                            .loginWithEmailAndPassword(
                                                email, password);
                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return RoundedAlert(
                                                  title: "Achtung",
                                                  text:
                                                      "Deine Eingaben stimmen nicht mit den hinterlegten Daten überein!",
                                                );
                                              },
                                            );
                                          });
                                        } else if (widget.fromRegistration) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SetProfilePage(
                                                        cookBookCount: 0,
                                                        recipeCount: 0,
                                                        fromRegistration: widget
                                                            .fromRegistration,
                                                      )));
                                        } else {
                                          var userCookbooks =
                                              await getUpdates();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Home(
                                                        userCookbooks:
                                                            userCookbooks,
                                                      )));
                                        }
                                      }
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          _auth.getUser().reload();
                                          return RoundedAlert(
                                            title: "❗️Achtung❗",
                                            text:
                                                "Bestätige bitte zuerst deine E-Mail um dich anzumelden ☺️",
                                          );
                                        },
                                      );
                                    }
                                  } else {
                                    if (isUserInformationComplete()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result =
                                          await _auth.loginWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return RoundedAlert(
                                                title: "Achtung",
                                                text:
                                                    "Deine Eingaben stimmen nicht mit den hinterlegten Daten überein!",
                                              );
                                            },
                                          );
                                        });
                                      } else {
                                        var userCookbooks = await getUpdates();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home(
                                                    userCookbooks:
                                                        userCookbooks)));
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                            FadeInUp(
                                from: 50,
                                duration: const Duration(milliseconds: 1000),
                                child: const GoogleSignInButton()),
                            FadeInUp(
                              from: 50,
                              duration: const Duration(milliseconds: 1000),
                              child: StandardButton(
                                  color: Colors.white,
                                  text: "Passwort zurücksetzen",
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return RoundedAlert(
                                          title: "Passwort zurücksetzen?",
                                          text:
                                              "Willst du dein Passwort wirklich zurücksetzten? Es wird dir eine E-Mail zum zurücksetzen gesendet werden. Bitte gebe deineE-Mail Adresse ein.",
                                        );
                                      },
                                    );
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0.0, size.height * 0.06, 0.0, 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Noch nicht registriert?",
                                    style: TextStyle(
                                        fontFamily: openSansFontFamily,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Registration()));
                                    },
                                    child: const Text("Hier klicken",
                                        style: TextStyle(
                                          color: basicColor,
                                          fontFamily: openSansFontFamily,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  bool isUserInformationComplete() {
    if (email.isNotEmpty && password.isNotEmpty) {
      return true;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return RoundedAlert(
            title: "Deine Eingaben sind noch nicht vollständig!",
            text: "Bitte überprüfe deine Eingaben.",
          );
        },
      );

      return false;
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
