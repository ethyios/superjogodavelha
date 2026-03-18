import 'package:flutter_test/flutter_test.dart';
import 'package:superjogodavelha/controle/jogo_controle.dart';
import 'package:superjogodavelha/logica/jogo_ia.dart';
import 'package:superjogodavelha/logica/jogo_logica.dart';

void main() {
  group('JogoIA Tests', () {
    late JogoController controller;
    late JogoIA ia;
    late SuperJogoDaVelhaLogica logica;

    setUp(() {
      controller = JogoController();
      ia = controller.jogoIA;
      ia.profundidadeMaxima = 1;
      logica = controller.jogoLogica;
    });

    test('avaliarPosicoesNoMiniTabuleiro should return a move if it exists', () {
      var (jogada, valor) = ia.avaliarPosicoesNoMiniTabuleiro(logica, 0, 0, -1001);
      expect(jogada, isNot(-1));
    });

    test('escolherJogada should pick a winning move if available', () {
      logica.proximoMiniTabuleiroLinha = 0;
      logica.proximoMiniTabuleiroColuna = 0;
      logica.tabuleiro[0][0][0] = 'O';
      logica.tabuleiro[0][0][1] = 'O';

      int jogada = ia.escolherJogada(logica);
      expect(jogada, 2);
    });

    test('escolherJogada should pick the best move across all mini-tabuleiros', () {
      logica.reiniciarJogo();
      ia.profundidadeMaxima = 1;
      logica.proximoMiniTabuleiroLinha = -1;
      logica.proximoMiniTabuleiroColuna = -1;
      logica.tabuleiro[0][0][0] = 'O';
      logica.tabuleiro[0][0][1] = 'O';

      int jogada = ia.escolherJogada(logica);
      expect(jogada, 2);
    });
  });
}
