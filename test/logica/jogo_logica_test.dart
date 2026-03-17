import 'package:flutter_test/flutter_test.dart';
import 'package:superjogodavelha/logica/jogo_logica.dart';

void main() {
  group('SuperJogoDaVelhaLogica - verificarVencedorMiniTabuleiro', () {
    late SuperJogoDaVelhaLogica logica;

    setUp(() {
      logica = SuperJogoDaVelhaLogica();
    });

    // Helper para preencher um mini tabuleiro especifico para testes
    void preencherMini(int linha, int coluna, List<String> posicoes) {
      assert(posicoes.length == 9);
      for (int i = 0; i < 9; i++) {
        logica.tabuleiro[linha][coluna][i] = posicoes[i];
      }
    }

    test('Vitória horizontal linha 1', () {
      preencherMini(0, 0, [
        'X', 'X', 'X',
        '', '', '',
        '', '', ''
      ]);
      expect(logica.verificarVencedorMiniTabuleiro(0, 0), 'X');
    });

    test('Vitória horizontal linha 2', () {
      preencherMini(1, 1, [
        '', '', '',
        'O', 'O', 'O',
        '', '', ''
      ]);
      expect(logica.verificarVencedorMiniTabuleiro(1, 1), 'O');
    });

    test('Vitória horizontal linha 3', () {
      preencherMini(2, 2, [
        '', '', '',
        '', '', '',
        'X', 'X', 'X'
      ]);
      expect(logica.verificarVencedorMiniTabuleiro(2, 2), 'X');
    });

    test('Vitória vertical coluna 1', () {
      preencherMini(0, 1, [
        'O', '', '',
        'O', '', '',
        'O', '', ''
      ]);
      expect(logica.verificarVencedorMiniTabuleiro(0, 1), 'O');
    });

    test('Vitória vertical coluna 2', () {
      preencherMini(1, 0, [
        '', 'X', '',
        '', 'X', '',
        '', 'X', ''
      ]);
      expect(logica.verificarVencedorMiniTabuleiro(1, 0), 'X');
    });

    test('Vitória vertical coluna 3', () {
      preencherMini(2, 0, [
        '', '', 'O',
        '', '', 'O',
        '', '', 'O'
      ]);
      expect(logica.verificarVencedorMiniTabuleiro(2, 0), 'O');
    });

    test('Vitória diagonal principal', () {
      preencherMini(0, 2, [
        'X', '', '',
        '', 'X', '',
        '', '', 'X'
      ]);
      expect(logica.verificarVencedorMiniTabuleiro(0, 2), 'X');
    });

    test('Vitória diagonal secundária', () {
      preencherMini(1, 2, [
        '', '', 'O',
        '', 'O', '',
        'O', '', ''
      ]);
      expect(logica.verificarVencedorMiniTabuleiro(1, 2), 'O');
    });

    test('Tabuleiro vazio (sem vencedor)', () {
      preencherMini(0, 0, [
        '', '', '',
        '', '', '',
        '', '', ''
      ]);
      expect(logica.verificarVencedorMiniTabuleiro(0, 0), '');
    });

    test('Tabuleiro incompleto (sem vencedor)', () {
      preencherMini(2, 1, [
        'X', 'O', 'X',
        '', 'X', 'O',
        'O', '', ''
      ]);
      expect(logica.verificarVencedorMiniTabuleiro(2, 1), '');
    });

    test('Empate (Deu velha, retorna "V")', () {
      preencherMini(1, 1, [
        'X', 'O', 'X',
        'X', 'O', 'O',
        'O', 'X', 'X'
      ]);
      expect(logica.verificarVencedorMiniTabuleiro(1, 1), 'V');
    });

  });
}
