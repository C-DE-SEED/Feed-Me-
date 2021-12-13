import 'package:feed_me/constants/custom_widgets/dismiss_keyboard_widget.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/screens/registration_and_login/sign_in.dart';
import 'package:feed_me/model/user_local.dart';
import 'package:feed_me/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
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
          localizationsDelegates: [   GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,],
          supportedLocales: [Locale('de')],
          home: Welcome(),
        ),
      ),
    );
// TODO insert UserObject with additional data (use Firebase User object as
//  root)
    // TODO show dish of the day instead of feed me logo
    // TODO: Decription from user
    // TODO: insert chilis as spice integrator
    //TODO: Radien anpassen
    //TODO: buttonRow anpassen (Höhe)
    //TODO: insert full screen dialog in navigators
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
