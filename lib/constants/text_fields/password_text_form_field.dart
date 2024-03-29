import 'package:feed_me/constants/styles/text_style.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({Key key, this.hintText, this.onChange})
      : super(key: key);

  final String hintText;
  final Function onChange;

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      color: Colors.transparent,
      child: TextFormField(
        obscureText: showPassword,
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: openSansFontFamily,
          color:Colors.black,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,

        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            icon: showPassword
                ? const Icon(
              Icons.visibility_off_outlined,
              color: basicColor,
            )
                : const Icon(Icons.visibility_outlined,
                color: basicColor),
          ),
          prefixIcon: const Icon(
            Icons.lock,
            color: basicColor,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          contentPadding:
              const EdgeInsets.fromLTRB(10.0,10.0,10.0,10.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: basicColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
        onChanged: widget.onChange,
      ),
    );
  }
}
