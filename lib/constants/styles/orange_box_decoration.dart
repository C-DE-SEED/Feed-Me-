import 'package:flutter/material.dart';
import 'colors.dart';

 BoxDecoration orangeBoxDecoration = BoxDecoration(
  gradient: SweepGradient(
    center: Alignment.bottomLeft,
    colors: [
      Colors.deepOrange[300],
      basicColor,
      Colors.orange,
    ],
  ),
);