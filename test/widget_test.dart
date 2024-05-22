// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:superjogodavelha/main.dart';

void main() {
  testWidgets('Verifica se o título do app está correto', (WidgetTester tester) async {
    // Cria o widget do aplicativo e o renderiza
    await tester.pumpWidget(SuperJogoDaVelhaApp());

    // Verifica se o título do AppBar está presente e correto
    expect(find.text('Super Jogo da Velha'), findsOneWidget);
  });

  testWidgets('Verifica se o tabuleiro é exibido corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(SuperJogoDaVelhaApp());

    // Procura pelo GridView principal usando a chave
    expect(find.byKey(Key('tabuleiroPrincipal')), findsOneWidget);

    // Verifica se existem 9 mini tabuleiros (também GridViews)
    expect(find.byType(GridView), findsNWidgets(10)); // 1 principal + 9 mini

    // Verifica se cada mini tabuleiro tem 9 botões (ElevatedButton)
    expect(find.byType(ElevatedButton), findsNWidgets(81));
  });

  testWidgets('Verifica se os botões dos mini tabuleiros são clicáveis', (WidgetTester tester) async {
    await tester.pumpWidget(SuperJogoDaVelhaApp());

    // Encontra o primeiro botão do primeiro mini tabuleiro
    Finder botao = find.byType(ElevatedButton).first;

    // Verifica se o botão está habilitado (enabled)
    expect(tester.widget<ElevatedButton>(botao).enabled, isTrue);

    // Simula um toque no botão
    await tester.tap(botao);
    await tester.pump(); // Reconstrói a árvore de widgets para refletir as mudanças

    // Verifica se o texto do botão mudou (simula a marcação do jogador)
    // Neste caso, estamos assumindo que o primeiro jogador é 'X'
    expect(find.text('X'), findsOneWidget);
  });
}
