import 'package:flutter/material.dart';
import '../logica/jogo_logica.dart';

class MiniTabuleiroTela extends StatelessWidget {
  final int linha;
  final int coluna;
  final SuperJogoDaVelhaLogica jogoLogica;
  final void Function(int, int, int) onJogada;

  const MiniTabuleiroTela({super.key, 
    required this.linha,
    required this.coluna,
    required this.jogoLogica,
    required this.onJogada,
  });

  @override
  Widget build(BuildContext context) {
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
                : () => onJogada(linha, coluna, posicao),
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
