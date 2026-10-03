import 'package:material_ui/material_ui.dart';

abstract final class AppColors {
  static const Color black = Color(0xFF0A0A0A);
  static const Color darkGrey = Color(0xFF323232);
  static const Color lightGrey = Color(0xFFC8C8C8);
  static const Color white = Color(0xFFF5F5F5);

  static const Color red = Color(0xFFFF0000);
  static const Color green = Color(0xFF00FF00);
  static const Color blue = Color(0xFF0000FF);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: white,
    onPrimary: red,
    secondary: white,
    onSecondary: green,
    tertiary: white,
    onTertiary: blue,
    surface: white,
    onSurface: darkGrey,
    error: darkGrey,
    onError: lightGrey,
    outline: black,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: black,
    onPrimary: red,
    secondary: black,
    onSecondary: green,
    tertiary: black,
    onTertiary: blue,
    surface: black,
    onSurface: lightGrey,
    error: lightGrey,
    onError: darkGrey,
    outline: white,
  );
}
