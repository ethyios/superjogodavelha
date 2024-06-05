import 'package:flutter/material.dart';
import 'jogo_logica.dart';
import 'jogo_ia.dart';

class SuperJogoDaVelhaPage extends StatefulWidget {
  final bool modoIA;
  const SuperJogoDaVelhaPage({super.key, this.modoIA = false});

  @override
  SuperJogoDaVelhaPageState createState() => SuperJogoDaVelhaPageState();
}

class SuperJogoDaVelhaPageState extends State<SuperJogoDaVelhaPage> {
  final SuperJogoDaVelhaLogica jogoLogica = SuperJogoDaVelhaLogica();
  final JogoIA jogoIA = JogoIA();

  void fazerJogada(int linha, int coluna, int posicao) {
    setState(() {
      jogoLogica.fazerJogada(linha, coluna, posicao);
      String vencedor = jogoLogica.verificarVencedorSuperTabuleiro();
      if (vencedor != '') {
        mostrarResultado(vencedor);
        return;
      }

      if (widget.modoIA && jogoLogica.jogadorAtual == 'O') {
        int jogadaIA = jogoIA.escolherJogada(jogoLogica);
        if (jogadaIA != -1) {
          int linhaIA = jogadaIA ~/ 27;
          int colunaIA = (jogadaIA % 27) ~/ 9;
          int posicaoIA = jogadaIA % 9;
          jogoLogica.fazerJogada(linhaIA, colunaIA, posicaoIA);
          vencedor = jogoLogica.verificarVencedorSuperTabuleiro();
          if (vencedor != '') {
            mostrarResultado(vencedor);
          }
        }
      }
    });
  }

  void reiniciarJogo() {
    setState(() {
      jogoLogica.reiniciarJogo();
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
                    return buildMiniTabuleiro(linha, coluna);
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildMiniTabuleiro(int linha, int coluna) {
    bool tabuleiroPermitido =
        (linha == jogoLogica.proximoMiniTabuleiroLinha && coluna == jogoLogica.proximoMiniTabuleiroColuna) ||
        (jogoLogica.proximoMiniTabuleiroLinha == -1);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: tabuleiroPermitido ? getCorCelula(linha, coluna, context) : Colors.grey[200],
      ),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(9, (index) {
          int posicao = index;
          String simbolo = jogoLogica.tabuleiro[linha][coluna][posicao];
          bool jogoTerminado = jogoLogica.vencedoresMiniTabuleiros[linha][coluna] != '';

          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: getCorCelula(linha, coluna, context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black, width: 1),
              ),
              padding: const EdgeInsets.all(.5),
            ),
            onPressed: jogoTerminado || !tabuleiroPermitido
                ? null
                : () => fazerJogada(linha, coluna, posicao),
            child: Text(
              simbolo,
              style: const TextStyle(
                fontSize: 28,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        }),
      ),
    );
  }

  Color getCorCelula(int linha, int coluna, BuildContext context) {
    if (jogoLogica.vencedoresMiniTabuleiros[linha][coluna] != '') {
      return Theme.of(context).disabledColor;
    } else {
      List<Color> cores = [
        Colors.blue[200]!,
        Colors.green[200]!,
        Colors.pink[200]!,
        Colors.orange[200]!,
        Colors.purple[200]!,
        Colors.yellow[200]!,
        Colors.teal[200]!,
        Colors.brown[200]!,
        Colors.grey[500]!,
      ];

      return cores[linha * 3 + coluna];
    }
  }
}
