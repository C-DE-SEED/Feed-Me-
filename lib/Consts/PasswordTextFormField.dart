import 'package:feed_me/Consts/Colors.dart';
import 'package:flutter/material.dart';


class PasswordTextFormField extends StatefulWidget {
  PasswordTextFormField({
    @required this.hintText,
    @required this.onChange,
  });

  final String hintText;
  final Function onChange;

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20,0,20,0),
      color: Colors.transparent,
      child: TextFormField(
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock,color: BasicGreen,),
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          contentPadding: EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: BasicGreen, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
        onChanged: widget.onChange,
      ),
    );
  }
}
