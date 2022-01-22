import 'package:feed_me/constants/custom_widgets/dismiss_keyboard_widget.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/model/user_local.dart';
import 'package:feed_me/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return StreamProvider<UserLocal>.value(
      value: AuthService().getUserLocal(),
      initialData: null,
      child: const DismissKeyboard(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('de')],
          home: Welcome(),
        ),
      ),
    );

    // TODO: insert full screen dialog in navigators
    // TODO insert will pop scope in specific screens
    // TODO einkaufsliste

    // TODO insert flutter inapp_purchase at user recipe amount of 30
    // FIXME: Find out why app crashes and fix it
    // TODO: Change login video with own

    // maxi
    // TODO insert person food multiplicator
    // TODO insert userNotes direct on cooking steps page

    // FIXME: favorite view
    // FIXME: add ingredients and spices list view
    // TODO delete/overwrite recipe
    // TODO give possibility to create a recipe without picture
    // TODO improve search function in home screen

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
