# Documento de Teste: UC6 e UC7 - Término de Jogo Global

> **⚠️ STATUS: RASCUNHO (Não-Canônico)**

## Objetivo
Garantir que o sistema encerra a partida corretamente nos dois cenários possíveis: vitória por alinhamento de mini-tabuleiros (trinca) ou vitória por pontos quando o tabuleiro esgota sem trincas.

## Conjunto de Testes (`test_uc6_uc7_fim_de_jogo.py`)

### UC6: Vitória por Alinhamento Global

1. **`test_vitoria_global_linha_horizontal`**
   - **Mecânica:** Configura 3 mini-tabuleiros `VENCIDO_X` na linha 0 do macro.
   - **Critério:** `avaliar_macro_tabuleiro()` retorna `"VITORIA_X"`.

2. **`test_vitoria_global_coluna_vertical`**
   - **Mecânica:** Configura 3 mini-tabuleiros `VENCIDO_O` na coluna 0 do macro.
   - **Critério:** `avaliar_macro_tabuleiro()` retorna `"VITORIA_O"`.

3. **`test_vitoria_global_diagonal`**
   - **Mecânica:** Configura 3 mini-tabuleiros `VENCIDO_X` na diagonal principal.
   - **Critério:** `avaliar_macro_tabuleiro()` retorna `"VITORIA_X"`.

4. **`test_jogo_em_andamento_sem_alinhamento`**
   - **Mecânica:** Apenas 2 conquistas sem alinhamento e mini-tabuleiros `ATIVO` restantes.
   - **Critério:** `avaliar_macro_tabuleiro()` retorna `"EM_ANDAMENTO"`.

### UC7: Esgotamento (Vitória por Pontos)

5. **`test_vitoria_por_pontos_x_lidera`**
   - **Mecânica:** Todos os 9 mini-tabuleiros finalizados, sem trinca. X=5, O=2, Empate=2.
   - **Critério:** `avaliar_macro_tabuleiro()` retorna `"VITORIA_X"`.

6. **`test_vitoria_por_pontos_o_lidera`**
   - **Mecânica:** Todos finalizados. O=5, X=2, Empate=2.
   - **Critério:** `avaliar_macro_tabuleiro()` retorna `"VITORIA_O"`.

7. **`test_empate_absoluto_pontuacoes_iguais`**
   - **Mecânica:** Todos finalizados. X=3, O=3, Empate=3 (cenário raro).
   - **Critério:** `avaliar_macro_tabuleiro()` retorna `"EMPATE_ABSOLUTO"`.
