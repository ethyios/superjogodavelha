import '../logica/jogo_logica.dart';
import '../controle/jogo_controle.dart';

class JogoIA {
  final JogoController jogoController;

  JogoIA(this.jogoController);

  String jogadorIA = 'O';
  String jogadorHumano = 'X';
  int profundidadeMaxima = 3;

  void fazerJogadaIA() {
    int melhorJogada = escolherJogada(jogoController.jogoLogica);
    if (melhorJogada != -1) {
      int linha = melhorJogada ~/ 27;
      int coluna = (melhorJogada % 27) ~/ 9;
      int posicao = melhorJogada % 9;
      jogoController.jogoLogica.fazerJogada(linha, coluna, posicao);
    }
  }

  int escolherJogada(SuperJogoDaVelhaLogica jogoLogica) {
    int melhorValor = -1000;
    int melhorJogada = -1;

    if (jogoLogica.proximoMiniTabuleiroLinha != -1 && jogoLogica.proximoMiniTabuleiroColuna != -1) {
      melhorJogada = avaliarMiniTabuleiro(jogoLogica, jogoLogica.proximoMiniTabuleiroLinha, jogoLogica.proximoMiniTabuleiroColuna, melhorValor);
    } else {
      for (int linha = 0; linha < 3; linha++) {
        for (int coluna = 0; coluna < 3; coluna++) {
          int jogadaAtual = avaliarMiniTabuleiro(jogoLogica, linha, coluna, melhorValor);
          if (jogadaAtual != -1 && jogoLogica.tabuleiro[linha][coluna][jogadaAtual % 9] == '') {
            melhorJogada = jogadaAtual;
          }
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
        int jogadaValor = calcularPontuacao(jogoLogica, linha, coluna, posicao) + minimax(jogoLogica, 0, false, -1000, 1000);
        jogoLogica.tabuleiro[linha][coluna][posicao] = '';
        if (jogadaValor > melhorValor) {
          melhorValor = jogadaValor;
          melhorJogada = linha * 27 + coluna * 9 + posicao;
        }
      }
    }
    return melhorJogada;
  }

  int calcularPontuacao(SuperJogoDaVelhaLogica jogoLogica, int linha, int coluna, int posicao) {
    int pontuacao = 0;

    // Verificar se a jogada ganha o mini tabuleiro
    String vencedorMiniTabuleiro = jogoLogica.verificarVencedorMiniTabuleiro(linha, coluna);
    if (vencedorMiniTabuleiro == jogadorIA) {
      pontuacao += 100;
    } else if (vencedorMiniTabuleiro == jogadorHumano) {
      pontuacao -= 50;
    }

    // Verificar se a jogada impede o adversário de ganhar um mini tabuleiro
    jogoLogica.tabuleiro[linha][coluna][posicao] = jogadorHumano;
    vencedorMiniTabuleiro = jogoLogica.verificarVencedorMiniTabuleiro(linha, coluna);
    if (vencedorMiniTabuleiro == jogadorHumano) {
      pontuacao += 50;
    }
    jogoLogica.tabuleiro[linha][coluna][posicao] = jogadorIA;

    // Verificar se a jogada cria uma linha/coluna/diagonal com dois símbolos
    pontuacao += avaliarLinhasColunasDiagonais(jogoLogica, linha, coluna, jogadorIA) * 10;

    return pontuacao;
  }

  int avaliarLinhasColunasDiagonais(SuperJogoDaVelhaLogica jogoLogica, int linha, int coluna, String jogador) {
    int contador = 0;

    // Avaliar linhas
    for (int i = 0; i < 3; i++) {
      if (jogoLogica.tabuleiro[linha][coluna][i * 3] == jogador && jogoLogica.tabuleiro[linha][coluna][i * 3 + 1] == jogador) contador++;
      if (jogoLogica.tabuleiro[linha][coluna][i * 3 + 1] == jogador && jogoLogica.tabuleiro[linha][coluna][i * 3 + 2] == jogador) contador++;
    }

    // Avaliar colunas
    for (int i = 0; i < 3; i++) {
      if (jogoLogica.tabuleiro[linha][coluna][i] == jogador && jogoLogica.tabuleiro[linha][coluna][i + 3] == jogador) contador++;
      if (jogoLogica.tabuleiro[linha][coluna][i + 3] == jogador && jogoLogica.tabuleiro[linha][coluna][i + 6] == jogador) contador++;
    }

    // Avaliar diagonais
    if (jogoLogica.tabuleiro[linha][coluna][0] == jogador && jogoLogica.tabuleiro[linha][coluna][4] == jogador) contador++;
    if (jogoLogica.tabuleiro[linha][coluna][4] == jogador && jogoLogica.tabuleiro[linha][coluna][8] == jogador) contador++;
    if (jogoLogica.tabuleiro[linha][coluna][2] == jogador && jogoLogica.tabuleiro[linha][coluna][4] == jogador) contador++;
    if (jogoLogica.tabuleiro[linha][coluna][4] == jogador && jogoLogica.tabuleiro[linha][coluna][6] == jogador) contador++;

    return contador;
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
              int pontuacao = calcularPontuacao(jogoLogica, linha, coluna, posicao);
              melhorValor = max(melhorValor, minimax(jogoLogica, profundidade + 1, false, alpha, beta) + pontuacao);
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
              int pontuacao = calcularPontuacao(jogoLogica, linha, coluna, posicao);
              melhorValor = min(melhorValor, minimax(jogoLogica, profundidade + 1, true, alpha, beta) - pontuacao);
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
