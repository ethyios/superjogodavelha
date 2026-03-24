# Documento de Teste: UC1 - Inicialização

> **⚠️ STATUS: RASCUNHO (Não-Canônico)** 
> *Este documento descreve os testes de inicialização da Engine e aguarda oficialização (Momento Canônico).*

## Referência Base
- **Histórias de Usuário:** US1.1, US1.10
- **Caso de Uso:** UC1

## Objetivo
Ratificar que a abstração `Engine`, quando instanciada, inicia corretamente a partida no seu Estado Zero absoluto.

## Conjunto de Testes (`test_uc1_inicializacao.py`)

1. **`test_engine_initializes_with_player_x`**
   - **Verificação:** Valida a Regra 4.1 de Negócio de que o construtor atribui a vez de jogar obrigatoriamente para a string `"X"`.
   - **Critério Testado:** `engine.turno_atual == "X"`

2. **`test_engine_initializes_without_restrictions`**
   - **Verificação:** Valida que o primeiro turno é livre, ou seja, nenhum mini-tabuleiro está marcado como destino obrigatório (Null Constraint).
   - **Critério Testado:** `engine.proximo_mini_tabuleiro_obrigatorio is None`

3. **`test_engine_initializes_9_empty_miniboards`**
   - **Verificação:** O Macro-Tabuleiro nasce composto por uma simetria `3x3` contendo as instâncias de Mini-Tabuleiros. Todos os Mini-Tabuleiros devem ser iniciados com status = `"ATIVO"` e contendo uma submatriz de 9 células em estado `"VAZIO"`.
   - **Critério Testado:** Matrix size checks e string constraints.
