import 'package:flutter/material.dart';
import 'package:shm/themes/shm_text_style.dart';

class CustomThemes {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFB9090B),
    onPrimary: Colors.white,
    secondary: Color(0xFFB9090B),
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Color.fromARGB(235, 245, 195, 195),
    onSurface: Colors.black,
    brightness: Brightness.light,
    surfaceContainer: Colors.white,
  );
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color.fromARGB(255, 29, 33, 40),
    secondary: Color.fromARGB(255, 29, 33, 40),
    surface: Color.fromARGB(255, 47, 50, 55),
    error: Colors.redAccent,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
    surfaceContainer: Color.fromARGB(255, 29, 33, 40),
  );

  static AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: lightColorScheme.primary,
    shadowColor: const Color.fromARGB(185, 0, 0, 0),
    elevation: 0.0,
    centerTitle: false,
    scrolledUnderElevation: 10.0,
    toolbarHeight: 70.0,
    titleTextStyle: _textTheme.titleLarge?.copyWith(
      color: lightColorScheme.onPrimary,
    ),
// icons button theme
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
      size: 16.0,
    ),
  );

  static AppBarTheme darkAppBarTheme = AppBarTheme(
    backgroundColor: darkColorScheme.primary,
    shadowColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: false,
    scrolledUnderElevation: 10.0,
    toolbarHeight: 70.0,
    titleTextStyle: _textTheme.titleLarge?.copyWith(
      color: darkColorScheme.onPrimary,
    ),
// icons button theme
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
      size: 16.0,
    ),
  );

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        fontFamily: "Poppins",
        colorScheme: colorScheme,
        highlightColor: Colors.transparent,
        focusColor: focusColor,
        textTheme: _textTheme,
        useMaterial3: true,
        appBarTheme: (colorScheme == lightColorScheme
            ? lightAppBarTheme
            : darkAppBarTheme));
  }

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: ShmTextStyle.displayLarge,
      displayMedium: ShmTextStyle.displayMedium,
      displaySmall: ShmTextStyle.displaySmall,
      headlineLarge: ShmTextStyle.headlineLarge,
      headlineMedium: ShmTextStyle.headlineMedium,
      headlineSmall: ShmTextStyle.headlineSmall,
      titleLarge: ShmTextStyle.titleLarge,
      titleMedium: ShmTextStyle.titleMedium,
      titleSmall: ShmTextStyle.titleSmall,
      bodyLarge: ShmTextStyle.bodyLargeBold,
      bodyMedium: ShmTextStyle.bodyLargeMedium,
      bodySmall: ShmTextStyle.bodyLargeRegular,
      labelLarge: ShmTextStyle.labelLarge,
      labelMedium: ShmTextStyle.labelMedium,
      labelSmall: ShmTextStyle.labelSmall,
    );
  }
}
