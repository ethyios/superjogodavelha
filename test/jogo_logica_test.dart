import 'package:flutter_test/flutter_test.dart';
import 'package:superjogodavelha/logica/jogo_logica.dart';

void main() {
  group('SuperJogoDaVelhaLogica - verificarVencedorSuperTabuleiro', () {
    late SuperJogoDaVelhaLogica logica;

    setUp(() {
      logica = SuperJogoDaVelhaLogica();
    });

    test('retorna vazio quando nao ha vencedor', () {
      expect(logica.verificarVencedorSuperTabuleiro(), '');

      logica.vencedoresMiniTabuleiros = [
        ['X', 'O', 'X'],
        ['O', 'X', 'O'],
        ['O', 'X', 'O']
      ];
      expect(logica.verificarVencedorSuperTabuleiro(), '');
    });

    test('retorna vencedor por linha', () {
      // Linha 1
      logica.vencedoresMiniTabuleiros = [
        ['X', 'X', 'X'],
        ['', '', ''],
        ['', '', '']
      ];
      expect(logica.verificarVencedorSuperTabuleiro(), 'X');

      // Linha 2
      logica.vencedoresMiniTabuleiros = [
        ['', '', ''],
        ['O', 'O', 'O'],
        ['', '', '']
      ];
      expect(logica.verificarVencedorSuperTabuleiro(), 'O');

      // Linha 3
      logica.vencedoresMiniTabuleiros = [
        ['', '', ''],
        ['', '', ''],
        ['X', 'X', 'X']
      ];
      expect(logica.verificarVencedorSuperTabuleiro(), 'X');
    });

    test('retorna vencedor por coluna', () {
      // Coluna 1
      logica.vencedoresMiniTabuleiros = [
        ['O', '', ''],
        ['O', '', ''],
        ['O', '', '']
      ];
      expect(logica.verificarVencedorSuperTabuleiro(), 'O');

      // Coluna 2
      logica.vencedoresMiniTabuleiros = [
        ['', 'X', ''],
        ['', 'X', ''],
        ['', 'X', '']
      ];
      expect(logica.verificarVencedorSuperTabuleiro(), 'X');

      // Coluna 3
      logica.vencedoresMiniTabuleiros = [
        ['', '', 'O'],
        ['', '', 'O'],
        ['', '', 'O']
      ];
      expect(logica.verificarVencedorSuperTabuleiro(), 'O');
    });

    test('retorna vencedor por diagonal', () {
      // Diagonal principal
      logica.vencedoresMiniTabuleiros = [
        ['X', '', ''],
        ['', 'X', ''],
        ['', '', 'X']
      ];
      expect(logica.verificarVencedorSuperTabuleiro(), 'X');

      // Diagonal secundaria
      logica.vencedoresMiniTabuleiros = [
        ['', '', 'O'],
        ['', 'O', ''],
        ['O', '', '']
      ];
      expect(logica.verificarVencedorSuperTabuleiro(), 'O');
    });

    test('retorna V (velha) caso um dos jogadores venca com mini tabuleiros que deram velha', () {
      // Exemplo de uma trinca de velhas (improvavel, mas testavel)
      logica.vencedoresMiniTabuleiros = [
        ['V', '', ''],
        ['', 'V', ''],
        ['', '', 'V']
      ];
      expect(logica.verificarVencedorSuperTabuleiro(), 'V');
    });
  });
}
