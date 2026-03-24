# Mockup da Engine (TDD Phase)
# Servindo apenas para não quebrar a importação estrutural dos testes iniciais.

class MiniTabuleiroMock:
    def __init__(self):
        self.status = "ATIVO"
        self.celulas = [
            ["VAZIO", "VAZIO", "VAZIO"],
            ["VAZIO", "VAZIO", "VAZIO"],
            ["VAZIO", "VAZIO", "VAZIO"]
        ]

class InvalidMoveException(Exception):
    pass

class Engine:
    def __init__(self):
        self.turno_atual = "X"
        self.proximo_mini_tabuleiro_obrigatorio = None
        
        # Gerando Matriz 3x3 de MiniTabuleiros mock
        self.macro_tabuleiro = [
            [MiniTabuleiroMock(), MiniTabuleiroMock(), MiniTabuleiroMock()],
            [MiniTabuleiroMock(), MiniTabuleiroMock(), MiniTabuleiroMock()],
            [MiniTabuleiroMock(), MiniTabuleiroMock(), MiniTabuleiroMock()]
        ]

    def jogar(self, linha_macro, coluna_macro, linha_mini, coluna_mini, jogador):
        pass

    def avaliar_macro_tabuleiro(self):
        pass
