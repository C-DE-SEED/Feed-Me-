import 'package:feed_me/constants/styles/text_style.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class SearchTextFormField extends StatefulWidget {
  const SearchTextFormField({Key key, this.hintText, this.onChange})
      : super(key: key);

  final String hintText;
  final Function onChange;

  @override
  _SearchTextFormFieldState createState() => _SearchTextFormFieldState();
}

class _SearchTextFormFieldState extends State<SearchTextFormField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      width: size.width * 0.65,
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: openSansFontFamily,
          color: Colors.grey,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: basicColor,
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
            borderSide: BorderSide(color: basicColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
        onChanged: widget.onChange,
      ),
    );
  }
}
