# Documento de Teste: UC2 e UC3 - Validação de Jogadas

## Referência Base
- **Regras de Negócio:** Seção 3 (Fluxo de Validação — Passos 1 a 5)
- **Casos de Uso:** UC2 (Jogada Inválida), UC3 (Jogada Válida)

## Objetivo
Atestar o pipeline de segurança da Engine: rejeição de jogadas inválidas (sem punição) e aceitação/aplicação de jogadas válidas.

## Conjunto de Testes (`test_uc2_uc3_jogadas.py`)

| # | Teste | Verificação | Status TDD |
|---|---|---|---|
| 1 | `test_jogada_invalida_turno_incorreto` | Passo 1 — lança `InvalidMoveException("NotYourTurn")` | 🔴 RED |
| 2 | `test_jogada_invalida_celula_ocupada` | Passo 3 — lança `InvalidMoveException("CellOccupied")` | 🔴 RED |
| 3 | `test_jogada_invalida_mini_tabuleiro_restrito` | Passo 2 — lança `InvalidMoveException("InvalidMiniBoard")` | 🔴 RED |
| 4 | `test_jogada_valida_marca_simbolo` | Passo 4 — célula recebe o símbolo do jogador | 🔴 RED |
| 5 | `test_jogada_valida_altera_turno` | Turno alterna para o oponente após jogada | 🔴 RED |
| 6 | `test_jogada_valida_define_restricao_destino` | Passo 5 — coordenada mini define a restrição para o próximo turno | 🔴 RED |
