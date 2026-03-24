import pytest
from backend.engine.engine_mockup import Engine

def test_engine_initializes_with_player_x():
    """
    US1.10 / Regra 4.1: O primeiro jogador deve ser o 'X'
    """
    engine = Engine()
    assert engine.turno_atual == "X", "A partida não iniciou com o jogador X"

def test_engine_initializes_without_restrictions():
    """
    US1.1: O primeiro turno não tem restrição de mini-tabuleiro (Passe Livre total)
    """
    engine = Engine()
    assert engine.proximo_mini_tabuleiro_obrigatorio is None, "A partida não deve ter restrição de destino no primeiro turno"

def test_engine_initializes_9_empty_miniboards():
    """
    US1.1: O tabuleiro deve ser formado por 9 mini tabuleiros,
    todos com status ATIVO e matrizes vazias.
    """
    engine = Engine()
    assert len(engine.macro_tabuleiro) == 3, "O macro-tabuleiro não tem 3 linhas"
    assert len(engine.macro_tabuleiro[0]) == 3, "O macro-tabuleiro não tem 3 colunas"
    
    for linha in range(3):
        for coluna in range(3):
            mini = engine.macro_tabuleiro[linha][coluna]
            assert mini.status == "ATIVO", f"Mini-tabuleiro [{linha}][{coluna}] não iniciou ATIVO"
            assert len(mini.celulas) == 3, f"Mini-tabuleiro [{linha}][{coluna}] não tem 3 linhas de células"
            for cl in range(3):
                for cc in range(3):
                    assert mini.celulas[cl][cc] == "VAZIO", f"Célula [{cl}][{cc}] do mini [{linha}][{coluna}] não está VAZIA"
