import 'package:flutter/material.dart';

class AppColors {
  // Brand colors
  static const primary = Color(0xff4CAF50); // Fresh green
  static const secondary = Color(0xffFF7043); // Modern coral accent
  static const accent = Color(0xff2979FF); // Vibrant blue for highlights

  // Backgrounds
  static const lightBackground = Color(0xffF9F9F9);
  static const darkBackground = Color(0xff121212);

  // Neutrals
  static const grey = Color(0xffB0BEC5);
  static const darkGrey = Color(0xff455A64);

  // Text colors
  static const textPrimaryLight = Color(0xff212121);
  static const textSecondaryLight = Color(0xff757575);
  static const textPrimaryDark = Color(0xffE0E0E0);
  static const textSecondaryDark = Color(0xff9E9E9E);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xff4CAF50), Color(0xff66BB6A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xffFF7043), Color(0xffFF8A65)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
