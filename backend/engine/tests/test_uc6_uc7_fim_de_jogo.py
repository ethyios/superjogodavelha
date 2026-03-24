import pytest
from backend.engine.engine_mockup import Engine


# =============================================================================
# UC6: Encerramento Antecipado (Alinhamento Global)
# =============================================================================

def test_vitoria_global_linha_horizontal():
    """UC6 / US1.7: Vence a partida ao alinhar 3 mini-tabuleiros na horizontal."""
    engine = Engine()

    # Simula conquista de 3 mini-tabuleiros na primeira linha do macro
    engine.macro_tabuleiro[0][0].status = "VENCIDO_X"
    engine.macro_tabuleiro[0][1].status = "VENCIDO_X"
    engine.macro_tabuleiro[0][2].status = "VENCIDO_X"

    resultado = engine.avaliar_macro_tabuleiro()

    assert resultado == "VITORIA_X", "Deveria declarar vitória de X por alinhamento horizontal"


def test_vitoria_global_coluna_vertical():
    """UC6 / US1.7: Vence a partida ao alinhar 3 mini-tabuleiros na vertical."""
    engine = Engine()

    engine.macro_tabuleiro[0][0].status = "VENCIDO_O"
    engine.macro_tabuleiro[1][0].status = "VENCIDO_O"
    engine.macro_tabuleiro[2][0].status = "VENCIDO_O"

    resultado = engine.avaliar_macro_tabuleiro()

    assert resultado == "VITORIA_O", "Deveria declarar vitória de O por alinhamento vertical"


def test_vitoria_global_diagonal():
    """UC6 / US1.7: Vence a partida ao alinhar 3 mini-tabuleiros na diagonal."""
    engine = Engine()

    engine.macro_tabuleiro[0][0].status = "VENCIDO_X"
    engine.macro_tabuleiro[1][1].status = "VENCIDO_X"
    engine.macro_tabuleiro[2][2].status = "VENCIDO_X"

    resultado = engine.avaliar_macro_tabuleiro()

    assert resultado == "VITORIA_X", "Deveria declarar vitória de X por alinhamento diagonal"


def test_vitoria_global_diagonal_secundaria():
    """UC6 / US1.7: Vence a partida ao alinhar 3 mini-tabuleiros na anti-diagonal."""
    engine = Engine()

    engine.macro_tabuleiro[0][2].status = "VENCIDO_O"
    engine.macro_tabuleiro[1][1].status = "VENCIDO_O"
    engine.macro_tabuleiro[2][0].status = "VENCIDO_O"

    resultado = engine.avaliar_macro_tabuleiro()

    assert resultado == "VITORIA_O", "Deveria declarar vitória de O por alinhamento anti-diagonal"


def test_jogo_em_andamento_sem_alinhamento():
    """UC6: Enquanto houver mini-tabuleiros ATIVOS e sem alinhamento, o jogo continua."""
    engine = Engine()

    engine.macro_tabuleiro[0][0].status = "VENCIDO_X"
    engine.macro_tabuleiro[1][1].status = "VENCIDO_O"
    # Restante permanece ATIVO

    resultado = engine.avaliar_macro_tabuleiro()

    assert resultado == "EM_ANDAMENTO", "Jogo deveria continuar em andamento"


# =============================================================================
# UC7: Encerramento por Esgotamento (Vitória por Pontos / Empate Absoluto)
# =============================================================================

