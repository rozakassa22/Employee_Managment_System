import 'package:flutter/material.dart';
import '../theme/theme_index.dart';
import 'components_index.dart';
// sign up button
// ignore: non_constant_identifier_names
Widget SignUpContainer({required String st}) {
  return Container(
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
      color: AppColors.kBlueColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: customText(
          txt: st,
          style: const TextStyle(
            color: AppColors.kwhiteColor,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          )),
    ),
  );
}