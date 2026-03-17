import 'package:flutter_test/flutter_test.dart';
import 'package:superjogodavelha/controle/jogo_controle.dart';
import 'package:superjogodavelha/logica/jogo_ia.dart';

void main() {
  group('JogoIA Tests', () {
    late JogoController controller;
    late JogoIA jogoIA;

    setUp(() {
      controller = JogoController();
      jogoIA = controller.jogoIA;
      // Define a lower depth for testing to keep tests fast
      jogoIA.profundidadeMaxima = 2;
    });

    test('Initial properties are correct', () {
      expect(jogoIA.jogadorIA, 'O');
      expect(jogoIA.jogadorHumano, 'X');
    });

    test('fazerJogadaIA makes a move when possible', () {
      // Human plays at 0, 0, 0
      controller.fazerJogada(0, 0, 0, false);

      // Now it's AI's turn
      jogoIA.fazerJogadaIA();

      // Verify AI made a move
      bool aiMadeMove = false;
      var tabuleiro = controller.getTabuleiro();
      for (var linha in tabuleiro) {
        for (var col in linha) {
          if (col.contains('O')) {
            aiMadeMove = true;
            break;
          }
        }
      }
      expect(aiMadeMove, true);
    });

    test('avaliarLinhasColunasDiagonais counts correctly', () {
      var logica = controller.jogoLogica;
      // Set up a mini-board with 2 'O's in a row
      logica.tabuleiro[0][0][0] = 'O';
      logica.tabuleiro[0][0][1] = 'O';

      int count = jogoIA.avaliarLinhasColunasDiagonais(logica, 0, 0, 'O');
      expect(count, 1); // 0 and 1 match, so 1 pair
    });

    test('calcularPontuacao gives positive score for winning move', () {
      var logica = controller.jogoLogica;
      // Set up a winning condition for 'O' in mini-board 1,1
      logica.tabuleiro[1][1][0] = 'O';
      logica.tabuleiro[1][1][1] = 'O';
      // Pos 2 is the winning move

      // Simulate making the move temporarily
      logica.tabuleiro[1][1][2] = 'O';
      int score = jogoIA.calcularPontuacao(logica, 1, 1, 2);
      logica.tabuleiro[1][1][2] = '';

      // Score should be high (> 100) because it wins the mini-board
      expect(score, greaterThanOrEqualTo(100));
    });

    test('calcularPontuacao gives score for blocking human', () {
      var logica = controller.jogoLogica;
      // Set up a winning condition for 'X' in mini-board 2,2
      logica.tabuleiro[2][2][0] = 'X';
      logica.tabuleiro[2][2][1] = 'X';
      // Pos 2 is the winning move for 'X', so 'O' should block

      int score = jogoIA.calcularPontuacao(logica, 2, 2, 2);

      // Score should be positive because it prevents human from winning mini-board
      expect(score, greaterThanOrEqualTo(50));
    });

    test('max and min return correct values', () {
      expect(jogoIA.max(5, 10), 10);
      expect(jogoIA.max(-5, -10), -5);

      expect(jogoIA.min(5, 10), 5);
      expect(jogoIA.min(-5, -10), -10);
    });

    test('estadoTabuleiro returns a correct string representation', () {
      var logica = controller.jogoLogica;
      logica.tabuleiro[0][0][0] = 'X';
      logica.tabuleiro[1][1][4] = 'O';

      String estado = jogoIA.estadoTabuleiro(logica);

      // 'X' and 'O' are concatenated, length should be 2 because empty strings are just ''
      expect(estado.length, 2);
      expect(estado, 'XO');
    });

    test('escolherJogada returns -1 when board is full', () {
      var logica = controller.jogoLogica;
      // Fill the board completely with dummy strings to simulate full
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          for (int k = 0; k < 9; k++) {
            logica.tabuleiro[i][j][k] = 'A'; // 'A' acts as non-empty
          }
          logica.vencedoresMiniTabuleiros[i][j] = 'V'; // mark as won to skip
        }
      }

      int move = jogoIA.escolherJogada(logica);
      expect(move, -1);
    });

    test('minimax uses memoization correctly', () {
      var logica = controller.jogoLogica;
      // Provide an artificial state to memo to see if it reads it
      String estadoAtual = jogoIA.estadoTabuleiro(logica);
      jogoIA.memo[estadoAtual] = 42;

      int score = jogoIA.minimax(logica, 0, true, -1000, 1000);
      expect(score, 42); // Should return memoized value
    });

    test('minimax evaluates deep win or block efficiently', () {
      var logica = controller.jogoLogica;
      // Simple board state
      logica.tabuleiro[0][0][0] = 'X';

      // Should run quickly because depth is capped at 2 in setUp
      int score = jogoIA.minimax(logica, 0, true, -1000, 1000);
      // We don't necessarily know the exact score, but it should complete without timing out
      expect(score, isNotNull);
    });

  });
}
