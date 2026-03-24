import pytest
from backend.engine.engine_mockup import Engine, InvalidMoveException

def test_jogada_invalida_turno_incorreto():
    """UC2: Oponente não pode jogar no turno do outro."""
    engine = Engine() # Começa com X
    with pytest.raises(InvalidMoveException, match="NotYourTurn"):
        engine.jogar(0, 0, 0, 0, "O")

def test_jogada_invalida_celula_ocupada():
    """UC2: Não pode jogar onde já tem peça."""
    engine = Engine()
    # Forçar o mock a ter uma célula ocupada temporariamente para este runtime test
    engine.macro_tabuleiro[0][0].celulas[0][0] = "X"
    
    with pytest.raises(InvalidMoveException, match="CellOccupied"):
        engine.jogar(0, 0, 0, 0, "X")

def test_jogada_invalida_mini_tabuleiro_restrito():
    """UC2: Não pode jogar ignorando a restrição de destino do oponente."""
    engine = Engine()
    engine.proximo_mini_tabuleiro_obrigatorio = (1, 1) # Bloqueado no Central
    
    with pytest.raises(InvalidMoveException, match="InvalidMiniBoard"):
        engine.jogar(0, 0, 0, 0, "X") # Tentativa Ilegal (0, 0) != (1, 1)

def test_jogada_valida_marca_simbolo():
    """UC3: Jogada válida grava a matrix corretamente."""
    engine = Engine()
    engine.jogar(0, 0, 2, 2, "X")
    
    # Valida estado de mutação após bypass da lógica
    assert engine.macro_tabuleiro[0][0].celulas[2][2] == "X"
    
def test_jogada_valida_altera_turno_e_define_restricao():
    """UC3: Rotaciona jogadores e encadeia local do próximo embate."""
    engine = Engine()
    assert engine.turno_atual == "X"
    assert engine.proximo_mini_tabuleiro_obrigatorio is None
    
    engine.jogar(0, 0, 1, 2, "X") # joga na sub-casa da linha do meio, canto direito
    
    assert engine.turno_atual == "O"
    assert engine.proximo_mini_tabuleiro_obrigatorio == (1, 2)
