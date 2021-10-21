import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';

import 'Colors.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({Key key, this.hintText, this.onChange})
      : super(key: key);

  final String hintText;
  final Function onChange;

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      color: Colors.transparent,
      child: TextFormField(
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: openSansFontFamily,
          color: Colors.grey,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,

        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.lock,
            color: BasicGreen,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: BasicGreen, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
        onChanged: widget.onChange,
      ),
    );
  }
}
