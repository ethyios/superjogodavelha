import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

class Tema {
  static final ColorScheme defaultLightColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple).harmonized();
  static final ColorScheme defaultDarkColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark).harmonized();

  static ThemeData getLightTheme(ColorScheme? lightColorScheme) {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: lightColorScheme ?? defaultLightColorScheme,
      useMaterial3: true, // Habilita o Material 3
    );
  }

  static ThemeData getDarkTheme(ColorScheme? darkColorScheme) {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: darkColorScheme ?? defaultDarkColorScheme,
      useMaterial3: true,
    );
  }
}
