import 'package:flutter/material.dart';
import 'jogo.dart';

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
              'assets/ic_launcher.png', // Caminho para o ícone do jogo
              width: 150, // Largura do ícone
              height: 150, // Altura do ícone
            ),
            const SizedBox(height: 20),
            const Text(
              'Super Jogo da Velha', style: TextStyle(
                fontFamily: 'Schyler',
                fontWeight: FontWeight.bold
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
          ],
        ),
      ),
    );
  }
}