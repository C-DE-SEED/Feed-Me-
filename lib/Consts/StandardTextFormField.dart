import 'package:feed_me/Consts/Colors.dart';
import 'package:flutter/material.dart';


class MailTextFormField extends StatefulWidget {
  MailTextFormField({
    @required this.hintText,
    @required this.onChange,
  });

  final String hintText;
  final Function onChange;

  @override
  _MailTextFormFieldState createState() => _MailTextFormFieldState();
}

class _MailTextFormFieldState extends State<MailTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.fromLTRB(20,0,20,0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email_outlined,color: BasicGreen,),
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