def test_vitoria_por_pontos_x_lidera():
    """UC7 / US1.8: X vence por ter mais mini-tabuleiros conquistados."""
    engine = Engine()

    # Distribuição sem nenhuma trinca (horizontal, vertical ou diagonal):
    # X  O  E
    # O  X  O
    # X  E  X
    # Linhas: X-O-E, O-X-O, X-E-X → sem trinca
    # Colunas: X-O-X, O-X-E, E-O-X → sem trinca
    # Diag principal: X-X-X → TRINCA? Não! Precisa ser mesmo jogador.
    # Corrigido:
    # X  O  E
    # E  X  O
    # X  O  X
    # Linhas: X-O-E, E-X-O, X-O-X → sem trinca
    # Colunas: X-E-X, O-X-O, E-O-X → sem trinca
    # Diag principal: X-X-X → TRINCA! Ainda não serve.
    # Versão final validada:
    # O  X  E
    # X  E  O
    # X  O  X
    # Linhas: O-X-E, X-E-O, X-O-X → sem trinca
    # Colunas: O-X-X, X-E-O, E-O-X → sem trinca
    # Diag principal: O-E-X → sem trinca
    # Diag secundária: E-E-X → sem trinca
    engine.macro_tabuleiro[0][0].status = "VENCIDO_O"
    engine.macro_tabuleiro[0][1].status = "VENCIDO_X"
    engine.macro_tabuleiro[0][2].status = "EMPATADO"
    engine.macro_tabuleiro[1][0].status = "VENCIDO_X"
    engine.macro_tabuleiro[1][1].status = "EMPATADO"
    engine.macro_tabuleiro[1][2].status = "VENCIDO_O"
    engine.macro_tabuleiro[2][0].status = "VENCIDO_X"
    engine.macro_tabuleiro[2][1].status = "VENCIDO_O"
    engine.macro_tabuleiro[2][2].status = "VENCIDO_X"
    # X=4, O=3, Empate=2 -> X vence por pontos (sem trincas)

    resultado = engine.avaliar_macro_tabuleiro()

    assert resultado == "VITORIA_X", "X deveria vencer por pontos (4 vs 3)"


def test_vitoria_por_pontos_o_lidera():
    """UC7 / US1.8: O vence por ter mais mini-tabuleiros conquistados."""
    engine = Engine()

    # Distribuição sem nenhuma trinca (espelhamento do teste X):
    # X  O  E
    # O  E  X
    # O  X  O
    # Linhas: X-O-E, O-E-X, O-X-O → sem trinca
    # Colunas: X-O-O, O-E-X, E-X-O → sem trinca
    # Diag principal: X-E-O → sem trinca
    # Diag secundária: E-E-O → sem trinca
    engine.macro_tabuleiro[0][0].status = "VENCIDO_X"
    engine.macro_tabuleiro[0][1].status = "VENCIDO_O"
    engine.macro_tabuleiro[0][2].status = "EMPATADO"
    engine.macro_tabuleiro[1][0].status = "VENCIDO_O"
    engine.macro_tabuleiro[1][1].status = "EMPATADO"
    engine.macro_tabuleiro[1][2].status = "VENCIDO_X"
    engine.macro_tabuleiro[2][0].status = "VENCIDO_O"
    engine.macro_tabuleiro[2][1].status = "VENCIDO_X"
    engine.macro_tabuleiro[2][2].status = "VENCIDO_O"
    # O=4, X=3, Empate=2 -> O vence por pontos (sem trincas)

    resultado = engine.avaliar_macro_tabuleiro()

    assert resultado == "VITORIA_O", "O deveria vencer por pontos (4 vs 3)"


def test_empate_absoluto_pontuacoes_iguais():
    """UC7 / US1.8: Empate absoluto quando X e O têm a mesma quantidade de conquistas."""
    engine = Engine()

    engine.macro_tabuleiro[0][0].status = "VENCIDO_X"
    engine.macro_tabuleiro[0][1].status = "VENCIDO_O"
    engine.macro_tabuleiro[0][2].status = "EMPATADO"
    engine.macro_tabuleiro[1][0].status = "VENCIDO_O"
    engine.macro_tabuleiro[1][1].status = "VENCIDO_X"
    engine.macro_tabuleiro[1][2].status = "EMPATADO"
    engine.macro_tabuleiro[2][0].status = "VENCIDO_X"
    engine.macro_tabuleiro[2][1].status = "VENCIDO_O"
    engine.macro_tabuleiro[2][2].status = "EMPATADO"
    # X=3, O=3, Empate=3 -> EMPATE_ABSOLUTO

    resultado = engine.avaliar_macro_tabuleiro()

    assert resultado == "EMPATE_ABSOLUTO", "Deveria ser empate absoluto (3 vs 3)"
