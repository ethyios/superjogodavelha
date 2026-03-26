# Documento de Teste: UC1 - Inicialização

## Referência Base
- **Histórias de Usuário:** US1.1, US1.9
- **Caso de Uso:** UC1

## Objetivo
Ratificar que a abstração `Engine`, quando instanciada, inicia corretamente a partida no seu Estado Zero absoluto.

## Conjunto de Testes (`test_uc1_inicializacao.py`)

| # | Teste | Verificação | Status TDD |
|---|---|---|---|
| 1 | `test_engine_initializes_with_player_x` | Regra 4.1 — turno inicial é `"X"` | ✅ GREEN |
| 2 | `test_engine_initializes_without_restrictions` | Sem restrição de destino no início (`None`) | ✅ GREEN |
| 3 | `test_engine_initializes_9_empty_miniboards` | Todos os 9 mini-tabuleiros são `ATIVO` com 9 células `VAZIO` | ✅ GREEN |
