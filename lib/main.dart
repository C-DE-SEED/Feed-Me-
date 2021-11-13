
import 'package:feed_me/home_page/screens/recipe_page.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/registration_and_login/user_local.dart';
import 'package:feed_me/screens/recipt_overview.dart';
import 'package:feed_me/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/choose_cookbook.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
// TODO insert UserObject with additional data (use Firebase User object as
//  root)
  // TODO insert google login
  // TODO NOT FAST - show loading animation as soon as profile picture is
  //  loading
  // TODO insert toolbar in home() screen
  // TODO show dish of the day instead of feed me logo
  // FIXME CHANGE HOME PAGE!
  //


  // List<Recipt> plant_food_factory = [];
  //
  // void getAllRecipes() async {
  //   plant_food_factory =
  //   await ReciptDbObject().getReciptObject("plant_food_factory").elementAt(0);
  // }
  //
  // @override
  // void initState() {
  //   getAllRecipes();
  //   super.initState();
  //
  // }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocal>.value(
      value: AuthService().getUserLocal(),
      initialData: null,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [Locale('en'), Locale('de')],
        home: ChooseCookbook(),
      ),
    );
    // return StreamProvider<UserLocal>.value(
    //   value: AuthService().user,
    //   initialData: null,
    //   child: MaterialApp(
    //     localizationsDelegates: [
    //       GlobalMaterialLocalizations.delegate
    //     ],
    //     supportedLocales: [
    //       const Locale('en'),
    //       const Locale('de')
    //     ],
    //     home: SignIn(),
    //   ),
    // );

    /*
     ----------------------------------------------
    |             _____             _____          |
    |     ___-----     -----   -----     -----___  |
    |    '___               '''               ___' |
    |         -----_____----, ,-----_____-----	   |
    |  							    	 ' '  									 |
    |  						   	   ' '											 |
    |                   ' '                        |
    |                  ' '                         |
    |                 ' '                          |
    |      / ____|  / __ \   |  __ \  |  ____|     |
    |     | |      | |  | |  | |  | | | |__        |
    |     | |      | |  | |  | |  | | |  __|       |
    |     | |____  | |__| |  | |__| | | |____      |
    |      \_____|  \____/   |_____/  |______|     |
    |  																			       |
    | 	   / ____| |  ____|  |  ____| |  __ \	     |
    |     | (___   | |__     | |__    | |  | |	   |
    |      \___ \  |  __|    |  __|   | |  | |     |
    |      ____) | | |____   | |____  | |__| |	   |
    |     |_____/  |______|  |______| |_____/ 	   |
    |  																			       |
     ----------------------------------------------
    */
  }
}
