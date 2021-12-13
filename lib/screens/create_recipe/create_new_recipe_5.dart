// import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
// import 'package:feed_me/constants/custom_widgets/button_row.dart';
// import 'package:feed_me/constants/styles/colors.dart';
// import 'package:feed_me/constants/custom_widgets/show_steps_widget.dart';
// import 'package:feed_me/constants/styles/text_style.dart';
// import 'package:feed_me/constants/user_options.dart';
// import 'package:feed_me/model/cookbook.dart';
// import 'package:feed_me/model/recipe_db_object.dart';
// import 'package:feed_me/model/recipe_object.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import '../home.dart';
//
// class CreateNewRecipe_5 extends StatefulWidget {
//   const CreateNewRecipe_5(
//       {Key key, @required this.recipe, @required this.cookbook})
//       : super(key: key);
//   final Recipe recipe;
//   final Cookbook cookbook;
//
//   @override
//   _CreateNewRecipe_5State createState() => _CreateNewRecipe_5State();
// }
//
// class _CreateNewRecipe_5State extends State<CreateNewRecipe_5> {
//   String description='';
//   List<String> items = [];
//   bool notSpicy = false;
//   bool mediumSpicy = false;
//   bool spicy = false;
//   String type = "Auswählen";
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.orangeAccent,
//       body: SafeArea(
//         child: Center(
//           child: SizedBox(
//             width: size.width * 0.9,
//             height: size.height * 0.9,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Hero(
//                   tag: 'steps',
//                   child: ShowSteps(colors: step5),
//                 ),
//                 SizedBox(height: size.height * 0.01),
//                 const Center(
//                   child: Text("Beschreibung hinzufügen:",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: fontSize,
//                           fontFamily: openSansFontFamily)),
//                 ),
//                 SizedBox(height: size.height * 0.01),
//                 Container(
//                   height: size.height * 0.2,
//                   width: size.width * 0.8,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.white.withOpacity(0.5)),
//                   child: TextFormField(
//                     textAlign: TextAlign.center,
//                     keyboardType: TextInputType.text,
//                     maxLines: 10,
//                     onChanged: (value) {
//                       description = value;
//                     },
//                     decoration: const InputDecoration.collapsed(
//                       hintText: 'z.B. Dieses Rote Thai Curry ist ...',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.05),
//                 const Center(
//                   child: Text("Art: ",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: fontSize,
//                           fontFamily: openSansFontFamily)),
//                 ),
//                 SizedBox(height: size.height * 0.01),
//                 Container(
//                   width: size.width * 0.3,
//                   decoration: BoxDecoration(
//                       color: Colors.transparent,
//                       border: Border.all(color: deepOrange),
//                       borderRadius: BorderRadius.circular(15)),
//                   child: TextButton(
//                     onPressed: () {
//                       _showOriginPicker(context, size);
//                     },
//                     child: Text(type,
//                         style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: fontSize,
//                             fontFamily: openSansFontFamily)),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.05),
//                 const Center(
//                   child: Text("Schärfegrad:",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: fontSize,
//                           fontFamily: openSansFontFamily)),
//                 ),
//                 SizedBox(height: size.height * 0.01),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     spicyButton(
//                         size,
//                         const Icon(
//                           MdiIcons.chiliMild,
//                           color: Colors.white,
//                         ),
//                         deepOrange,
//                         notSpicy, () {
//                       setState(() {
//                         notSpicy = !notSpicy;
//                         if (notSpicy == true) {
//                           mediumSpicy = false;
//                           spicy = false;
//                           //widget.recipe.difficulty = 'Nicht Scharf';
//                         }
//                       });
//                     }),
//                     const Spacer(),
//                     spicyButton(
//                         size,
//                         const Icon(MdiIcons.chiliMedium, color: Colors.white),
//                         deepOrange,
//                         mediumSpicy, () {
//                       setState(() {
//                         mediumSpicy = !mediumSpicy;
//                         if (mediumSpicy == true) {
//                           notSpicy = false;
//                           spicy = false;
//                           //widget.recipe.difficulty = 'Mittelscharf';
//                         }
//                       });
//                     }),
//                     const Spacer(),
//                     spicyButton(
//                         size,
//                         const Icon(MdiIcons.chiliHot, color: Colors.white),
//                         deepOrange,
//                         spicy, () {
//                       setState(() {
//                         spicy = !spicy;
//                         if (spicy == true) {
//                           mediumSpicy = false;
//                           notSpicy = false;
//                           //widget.recipe.difficulty = 'Scharf';
//                         }
//                       });
//                     }),
//                   ],
//                 ),
//                 const Spacer(),
//                 Hero(
//                   tag: 'buttonRow',
//                   child: ButtonRow(
//                     onPressed: () async {
//                       if (description == '') {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return RoundedAlert(
//                               title: "❗️Achtung❗",
//                               text:
//                                   "Gib bitte eine Beschreibung deines Gerichtes an ☺️",
//                             );
//                           },
//                         );
//                       } else if (type == 'Auswählen') {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return RoundedAlert(
//                               title: "❗️Achtung❗",
//                               text: "Gib die Art deines Gerichtes an ☺️",
//                             );
//                           },
//                         );
//                       } else if (!notSpicy && !mediumSpicy && !spicy) {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return RoundedAlert(
//                               title: "❗️Achtung❗",
//                               text:
//                                   "Gib bitte den Schärfegrad deines Gerichtes an ☺️",
//                             );
//                           },
//                         );
//                       } else {
//                         widget.recipe.origin = type;
//                         //TODO: Add spice level to database model
//                         addToDatabase();
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const Home()));
//                       }
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showOriginPicker(BuildContext ctx, Size size) {
//     showCupertinoModalPopup(
//         context: ctx,
//         builder: (_) => SizedBox(
//               width: size.width,
//               height: 250,
//               child: CupertinoPicker(
//                 backgroundColor: deepOrange,
//                 itemExtent: 30,
//                 scrollController: FixedExtentScrollController(initialItem: 1),
//                 children: originList
//                     .map((item) => Center(
//                           child: Text(item,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                               )),
//                         ))
//                     .toList(),
//                 onSelectedItemChanged: (value) {
//                   setState(() {
//                     type = originList.elementAt(value);
//                     widget.recipe.origin = type;
//                   });
//                 },
//               ),
//             ));
//   }
//
//   Widget spicyButton(
//       Size size, Icon icon, Color color, bool isChosen, Function onPressed) {
//     return Container(
//       width: size.width * 0.25,
//       decoration: BoxDecoration(
//           color: isChosen ? color : Colors.transparent,
//           border: isChosen ? null : Border.all(color: deepOrange),
//           borderRadius: BorderRadius.circular(15)),
//       child: TextButton(
//         onPressed: onPressed,
//         child: Center(child: icon),
//       ),
//     );
//   }
//
//   void addToDatabase() async {
//     RecipeDbObject dbObject = RecipeDbObject();
//     bool exist = await dbObject.checkIfDocumentExists(widget.cookbook.name);
//     if (exist == true) {
//       String imagePath =
//           await dbObject.getCookBookAttributes(widget.cookbook.name);
//
//       await RecipeDbObject().updateRecipe(
//           "1",
//           widget.recipe.category,
//           widget.recipe.description,
//           widget.recipe.difficulty,
//           widget.recipe.image,
//           widget.recipe.ingredientsAndAmount,
//           '',
//           widget.recipe.name,
//           widget.recipe.origin,
//           widget.recipe.persons,
//           widget.recipe.shortDescription,
//           '',
//           widget.recipe.time,
//           widget.cookbook.name,
//           imagePath);
//     } else {
//       await RecipeDbObject().updateRecipe(
//           "1",
//           widget.recipe.category,
//           widget.recipe.description,
//           widget.recipe.difficulty,
//           widget.recipe.image,
//           widget.recipe.ingredientsAndAmount,
//           '',
//           widget.recipe.name,
//           widget.recipe.origin,
//           widget.recipe.persons,
//           widget.recipe.shortDescription,
//           '',
//           widget.recipe.time,
//           widget.cookbook.name,
//           widget.recipe.image);
//     }
//   }
// }
