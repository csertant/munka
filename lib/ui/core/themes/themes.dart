import 'package:material_ui/material_ui.dart';

import 'colors.dart';
import 'dimensions.dart';

var _baseTextStyle = const TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  fontFamily: 'DotGothic16',
  fontFamilyFallback: ['Arial', 'sans-serif'],
);

abstract final class AppTheme {
  static final _textTheme = TextTheme(
    // Currently unused
    displayLarge: _baseTextStyle.copyWith(color: Colors.deepPurple),
    displayMedium: _baseTextStyle.copyWith(color: Colors.deepPurple),
    displaySmall: _baseTextStyle.copyWith(color: Colors.deepPurple),

    //Currently unused
    headlineLarge: _baseTextStyle.copyWith(fontSize: 75),
    headlineMedium: _baseTextStyle.copyWith(color: Colors.deepPurple),
    headlineSmall: _baseTextStyle.copyWith(color: Colors.deepPurple),

    titleLarge: _baseTextStyle.copyWith(fontSize: 20),
    titleMedium: _baseTextStyle.copyWith(fontSize: 18),
    titleSmall: _baseTextStyle.copyWith(fontSize: 16),

    bodyLarge: _baseTextStyle.copyWith(fontSize: 14),
    bodyMedium: _baseTextStyle,
    bodySmall: _baseTextStyle.copyWith(fontSize: 10),

    labelLarge: _baseTextStyle.copyWith(
      fontSize: 12,
      fontStyle: FontStyle.italic,
    ),
    labelMedium: _baseTextStyle.copyWith(
      fontSize: 10,
      fontStyle: FontStyle.italic,
    ),
    labelSmall: _baseTextStyle.copyWith(
      fontSize: 8,
      fontStyle: FontStyle.italic,
    ),
  );

  static final _lightNavigationBarTheme = NavigationBarThemeData(
    height: AppDimensions.navigationBarHeight,
    backgroundColor: AppColors.lightColorScheme.surface,
    indicatorColor: AppColors.lightColorScheme.shadow,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
  );
  static final _darkNavigationBarTheme = NavigationBarThemeData(
    height: AppDimensions.navigationBarHeight,
    backgroundColor: AppColors.darkColorScheme.surface,
    indicatorColor: AppColors.darkColorScheme.shadow,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
  );

  static final _lightOutlinedButtonStyle = ButtonStyle(
    elevation: const WidgetStatePropertyAll<double>(0),
    shape: WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(
        side: BorderSide(color: AppColors.lightColorScheme.onSurface),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.borderRadiusMedium),
        ),
      ),
    ),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return AppColors.lightColorScheme.shadow;
      }
      return null;
    }),
    foregroundColor: WidgetStatePropertyAll<Color>(
      AppColors.lightColorScheme.onSurface,
    ),
  );

  static final _darkOutlinedButtonStyle = ButtonStyle(
    elevation: const WidgetStatePropertyAll<double>(0),
    shape: WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(
        side: BorderSide(color: AppColors.darkColorScheme.onSurface),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.borderRadiusMedium),
        ),
      ),
    ),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return AppColors.darkColorScheme.shadow;
      }
      return null;
    }),
    foregroundColor: WidgetStatePropertyAll<Color>(
      AppColors.darkColorScheme.onSurface,
    ),
  );

  static const FloatingActionButtonThemeData _floatingActionButtonTheme =
      FloatingActionButtonThemeData(
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
      );

  static final RadioThemeData _radioTheme = RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.lightColorScheme.onPrimary;
      }
      return null;
    }),
  );

  static final SwitchThemeData _lightSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.lightColorScheme.onPrimary;
      } else {
        return AppColors.lightColorScheme.outlineVariant;
      }
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.lightColorScheme.onPrimary;
      } else {
        return AppColors.lightColorScheme.outlineVariant;
      }
    }),
  );

  static final SwitchThemeData _darkSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.lightColorScheme.onPrimary;
      } else {
        return AppColors.lightColorScheme.outlineVariant;
      }
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.lightColorScheme.onPrimary;
      } else {
        return AppColors.lightColorScheme.outlineVariant;
      }
    }),
  );

  static final _ligthTextSelectionTheme = TextSelectionThemeData(
    cursorColor: AppColors.lightColorScheme.onSecondary,
    selectionColor: AppColors.lightColorScheme.shadow,
    selectionHandleColor: AppColors.lightColorScheme.outlineVariant,
  );

  static final _darkTextSelectionTheme = TextSelectionThemeData(
    cursorColor: AppColors.darkColorScheme.onSecondary,
    selectionColor: AppColors.darkColorScheme.shadow,
    selectionHandleColor: AppColors.darkColorScheme.outlineVariant,
  );

  static ThemeData lightTheme = ThemeData(
    appBarTheme: _appBarTheme,
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    floatingActionButtonTheme: _floatingActionButtonTheme,
    fontFamily: 'DotGothic16',
    fontFamilyFallback: const ['Arial', 'sans-serif'],
    navigationBarTheme: _lightNavigationBarTheme,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: _lightOutlinedButtonStyle,
    ),
    radioTheme: _radioTheme,
    switchTheme: _lightSwitchTheme,
    textTheme: _textTheme,
    textSelectionTheme: _ligthTextSelectionTheme,
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: _appBarTheme,
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    floatingActionButtonTheme: _floatingActionButtonTheme,
    fontFamily: 'DotGothic16',
    fontFamilyFallback: const ['Arial', 'sans-serif'],
    navigationBarTheme: _darkNavigationBarTheme,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: _darkOutlinedButtonStyle,
    ),
    radioTheme: _radioTheme,
    switchTheme: _darkSwitchTheme,
    textTheme: _textTheme,
    textSelectionTheme: _darkTextSelectionTheme,
  );
}
