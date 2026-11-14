import 'package:material_ui/material_ui.dart';

abstract final class AppColors {
  static const black = Color(0xFF0A0A0A);
  static const darkGrey = Color(0xFF323232);
  static const lightGrey = Color(0xFFC8C8C8);
  static const white = Color(0xFFF5F5F5);

  static const red = Color(0xFFFF0000);
  static const green = Color(0xFF00FF00);
  static const blue = Color(0xFF0000FF);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: white,
    onPrimary: red,
    secondary: white,
    onSecondary: green,
    tertiary: white,
    onTertiary: blue,
    surface: white,
    onSurface: black,
    error: darkGrey,
    onError: lightGrey,
    outline: black,
    outlineVariant: darkGrey,
    shadow: lightGrey,
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
    onSurface: white,
    error: lightGrey,
    onError: darkGrey,
    outline: white,
    outlineVariant: lightGrey,
    shadow: darkGrey,
  );
}
