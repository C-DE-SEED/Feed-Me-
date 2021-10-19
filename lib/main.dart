import 'package:feed_me/Screens/SignIn.dart';
import 'package:feed_me/Screens/Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'RegistrationAndLogin/AuthService.dart';
import 'RegistrationAndLogin/UserLocal.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
        return StreamProvider<UserLocal>.value(
          value: AuthService().user,
          initialData: null,
          child: MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate
            ],
            supportedLocales: [
              const Locale('en'),
              const Locale('de')
            ],
            home: Wrapper(),
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
  }
}
