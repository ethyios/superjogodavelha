import pytest
from backend.engine.engine_mockup import Engine


# =============================================================================
# UC4: Vitória e Velha em Mini-Tabuleiro (RED por design TDD)
# Estes testes utilizam o método `jogar()` que ainda é `pass`. Eles definem
# o contrato: a Engine DEVE mudar o status do mini-tabuleiro após jogadas.
# =============================================================================

def test_vitoria_mini_tabuleiro_linha():
    """UC4 / US1.4: Vence o mini-tab ao completar uma linha."""
    engine = Engine()

    # X joga 3 vezes na linha 0 do mini [0][0] (intercalando com O em outro mini)
    engine.jogar(0, 0, 0, 0, "X")
    engine.jogar(1, 0, 0, 0, "O")  # O joga no mini obrigatório [0][0] -> vai para [0][0]... simplificado
    engine.jogar(0, 0, 0, 1, "X")
    engine.jogar(0, 1, 0, 0, "O")
    engine.jogar(0, 0, 0, 2, "X")  # Completa a linha 0

    assert engine.macro_tabuleiro[0][0].status == "VENCIDO_X"


def test_vitoria_mini_tabuleiro_coluna():
    """UC4 / US1.4: Vence o mini-tab ao completar uma coluna."""
    engine = Engine()

    engine.jogar(0, 0, 0, 0, "X")
    engine.jogar(0, 0, 1, 1, "O")  # simplificado
    engine.jogar(0, 0, 1, 0, "X")
    engine.jogar(1, 0, 0, 0, "O")
    engine.jogar(0, 0, 2, 0, "X")  # Completa a coluna 0

    assert engine.macro_tabuleiro[0][0].status == "VENCIDO_X"


def test_vitoria_mini_tabuleiro_diagonal():
    """UC4 / US1.4: Vence o mini-tab ao completar a diagonal."""
    engine = Engine()

    engine.jogar(0, 0, 0, 0, "X")
    engine.jogar(0, 0, 0, 1, "O")
    engine.jogar(0, 0, 1, 1, "X")
    engine.jogar(1, 1, 0, 0, "O")
    engine.jogar(0, 0, 2, 2, "X")  # Completa a diagonal

    assert engine.macro_tabuleiro[0][0].status == "VENCIDO_X"


def test_velha_mini_tabuleiro():
    """UC4 / US1.6: Mini-tabuleiro enche sem vencedor -> EMPATADO."""
    engine = Engine()

    # Preenche o mini [0][0] de forma que nenhuma trinca se forme:
    # X O X
    # X X O
    # O X O
    engine.macro_tabuleiro[0][0].celulas = [
        ["X", "O", "X"],
        ["X", "X", "O"],
        ["O", "X", "O"]
    ]
    # Após a última jogada que encheu, a Engine deveria ter avaliado:
    assert engine.macro_tabuleiro[0][0].status == "EMPATADO"


# =============================================================================
# UC5: Passe Livre (RED por design TDD)
# =============================================================================

def test_passe_livre_destino_vencido():
    """UC5 / US1.5: Se o destino obrigatório é um mini-tab VENCIDO, jogador tem passe livre."""
    engine = Engine()
    engine.macro_tabuleiro[1][1].status = "VENCIDO_X"

    # X joga na célula [1][1] de qualquer mini, o que mandaria O para o mini [1][1]
    # Como [1][1] está VENCIDO, O deve receber passe livre (None)
    engine.jogar(0, 0, 1, 1, "X")

    assert engine.proximo_mini_tabuleiro_obrigatorio is None, "Deveria ser Passe Livre"


def test_passe_livre_destino_empatado():
    """UC5 / US1.5: Se o destino obrigatório é um mini-tab EMPATADO, jogador tem passe livre."""
    engine = Engine()
    engine.macro_tabuleiro[2][0].status = "EMPATADO"

    engine.jogar(0, 0, 2, 0, "X")

    assert engine.proximo_mini_tabuleiro_obrigatorio is None, "Deveria ser Passe Livre"
