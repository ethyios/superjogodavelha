class JogoIA {
  String jogadorIA = 'O';
  String jogadorHumano = 'X';

  int escolherJogada(List<List<List<String>>> tabuleiro, List<List<String>> vencedoresMiniTabuleiros, int proximoMiniTabuleiroLinha, int proximoMiniTabuleiroColuna) {
    // Implementação básica: IA escolhe a primeira posição disponível no próximo mini tabuleiro
    if (proximoMiniTabuleiroLinha == -1 || vencedoresMiniTabuleiros[proximoMiniTabuleiroLinha][proximoMiniTabuleiroColuna] != '') {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          for (int k = 0; k < 9; k++) {
            if (tabuleiro[i][j][k] == '') {
              return i * 3 + j;
            }
          }
        }
      }
    } else {
      for (int i = 0; i < 9; i++) {
        if (tabuleiro[proximoMiniTabuleiroLinha][proximoMiniTabuleiroColuna][i] == '') {
          return i;
        }
      }
    }
    return -1; // Se não houver jogada disponível
  }
}
