import '../logica/jogo_logica.dart';
import '../logica/jogo_ia.dart';

class JogoController {
  final SuperJogoDaVelhaLogica jogoLogica = SuperJogoDaVelhaLogica();
  late final JogoIA jogoIA;

  JogoController() {
    jogoIA = JogoIA(this);
  }

  void fazerJogada(int linha, int coluna, int posicao, bool modoIA) {
    jogoLogica.fazerJogada(linha, coluna, posicao);
    if (modoIA && jogoLogica.jogadorAtual == 'O') {
      jogoIA.fazerJogadaIA();
    }
  }

  void reiniciarJogo() {
    jogoLogica.reiniciarJogo();
  }

  String verificarVencedorSuperTabuleiro() {
    return jogoLogica.verificarVencedorSuperTabuleiro();
  }

  List<List<List<String>>> getTabuleiro() {
    return jogoLogica.tabuleiro;
  }

  List<List<String>> getVencedoresMiniTabuleiros() {
    return jogoLogica.vencedoresMiniTabuleiros;
  }

  String getJogadorAtual() {
    return jogoLogica.jogadorAtual;
  }

  int getProximoMiniTabuleiroLinha() {
    return jogoLogica.proximoMiniTabuleiroLinha;
  }

  int getProximoMiniTabuleiroColuna() {
    return jogoLogica.proximoMiniTabuleiroColuna;
  }
}
