import pytest
from backend.engine.engine_mockup import Engine, InvalidMoveException


# =============================================================================
# UC2: Jogadas Inválidas (Todos estes testes estão RED por design TDD)
# O mockup `jogar()` é um `pass`. Estes testes definem o CONTRATO que a
# implementação real DEVE cumprir. Eles falharão até que o código real exista.
# =============================================================================

def test_jogada_invalida_turno_incorreto():
    """UC2 / Regra 3 Passo 1: Oponente não pode jogar no turno do outro."""
    engine = Engine()  # Começa com X
    with pytest.raises(InvalidMoveException, match="NotYourTurn"):
        engine.jogar(0, 0, 0, 0, "O")


def test_jogada_invalida_celula_ocupada():
    """UC2 / Regra 3 Passo 3: Não pode jogar onde já tem peça."""
    engine = Engine()
    engine.macro_tabuleiro[0][0].celulas[0][0] = "X"

    with pytest.raises(InvalidMoveException, match="CellOccupied"):
        engine.jogar(0, 0, 0, 0, "X")


def test_jogada_invalida_mini_tabuleiro_restrito():
    """UC2 / Regra 3 Passo 2: Não pode jogar ignorando a restrição de destino."""
    engine = Engine()
    engine.proximo_mini_tabuleiro_obrigatorio = (1, 1)

    with pytest.raises(InvalidMoveException, match="InvalidMiniBoard"):
        engine.jogar(0, 0, 0, 0, "X")  # (0, 0) != (1, 1)


# =============================================================================
# UC3: Jogadas Válidas (Também RED por design TDD)
# =============================================================================

def test_jogada_valida_marca_simbolo():
    """UC3 / Regra 3 Passo 4: Jogada válida grava o símbolo na célula."""
    engine = Engine()
    engine.jogar(0, 0, 2, 2, "X")

    assert engine.macro_tabuleiro[0][0].celulas[2][2] == "X"


def test_jogada_valida_altera_turno():
    """UC3: Após jogada válida, o turno deve alternar para o oponente."""
    engine = Engine()
    engine.jogar(0, 0, 1, 2, "X")

    assert engine.turno_atual == "O"


def test_jogada_valida_define_restricao_destino():
    """UC3 / Regra 3 Passo 5: A coordenada mini da jogada define o próximo destino obrigatório."""
    engine = Engine()
    engine.jogar(0, 0, 1, 2, "X")

    assert engine.proximo_mini_tabuleiro_obrigatorio == (1, 2)
