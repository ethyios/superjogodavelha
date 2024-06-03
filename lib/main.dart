
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'tela_principal.dart';



void main() {
  runApp(const SuperJogoDaVelhaApp());
}

class SuperJogoDaVelhaApp extends StatelessWidget {

  static final defaultLightColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple).harmonized();
  static final defaultDarkColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark).harmonized();

  const SuperJogoDaVelhaApp({super.key});

  @override
  Widget build(BuildContext context) => DynamicColorBuilder(
    builder: (lightColorScheme, darkColorScheme) => MaterialApp(
      title: 'Super Jogo da Velha',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
        useMaterial3: true, // Habilita o Material 3
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: darkColorScheme ?? defaultDarkColorScheme,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const TelaPrincipal(),
    ),
  );
}
