class SuperJogoDaVelhaLogica {
  bool primeiroTurno = true;

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
      return;
    }

    tabuleiro[linha][coluna][posicao] = jogadorAtual;
    String vencedorMiniTabuleiro = verificarVencedorMiniTabuleiro(linha, coluna);
    if (vencedorMiniTabuleiro != '') {
      vencedoresMiniTabuleiros[linha][coluna] = vencedorMiniTabuleiro;
      preencherMiniTabuleiro(linha, coluna, vencedorMiniTabuleiro);
    }
    primeiroTurno = false;
    calcularProximoMiniTabuleiro(linha, coluna, posicao);

    String vencedorSuperTabuleiro = verificarVencedorSuperTabuleiro();
    if (vencedorSuperTabuleiro != '') {
      jogadorAtual = vencedorSuperTabuleiro; // Para indicar o vencedor
    }

    jogadorAtual = (jogadorAtual == 'X') ? 'O' : 'X';
  }

  void reiniciarJogo() {
    tabuleiro = List.generate(3, (_) => List.generate(3, (_) => List.filled(9, '')));
    vencedoresMiniTabuleiros = List.generate(3, (_) => List.filled(3, ''));
    jogadorAtual = 'X';
    proximoMiniTabuleiroLinha = -1;
    proximoMiniTabuleiroColuna = -1;
    primeiroTurno = true;
  }

  void calcularProximoMiniTabuleiro(int linha, int coluna, int posicao) {
    if (primeiroTurno) {
      proximoMiniTabuleiroLinha = -1;
      proximoMiniTabuleiroColuna = -1;
    } else {
      proximoMiniTabuleiroLinha = posicao ~/ 3;
      proximoMiniTabuleiroColuna = posicao % 3;

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

    for (int i = 0; i < 9; i += 3) {
      if (tabuleiro[i] != '' &&
          tabuleiro[i] == tabuleiro[i + 1] &&
          tabuleiro[i] == tabuleiro[i + 2]) {
        return tabuleiro[i];
      }
    }

    for (int i = 0; i < 3; i++) {
      if (tabuleiro[i] != '' &&
          tabuleiro[i] == tabuleiro[i + 3] &&
          tabuleiro[i] == tabuleiro[i + 6]) {
        return tabuleiro[i];
      }
    }

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

    if (!tabuleiro.contains('')) {
      return 'V';
    }

    return '';
  }

  String verificarVencedorSuperTabuleiro() {
    for (int i = 0; i < 3; i++) {
      if (vencedoresMiniTabuleiros[i][0] != '' &&
          vencedoresMiniTabuleiros[i][0] == vencedoresMiniTabuleiros[i][1] &&
          vencedoresMiniTabuleiros[i][0] == vencedoresMiniTabuleiros[i][2]) {
        return vencedoresMiniTabuleiros[i][0];
      }
    }

    for (int i = 0; i < 3; i++) {
      if (vencedoresMiniTabuleiros[0][i] != '' &&
          vencedoresMiniTabuleiros[0][i] == vencedoresMiniTabuleiros[1][i] &&
          vencedoresMiniTabuleiros[0][i] == vencedoresMiniTabuleiros[2][i]) {
        return vencedoresMiniTabuleiros[0][i];
      }
    }

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

    return '';
  }
}
