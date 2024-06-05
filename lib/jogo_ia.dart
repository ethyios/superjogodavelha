import 'jogo_logica.dart';

class JogoIA {
  String jogadorIA = 'O';
  String jogadorHumano = 'X';
  int profundidadeMaxima = 3; // Limitar a profundidade para 3

  int escolherJogada(SuperJogoDaVelhaLogica jogoLogica) {
    int melhorValor = -1000;
    int melhorJogada = -1;

    // Se o próximo mini tabuleiro já está definido, restringir as jogadas a ele
    if (jogoLogica.proximoMiniTabuleiroLinha != -1 && jogoLogica.proximoMiniTabuleiroColuna != -1) {
      melhorJogada = avaliarMiniTabuleiro(jogoLogica, jogoLogica.proximoMiniTabuleiroLinha, jogoLogica.proximoMiniTabuleiroColuna, melhorValor);
    } else {
      // Se não, avaliar todas as jogadas possíveis
      for (int linha = 0; linha < 3; linha++) {
        for (int coluna = 0; coluna < 3; coluna++) {
          melhorJogada = avaliarMiniTabuleiro(jogoLogica, linha, coluna, melhorValor);
        }
      }
    }

    return melhorJogada;
  }

  int avaliarMiniTabuleiro(SuperJogoDaVelhaLogica jogoLogica, int linha, int coluna, int melhorValor) {
    int melhorJogada = -1;
    for (int posicao = 0; posicao < 9; posicao++) {
      if (jogoLogica.tabuleiro[linha][coluna][posicao] == '') {
        jogoLogica.tabuleiro[linha][coluna][posicao] = jogadorIA;
        int jogadaValor = minimax(jogoLogica, 0, false, -1000, 1000);
        jogoLogica.tabuleiro[linha][coluna][posicao] = '';
        if (jogadaValor > melhorValor) {
          melhorValor = jogadaValor;
          melhorJogada = linha * 27 + coluna * 9 + posicao;
        }
      }
    }
    return melhorJogada;
  }

  int minimax(SuperJogoDaVelhaLogica jogoLogica, int profundidade, bool isMax, int alpha, int beta) {
    if (profundidade >= profundidadeMaxima) return 0;

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
              melhorValor = max(melhorValor, minimax(jogoLogica, profundidade + 1, false, alpha, beta));
              jogoLogica.tabuleiro[linha][coluna][posicao] = '';
              alpha = max(alpha, melhorValor);
              if (beta <= alpha) break;
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
              melhorValor = min(melhorValor, minimax(jogoLogica, profundidade + 1, true, alpha, beta));
              jogoLogica.tabuleiro[linha][coluna][posicao] = '';
              beta = min(beta, melhorValor);
              if (beta <= alpha) break;
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
