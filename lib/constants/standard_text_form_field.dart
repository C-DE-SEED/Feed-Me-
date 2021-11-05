import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';

import 'Colors.dart';

class StandardTextFormField extends StatefulWidget {
  const StandardTextFormField({Key key, this.hintText, this.onChange})
      : super(key: key);

  final String hintText;
  final Function onChange;

  @override
  _StandardTextFormFieldState createState() => _StandardTextFormFieldState();
}

class _StandardTextFormFieldState extends State<StandardTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: openSansFontFamily,
          color: Colors.black,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail_outlined, color:BasicGreen),
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
