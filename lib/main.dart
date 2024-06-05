import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'tema.dart';
import 'ui/jogo_tela.dart';

void main() {
  runApp(const SuperJogoDaVelhaApp());
}

class SuperJogoDaVelhaApp extends StatelessWidget {
  const SuperJogoDaVelhaApp({super.key});

  @override
  Widget build(BuildContext context) => DynamicColorBuilder(
        builder: (lightColorScheme, darkColorScheme) => MaterialApp(
          title: 'Super Jogo da Velha',
          theme: Tema.getLightTheme(lightColorScheme),
          darkTheme: Tema.getDarkTheme(darkColorScheme),
          themeMode: ThemeMode.system,
          home: const TelaPrincipal(),
        ),
      );
}

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ic_launcher.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Super Jogo da Velha',
              style: TextStyle(
                fontFamily: 'Schyler',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SuperJogoDaVelhaPage()),
                );
              },
              child: const Text('Modo Duelo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SuperJogoDaVelhaPage(modoIA: true)),
                );
              },
              child: const Text('Modo IA'),
            ),
          ],
        ),
      ),
    );
  }
}
