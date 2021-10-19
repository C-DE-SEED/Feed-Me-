import 'package:feed_me/Consts/Colors.dart';
import 'package:feed_me/Consts/PasswordTextFormField.dart';
import 'package:feed_me/Consts/StandardButton.dart';
import 'package:feed_me/Consts/StandardTextFormField.dart';
import 'package:flutter/material.dart';
import '../RegistrationAndLogin/AuthService.dart';
import '../RegistrationAndLogin/Loading.dart';
import 'SignIn.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
      // backgroundColor: Colors.brown[100],
      // appBar: AppBar(
      //   backgroundColor: Colors.brown[400],
      //   elevation: 0.0,
      //   title: Text("Register"),
      //   actions: [
      //     TextButton.icon(
      //         onPressed: () {
      //           widget.toggleView();
      //         },
      //         icon: Icon(Icons.person),
      //         label: Text("Sign In"))
      //   ],
      // ),
      // body: Container(
      //     padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      //     child: Form(
      //       key: _formKey,
      //       child: Column(
      //         children: [
      //           SizedBox(
      //             height: 20,
      //           ),
      //           TextFormField(
      //             validator: (val) =>
      //             val.isEmpty ? "Enter an Email" : null,
      //             onChanged: (value) {
      //               setState(() {
      //                 email = value;
      //               });
      //             },
      //           ),
      //           SizedBox(
      //             height: 20,
      //           ),
      //           TextFormField(
      //             validator: (val) =>
      //             val.length < 6 ? "More than 6 chars please" : null,
      //             obscureText: true,
      //             onChanged: (value) {
      //               setState(() {
      //                 password = value;
      //               });
      //             },
      //           ),
      //           SizedBox(
      //             height: 20,
      //           ),
      //           TextButton(
      //               onPressed: () async {
      //                 if (_formKey.currentState.validate()) {
      //                   setState(() {
      //                     loading = true;
      //                   });
      //                   dynamic result =
      //                   await _auth.registerWithEmailAndPassword(
      //                       email, password);
      //                   if (result == null) {
      //                     setState(() {
      //                       error = "Please supply a valid email";
      //                       loading = false;
      //                     });
      //                   }
      //                 }
      //               },
      //               child: Text("Register")),
      //           SizedBox(
      //             height: 20,
      //           ),
      //           Text(
      //             error,
      //             style: TextStyle(color: Colors.red),
      //           )
      //         ],
      //       ),
      //     )),

        backgroundColor: Colors.white,
        body: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.4,
                    width: size.width * 1,
                    color: BasicGreen,
                    child:
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: size.height*0.3,
                          width: size.width*0.4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/feedmelogo.png"),
                                fit: BoxFit.cover,
                              ),
                              color: BasicGreen
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height*0.15,
                  ),
                  MailTextFormField(
                    hintText: "Bitte geben Sie Ihre E-Mail ein",
                    onChange: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PasswordTextFormField(
                    hintText: "Bitte geben Sie Ihr Passwort ein",
                    onChange: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  StandardButton(
                    color: Colors.white,
                    text: "Registrieren",
                    onPress: ()async{
                      // dynamic result = await _auth
                      //     .loginWithEmailAndPassword(email, password);
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth
                            .loginWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = "Please supply a valid email";
                            loading = false;
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  StandardButton(
                      color: BasicGreen,
                      text: "Zurück zum Login", onPress: (){
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SignIn()));
                    Navigator.pop(context);
                  })
                ],
              ),
            ))
    );
  }
}
