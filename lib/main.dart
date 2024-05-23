import 'package:flutter/material.dart';
import 'tela_principal.dart'; // Importe a tela principal

void main() {
  runApp(const SuperJogoDaVelhaApp());
}

class SuperJogoDaVelhaApp extends StatelessWidget {
  const SuperJogoDaVelhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Jogo da Velha',
      theme: Theme.of(context),
      home: const TelaPrincipal(), // Define a tela principal como a inicial
    );
  }
}