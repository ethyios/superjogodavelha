import 'jogo_logica.dart';

class JogoIA {
  String jogadorIA = 'O';
  String jogadorHumano = 'X';

  int escolherJogada(SuperJogoDaVelhaLogica jogoLogica) {
    int melhorValor = -1000;
    int melhorJogada = -1;

    for (int linha = 0; linha < 3; linha++) {
      for (int coluna = 0; coluna < 3; coluna++) {
        for (int posicao = 0; posicao < 9; posicao++) {
          if (jogoLogica.tabuleiro[linha][coluna][posicao] == '') {
            jogoLogica.tabuleiro[linha][coluna][posicao] = jogadorIA;
            int jogadaValor = minimax(jogoLogica, 0, false);
            jogoLogica.tabuleiro[linha][coluna][posicao] = '';
            if (jogadaValor > melhorValor) {
              melhorValor = jogadaValor;
              melhorJogada = linha * 27 + coluna * 9 + posicao;
            }
          }
        }
      }
    }

    return melhorJogada;
  }

  int minimax(SuperJogoDaVelhaLogica jogoLogica, int profundidade, bool isMax) {
    String resultado = jogoLogica.verificarVencedorSuperTabuleiro();
    if (resultado == jogadorIA) return 10 - profundidade;
    if (resultado == jogadorHumano) return profundidade - 10;
    if (jogoLogica.tabuleiro.every((linha) => linha.every((coluna) => coluna.every((celula) => celula != '')))) return 0;

    if (isMax) {
      int melhorValor = -1000;
      for (int linha = 0; linha < 3; linha++) {
        for (int coluna = 0; coluna < 3; coluna++) {
          for (int posicao = 0; posicao < 9; posicao++) {
            if (jogoLogica.tabuleiro[linha][coluna][posicao] == '') {
              jogoLogica.tabuleiro[linha][coluna][posicao] = jogadorIA;
              melhorValor = max(melhorValor, minimax(jogoLogica, profundidade + 1, false));
              jogoLogica.tabuleiro[linha][coluna][posicao] = '';
            }
          }
        }
      }
      return melhorValor;
    } else {
      int melhorValor = 1000;
      for (int linha = 0; linha < 3; linha++) {
        for (int coluna = 0; coluna < 3; coluna++) {
          for (int posicao = 0; posicao < 9; posicao++) {
            if (jogoLogica.tabuleiro[linha][coluna][posicao] == '') {
              jogoLogica.tabuleiro[linha][coluna][posicao] = jogadorHumano;
              melhorValor = min(melhorValor, minimax(jogoLogica, profundidade + 1, true));
              jogoLogica.tabuleiro[linha][coluna][posicao] = '';
            }
          }
        }
      }
      return melhorValor;
    }
  }

  int max(int a, int b) => (a > b) ? a : b;

  int min(int a, int b) => (a < b) ? a : b;
}
