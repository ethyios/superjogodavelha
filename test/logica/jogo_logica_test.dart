import 'package:flutter_test/flutter_test.dart';
import 'package:superjogodavelha/logica/jogo_logica.dart';

void main() {
  group('SuperJogoDaVelhaLogica', () {
    test('fazerJogada should not change the state if position is already filled', () {
      final logica = SuperJogoDaVelhaLogica();

      // Make the first move
      logica.fazerJogada(0, 0, 0);
      expect(logica.tabuleiro[0][0][0], 'X');
      expect(logica.jogadorAtual, 'O');
      expect(logica.primeiroTurno, false);

      // Try to make a move on the same position
      logica.fazerJogada(0, 0, 0);

      // The state should remain the same
      expect(logica.tabuleiro[0][0][0], 'X');
      expect(logica.jogadorAtual, 'O');
    });

    test('fazerJogada should not change the state if mini board is already won', () {
      final logica = SuperJogoDaVelhaLogica();

      // Simulate a won mini-board
      logica.vencedoresMiniTabuleiros[1][1] = 'X';

      // Try to make a move on the won mini-board
      logica.fazerJogada(1, 1, 4);

      // The state should remain the same
      expect(logica.tabuleiro[1][1][4], '');
      expect(logica.jogadorAtual, 'X');
    });
  });
}
