import 'package:test/test.dart';
import 'package:superjogodavelha/logica/jogo_logica.dart';
import 'package:superjogodavelha/controle/jogo_controle.dart';
import 'package:superjogodavelha/logica/jogo_ia.dart';

void main() {
  group('JogoIA - calcularPontuacao', () {
    late JogoController jogoController;
    late SuperJogoDaVelhaLogica jogoLogica;
    late JogoIA jogoIA;

    setUp(() {
      jogoController = JogoController();
      jogoLogica = jogoController.jogoLogica;
      jogoIA = jogoController.jogoIA;
    });

    test('should return positive score if the move wins a mini board for IA', () {
      int linha = 0;
      int coluna = 0;
      int posicao = 2; // Move that will win the board

      // Simulate that the IA ('O') is about to win the mini board on top row
      jogoLogica.tabuleiro[linha][coluna][0] = 'O';
      jogoLogica.tabuleiro[linha][coluna][1] = 'O';
      jogoLogica.tabuleiro[linha][coluna][posicao] = 'O'; // The winning move

      int score = jogoIA.calcularPontuacao(jogoLogica, linha, coluna, posicao);

      // 100 for winning + 20 for lines (0-1 and 1-2).
      expect(score, 120);
    });

    test('should return 0 when Human winning move evaluates to cancelled score due to block logic', () {
      int linha = 0;
      int coluna = 0;
      int posicao = 2;

      // Assume X made a winning move at 2 (minimax evaluates human moves too)
      jogoLogica.tabuleiro[linha][coluna][0] = 'X';
      jogoLogica.tabuleiro[linha][coluna][1] = 'X';
      jogoLogica.tabuleiro[linha][coluna][posicao] = 'X';

      // If we calculate score for O playing elsewhere (e.g., 8),
      // it sees X already won (-50), but then block logic sets 8 to X,
      // sees X wins again, and adds +50, cancelling it out to 0.
      int score = jogoIA.calcularPontuacao(jogoLogica, linha, coluna, 8);

      expect(score, 0);
    });

    test('should return +50 + bonus if the move blocks Human from winning', () {
      int linha = 0;
      int coluna = 0;
      int posicao = 2; // The blocking move

      // Simulate X is about to win on top row (0,1), and O blocks at 2.
      jogoLogica.tabuleiro[linha][coluna][0] = 'X';
      jogoLogica.tabuleiro[linha][coluna][1] = 'X';
      jogoLogica.tabuleiro[linha][coluna][posicao] = 'O'; // O plays at 2

      int score = jogoIA.calcularPontuacao(jogoLogica, linha, coluna, posicao);

      // 50 for blocking + 0 for lines.
      expect(score, 50);
    });

    test('should return correct bonus for creating lines/cols/diagonals', () {
      int linha = 1;
      int coluna = 1;

      // Put O at 0 and 1.
      jogoLogica.tabuleiro[linha][coluna][0] = 'O';
      jogoLogica.tabuleiro[linha][coluna][1] = 'O';

      int score1 = jogoIA.calcularPontuacao(jogoLogica, linha, coluna, 1);
      // Lines: (0,1) -> 1
      expect(score1, 10);

      // Add O at 4.
      jogoLogica.tabuleiro[linha][coluna][4] = 'O';

      int score2 = jogoIA.calcularPontuacao(jogoLogica, linha, coluna, 4);
      // Lines: (0,1), (1,4), (0,4) -> 3
      expect(score2, 30);
    });

    test('should return 0 for an empty board move', () {
      int linha = 2;
      int coluna = 2;
      int posicao = 4;

      jogoLogica.tabuleiro[linha][coluna][posicao] = 'O';
      int score = jogoIA.calcularPontuacao(jogoLogica, linha, coluna, posicao);

      expect(score, 0);
    });
  });
}
