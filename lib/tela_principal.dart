import 'package:flutter/material.dart';
import 'jogo_main_old.dart'; // Importe a página do jogo

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
            Text(
              'Super Jogo da Velha',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor, // Cor primária do tema
                shadows: const [
                  Shadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  ),
                ],
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