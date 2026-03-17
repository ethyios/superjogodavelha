import 'package:flutter_test/flutter_test.dart';
import 'package:superjogodavelha/controle/jogo_controle.dart';

void main() {
  group('JogoController', () {
    late JogoController jogoController;

    setUp(() {
      jogoController = JogoController();
    });

    test('Instanciação e valores iniciais', () {
      expect(jogoController.jogoLogica, isNotNull);
      expect(jogoController.jogoIA, isNotNull);
      expect(jogoController.jogoIA.jogoController, equals(jogoController));

      expect(jogoController.getJogadorAtual(), equals('X'));
      expect(jogoController.getProximoMiniTabuleiroLinha(), equals(-1));
      expect(jogoController.getProximoMiniTabuleiroColuna(), equals(-1));
      expect(jogoController.verificarVencedorSuperTabuleiro(), equals(''));
    });

    test('fazerJogada - modoIA false', () {
      jogoController.fazerJogada(0, 0, 0, false);

      // O jogador mudou de 'X' para 'O' porque a jogada foi feita
      expect(jogoController.getJogadorAtual(), equals('O'));

      // A posição do próximo mini tabuleiro agora é baseada na posição da jogada (0, que significa linha 0 e coluna 0)
      expect(jogoController.getProximoMiniTabuleiroLinha(), equals(0));
      expect(jogoController.getProximoMiniTabuleiroColuna(), equals(0));

      // Verificar se a jogada foi registrada no tabuleiro
      var tabuleiro = jogoController.getTabuleiro();
      expect(tabuleiro[0][0][0], equals('X'));
    });

    test('reiniciarJogo', () {
      // Faz uma jogada para alterar o estado inicial
      jogoController.fazerJogada(0, 0, 0, false);
      expect(jogoController.getJogadorAtual(), equals('O'));

      // Reinicia o jogo
      jogoController.reiniciarJogo();

      // Verifica se voltou aos valores iniciais
      expect(jogoController.getJogadorAtual(), equals('X'));
      expect(jogoController.getProximoMiniTabuleiroLinha(), equals(-1));
      expect(jogoController.getProximoMiniTabuleiroColuna(), equals(-1));

      var tabuleiro = jogoController.getTabuleiro();
      expect(tabuleiro[0][0][0], equals(''));
    });

    test('Delegações de métodos', () {
      // Verifica o tabuleiro inicial vazio
      var tabuleiro = jogoController.getTabuleiro();
      expect(tabuleiro.length, equals(3));
      expect(tabuleiro[0].length, equals(3));
      expect(tabuleiro[0][0].length, equals(9));

      // Verifica os vencedores dos mini tabuleiros (tudo vazio)
      var vencedores = jogoController.getVencedoresMiniTabuleiros();
      expect(vencedores.length, equals(3));
      expect(vencedores[0].length, equals(3));
      expect(vencedores[0][0], equals(''));

      // Vencedor do super tabuleiro vazio no início
      expect(jogoController.verificarVencedorSuperTabuleiro(), equals(''));
    });
  });
}
