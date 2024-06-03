import 'package:flutter/material.dart';


class SuperJogoDaVelhaPage extends StatefulWidget {
  const SuperJogoDaVelhaPage({super.key});

  @override
  SuperJogoDaVelhaPageState createState() => SuperJogoDaVelhaPageState();
}

class SuperJogoDaVelhaPageState extends State<SuperJogoDaVelhaPage> {
  List<List<List<String>>> tabuleiro =
      List.generate(3, (_) => List.generate(3, (_) => List.filled(9, '')));
  List<List<String>> vencedoresMiniTabuleiros =
      List.generate(3, (_) => List.filled(3, ''));
  String jogadorAtual = 'X';
  int proximoMiniTabuleiroLinha = -1;
  int proximoMiniTabuleiroColuna = -1;

  void fazerJogada(int linha, int coluna, int posicao) {
    if (tabuleiro[linha][coluna][posicao] != '' ||
        vencedoresMiniTabuleiros[linha][coluna] != '') {
      return; // Impede jogar em casa ocupada ou em mini tabuleiro já decidido
    }

    setState(() {
      tabuleiro[linha][coluna][posicao] = jogadorAtual;
      String vencedorMiniTabuleiro = verificarVencedorMiniTabuleiro(linha, coluna);
      if (vencedorMiniTabuleiro != '') {
        vencedoresMiniTabuleiros[linha][coluna] = vencedorMiniTabuleiro;
        preencherMiniTabuleiro(linha, coluna, vencedorMiniTabuleiro);
      }

      calcularProximoMiniTabuleiro(linha, coluna, posicao);

      // Verifica se o jogo terminou após a jogada
      String vencedorSuperTabuleiro = verificarVencedorSuperTabuleiro();
      if (vencedorSuperTabuleiro != '') {
        mostrarResultado(vencedorSuperTabuleiro);
      }

      jogadorAtual = (jogadorAtual == 'X') ? 'O' : 'X';
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

  void reiniciarJogo() {
    setState(() {
      tabuleiro = List.generate(3, (_) => List.generate(3, (_) => List.filled(9, '')));
      vencedoresMiniTabuleiros = List.generate(3, (_) => List.filled(3, ''));
      jogadorAtual = 'X';
      proximoMiniTabuleiroLinha = -1;
      proximoMiniTabuleiroColuna = -1;
    });
  }

  void calcularProximoMiniTabuleiro(int linha, int coluna, int posicao) {
    if (vencedoresMiniTabuleiros[linha][coluna] != '') {
      // Se o mini tabuleiro atual já estiver decidido, permite jogar em qualquer lugar
      proximoMiniTabuleiroLinha = -1;
      proximoMiniTabuleiroColuna = -1;
    } else {
      // Caso contrário, o próximo mini tabuleiro é determinado pela posição da jogada
      proximoMiniTabuleiroLinha = posicao ~/ 3;
      proximoMiniTabuleiroColuna = posicao % 3;

      // Se o próximo mini tabuleiro já estiver decidido, permite jogar em qualquer lugar
      if (vencedoresMiniTabuleiros[proximoMiniTabuleiroLinha][proximoMiniTabuleiroColuna] != '') {
        proximoMiniTabuleiroLinha = -1;
        proximoMiniTabuleiroColuna = -1;
      }
    }
  }

  void preencherMiniTabuleiro(int linha, int coluna, String simbolo) {
    for (int i = 0; i < 9; i++) {
      tabuleiro[linha][coluna][i] = simbolo;
    }
  }

  String verificarVencedorMiniTabuleiro(int linha, int coluna) {
    var tabuleiro = this.tabuleiro[linha][coluna];

    // Verifica linhas
    for (int i = 0; i < 9; i += 3) {
      if (tabuleiro[i] != '' &&
          tabuleiro[i] == tabuleiro[i + 1] &&
          tabuleiro[i] == tabuleiro[i + 2]) {
        return tabuleiro[i];
      }
    }

    // Verifica colunas
    for (int i = 0; i < 3; i++) {
      if (tabuleiro[i] != '' &&
          tabuleiro[i] == tabuleiro[i + 3] &&
          tabuleiro[i] == tabuleiro[i + 6]) {
        return tabuleiro[i];
      }
    }

    // Verifica diagonais
    if (tabuleiro[0] != '' &&
        tabuleiro[0] == tabuleiro[4] &&
        tabuleiro[0] == tabuleiro[8]) {
      return tabuleiro[0];
    }
    if (tabuleiro[2] != '' &&
        tabuleiro[2] == tabuleiro[4] &&
        tabuleiro[2] == tabuleiro[6]) {
      return tabuleiro[2];
    }

    // Verifica empate (velha)
    if (!tabuleiro.contains('')) {
      return 'V';
    }

    return ''; // Jogo ainda em andamento
  }

  String verificarVencedorSuperTabuleiro() {
    // Verifica linhas
    for (int i = 0; i < 3; i++) {
      if (vencedoresMiniTabuleiros[i][0] != '' &&
          vencedoresMiniTabuleiros[i][0] == vencedoresMiniTabuleiros[i][1] &&
          vencedoresMiniTabuleiros[i][0] == vencedoresMiniTabuleiros[i][2]) {
        return vencedoresMiniTabuleiros[i][0];
      }
    }

    // Verifica colunas
    for (int i = 0; i < 3; i++) {
      if (vencedoresMiniTabuleiros[0][i] != '' &&
          vencedoresMiniTabuleiros[0][i] == vencedoresMiniTabuleiros[1][i] &&
          vencedoresMiniTabuleiros[0][i] == vencedoresMiniTabuleiros[2][i]) {
        return vencedoresMiniTabuleiros[0][i];
      }
    }

    // Verifica diagonais
    if (vencedoresMiniTabuleiros[0][0] != '' &&
        vencedoresMiniTabuleiros[0][0] == vencedoresMiniTabuleiros[1][1] &&
        vencedoresMiniTabuleiros[0][0] == vencedoresMiniTabuleiros[2][2]) {
      return vencedoresMiniTabuleiros[0][0];
    }
    if (vencedoresMiniTabuleiros[0][2] != '' &&
        vencedoresMiniTabuleiros[0][2] == vencedoresMiniTabuleiros[1][1] &&
        vencedoresMiniTabuleiros[0][2] == vencedoresMiniTabuleiros[2][0]) {
      return vencedoresMiniTabuleiros[0][2];
    }

    return ''; // Não há vencedor ainda
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
          IconButton( // Botão de instruções na AppBar
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
                        '- Se o mini tabuleiro estiver completo, a próxima jogada é livre.',
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



Widget buildBotaoInstrucoes() {
  return ElevatedButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Como Jogar'),
            content: const SingleChildScrollView( // Permite rolagem no diálogo
              child: Text(
                '- O objetivo é vencer 3 mini jogos da velha em linha.\n'
                '- A primeira jogada é livre.\n'
                '- As jogadas seguintes devem ser feitas no mini tabuleiro correspondente à posição da jogada anterior.\n'
                '- Se o mini tabuleiro estiver completo, a próxima jogada é livre.',
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
    child: const Text('Instruções'),
  );
}

  Widget buildMiniTabuleiro(int linha, int coluna) {
    bool tabuleiroPermitido =
        (linha == proximoMiniTabuleiroLinha && coluna == proximoMiniTabuleiroColuna) ||
        (proximoMiniTabuleiroLinha == -1);

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
          String simbolo = tabuleiro[linha][coluna][posicao];
          bool jogoTerminado = vencedoresMiniTabuleiros[linha][coluna] != '';

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
                //fontSize: MediaQuery.of(context).size.width / 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Colors.black, // Cor do texto definida explicitamente
              ),
            ),
          );
        }),
      ),
    );
  }

    Color getCorCelula(int linha, int coluna, BuildContext context) { // Adicionamos o BuildContext
    if (vencedoresMiniTabuleiros[linha][coluna] != '') {
      return Theme.of(context).disabledColor; // Cor de desabilitação do tema atual
    } else {
      // Paleta de cores com bom contraste em modos claro e escuro
      List<Color> cores = [
        Colors.blue[200]!,  // Azul claro
        Colors.green[200]!, // Verde claro
        Colors.pink[200]!,  // Rosa claro
        Colors.orange[200]!, // Laranja claro
        Colors.purple[200]!, // Roxo claro
        Colors.yellow[200]!, // Amarelo claro
        Colors.teal[200]!,  // Teal claro
        Colors.brown[200]!, // Marrom claro
        Colors.grey[500]!,  // Cinza claro
      ];

      return cores[linha * 3 + coluna]; 
    }
  }
}