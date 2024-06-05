import 'package:example/theme/theme_constants.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: kPrimaryColor,
  colorScheme: const ColorScheme.dark(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: kBackgroundColor,
  textTheme: TextTheme(
    displayLarge: kTextStyleHeading1,
    displayMedium: kTextStyleHeading2,
    displaySmall: kTextStyleAppHeading3,
    headlineMedium: kTextStyleHeading4,
    bodyLarge: kTextStyleBody1,
    bodyMedium: kTextStyleBody2,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith(
        (state) {
          if (state.contains(WidgetState.disabled)) {
            return kDeepPurple;
          } else if (state.contains(WidgetState.pressed)) {
            return kPrimaryColor.withOpacity(0.8);
          } else {
            return kPrimaryColor;
          }
        },
      ),
    ),
  ),
);
