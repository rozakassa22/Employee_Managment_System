// custom text widget
import 'package:flutter/material.dart';
import '../theme/theme_index.dart';

Widget customText({required String txt, required TextStyle style}) {
  return Text(
    txt,
    style: style,
  );
}

// rich text
// ignore: non_constant_identifier_names
TextSpan RichTextSpan({required String one, required String two}) {
  return TextSpan(children: [
    TextSpan(
        text: one,
        style: const TextStyle(fontSize: 13, color: AppColors.kBlackColor)),
    TextSpan(
        text: two,
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.kBlueColor,
        )),
  ]);
}

// TextField
// ignore: non_constant_identifier_names
Widget CustomTextField(
    {required String labelText,
    required String hintText,
    required TextEditingController controller,
    required validator}) {
  return TextFormField(
    obscureText: true,
    controller: controller,
    decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          width: 5,
          color: AppColors.kDarkblack,
          style: BorderStyle.solid,
        ))),
    validator: validator,
    autofocus: true,
    keyboardType: TextInputType.multiline,
  );
}

// ignore: non_constant_identifier_names
Widget CustomEmailField(
    {required String labelText,
    required String hintText,
    required TextEditingController controller,
    required validator}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          width: 5,
          color: AppColors.kDarkblack,
          style: BorderStyle.solid,
        ))),
    validator: validator,
    autofocus: true,
    keyboardType: TextInputType.multiline,
  );
}
