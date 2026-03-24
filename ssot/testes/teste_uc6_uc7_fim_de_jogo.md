# Documento de Teste: UC6 e UC7 - Término de Jogo Global

## Referência Base
- **Regras de Negócio:** Seção 2.2 (State Machine do Macro), Seção 4.3 (Vitória por Pontos)
- **Casos de Uso:** UC6 (Alinhamento Global), UC7 (Esgotamento)

## Objetivo
Garantir que a Engine encerra a partida corretamente nos cenários de vitória por alinhamento, vitória por pontos e empate absoluto.

## Conjunto de Testes (`test_uc6_uc7_fim_de_jogo.py`)

| # | Teste | Verificação | Status TDD |
|---|---|---|---|
| 1 | `test_vitoria_global_linha_horizontal` | 3 minis `VENCIDO_X` na linha → `VITORIA_X` | 🔴 RED |
| 2 | `test_vitoria_global_coluna_vertical` | 3 minis `VENCIDO_O` na coluna → `VITORIA_O` | 🔴 RED |
| 3 | `test_vitoria_global_diagonal` | 3 minis `VENCIDO_X` na diagonal principal → `VITORIA_X` | 🔴 RED |
| 4 | `test_vitoria_global_diagonal_secundaria` | 3 minis `VENCIDO_O` na anti-diagonal → `VITORIA_O` | 🔴 RED |
| 5 | `test_jogo_em_andamento_sem_alinhamento` | 2 conquistas dispersas + ativos → `EM_ANDAMENTO` | 🔴 RED |
| 6 | `test_vitoria_por_pontos_x_lidera` | Todos finalizados, sem trinca, X=4 O=3 → `VITORIA_X` | 🔴 RED |
| 7 | `test_vitoria_por_pontos_o_lidera` | Todos finalizados, sem trinca, O=4 X=3 → `VITORIA_O` | 🔴 RED |
| 8 | `test_empate_absoluto_pontuacoes_iguais` | Todos finalizados, X=3 O=3 → `EMPATE_ABSOLUTO` | 🔴 RED |
