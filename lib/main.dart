import 'package:flutter/material.dart';

void main() {
  runApp(SuperJogoDaVelhaApp());
}

class SuperJogoDaVelhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SuperJogoDaVelhaPage(),
    );
  }
}

class SuperJogoDaVelhaPage extends StatefulWidget {
  @override
  _SuperJogoDaVelhaPageState createState() => _SuperJogoDaVelhaPageState();
}

class _SuperJogoDaVelhaPageState extends State<SuperJogoDaVelhaPage> {
  List<List<List<String>>> _tabuleiro =
      List.generate(3, (_) => List.generate(3, (_) => List.filled(9, '')));
  String _jogadorAtual = 'X';

  void _fazerJogada(int linha, int coluna, int posicao) {
  if (_tabuleiro[linha][coluna][posicao] != '') return; // Impede jogar em casa ocupada

  setState(() {
    List<List<List<String>>> novoTabuleiro = List.from(_tabuleiro); // Cria uma cópia
    novoTabuleiro[linha][coluna][posicao] = _jogadorAtual;
    _tabuleiro = novoTabuleiro; // Atualiza o estado com a nova lista
    _jogadorAtual = (_jogadorAtual == 'X') ? 'O' : 'X';
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Super Jogo da Velha'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView.count(
          key: Key('tabuleiroPrincipal'), // Adiciona uma chave única
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(9, (index) {
            int linha = index ~/ 3;
            int coluna = index % 3;
            return _buildMiniTabuleiro(linha, coluna);
          }),
        ),
      ),
    );
  }

  Widget _buildMiniTabuleiro(int linha, int coluna) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 2),
    ),
    child: GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(9, (index) {
        int posicao = index;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // Borda arredondada
            border: Border.all(color: Colors.black, width: 1), 
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _getCorCelula(linha, coluna),
              shape: RoundedRectangleBorder( // Borda arredondada do botão
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(20),
            ),
            onPressed: () => _fazerJogada(linha, coluna, posicao),
            child: Text(
              _tabuleiro[linha][coluna][posicao],
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      }),
    ),
  );
}

  Color _getCorCelula(int linha, int coluna) {
  // Cores pastel mais claras (aproximadamente 30% mais claras)
  List<Color> cores = [
    Color.fromRGBO(225, 245, 254, 1), // Azul claro
    Color.fromRGBO(224, 250, 224, 1), // Verde claro
    Color.fromRGBO(255, 228, 225, 1), // Rosa claro
    Color.fromRGBO(255, 242, 204, 1), // Laranja claro
    Color.fromRGBO(240, 230, 245, 1), // Roxo claro
    Color.fromRGBO(255, 255, 224, 1), // Amarelo claro
    Color.fromRGBO(204, 245, 240, 1), // Teal claro
    Color.fromRGBO(245, 222, 179, 1), // Marrom claro
    Color.fromRGBO(240, 240, 240, 1), // Cinza claro
  ];
  return cores[linha * 3 + coluna];
}
}