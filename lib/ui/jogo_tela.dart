import 'package:flutter/material.dart';
import '../controle/jogo_controle.dart';
import 'mini_tabuleiro_tela.dart';

class SuperJogoDaVelhaPage extends StatefulWidget {
  final bool modoIA;
  const SuperJogoDaVelhaPage({super.key, this.modoIA = false});

  @override
  SuperJogoDaVelhaPageState createState() => SuperJogoDaVelhaPageState();
}

class SuperJogoDaVelhaPageState extends State<SuperJogoDaVelhaPage> {
  final JogoController jogoController = JogoController();

  void fazerJogada(int linha, int coluna, int posicao) {
    setState(() {
      jogoController.fazerJogada(linha, coluna, posicao, widget.modoIA);
    });

    String vencedor = jogoController.verificarVencedorSuperTabuleiro();
    if (vencedor != '') {
      mostrarResultado(vencedor);
    }
  }

  void reiniciarJogo() {
    setState(() {
      jogoController.reiniciarJogo();
    });
  }

  void mostrarResultado(String vencedor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fim de Jogo!'),
          content: Text('O jogador $vencedor venceu o Super Jogo da Velha!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                reiniciarJogo();
              },
              child: const Text('Jogar Novamente'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Jogo da Velha'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: reiniciarJogo,
          ),
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Como Jogar'),
                    content: const SingleChildScrollView(
                      child: Text(
                        '- O objetivo é vencer 3 mini jogos da velha em linha.\n'
                        '- A primeira jogada é livre.\n'
                        '- As jogadas seguintes devem ser feitas no mini tabuleiro correspondente à posição da jogada anterior.\n'
                        '- Se o próximo mini tabuleiro estiver completo, a próxima jogada é livre.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Fechar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double tamanhoTabuleiro = constraints.maxWidth;
          if (tamanhoTabuleiro > constraints.maxHeight) {
            tamanhoTabuleiro = constraints.maxHeight;
          }

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: tamanhoTabuleiro,
                maxHeight: tamanhoTabuleiro,
              ),
              child: Container(
                width: tamanhoTabuleiro,
                height: tamanhoTabuleiro,
                padding: const EdgeInsets.all(10),
                child: GridView.count(
                  key: const Key('tabuleiroPrincipal'),
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: List.generate(9, (index) {
                    int linha = index ~/ 3;
                    int coluna = index % 3;
                    return MiniTabuleiroTela(
                      linha: linha,
                      coluna: coluna,
                      jogoLogica: jogoController.jogoLogica,
                      onJogada: fazerJogada,
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
