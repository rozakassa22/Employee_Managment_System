import 'package:flutter/material.dart';
// inkwell buttons pic
// ignore: non_constant_identifier_names
Widget InkwellButtons({
  required Image image,
}) {
  return Expanded(
    child: SizedBox(
      width: 170,
      height: 60,
      child: image,
    ),
  );
}