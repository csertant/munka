import 'package:material_ui/material_ui.dart';

import 'colors.dart';

var _baseTextStyle = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  // fontFamily: 'Times New Roman',
  // fontFamilyFallback: ['Times', 'serif'],
);

abstract final class AppTheme {
  static final _textTheme = TextTheme(
    // Currently unused
    displayLarge: _baseTextStyle.copyWith(color: Colors.deepPurple),
    displayMedium: _baseTextStyle.copyWith(color: Colors.deepPurple),
    displaySmall: _baseTextStyle.copyWith(color: Colors.deepPurple),

    //Currently unused
    headlineLarge: _baseTextStyle.copyWith(color: Colors.deepPurple),
    headlineMedium: _baseTextStyle.copyWith(color: Colors.deepPurple),
    headlineSmall: _baseTextStyle.copyWith(color: Colors.deepPurple),

    titleLarge: _baseTextStyle.copyWith(fontSize: 24),
    titleMedium: _baseTextStyle.copyWith(fontSize: 22),
    titleSmall: _baseTextStyle.copyWith(fontSize: 20),

    bodyLarge: _baseTextStyle.copyWith(fontSize: 18),
    bodyMedium: _baseTextStyle,
    bodySmall: _baseTextStyle.copyWith(fontSize: 14),

    labelLarge: _baseTextStyle.copyWith(
      fontSize: 16,
      fontStyle: FontStyle.italic,
    ),
    labelMedium: _baseTextStyle.copyWith(
      fontSize: 14,
      fontStyle: FontStyle.italic,
    ),
    labelSmall: _baseTextStyle.copyWith(
      fontSize: 12,
      fontStyle: FontStyle.italic,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    textTheme: _textTheme,
    // fontFamily: 'Times New Roman',
    // fontFamilyFallback: const ['Times', 'serif'],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    textTheme: _textTheme,
    // fontFamily: 'Times New Roman',
    // fontFamilyFallback: const ['Times', 'serif'],
  );
}
