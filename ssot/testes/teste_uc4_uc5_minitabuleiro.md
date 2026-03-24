# Documento de Teste: UC4 e UC5 - Estado do Mini-Tabuleiro

## Referência Base
- **Regras de Negócio:** Seção 2.1 (State Machine do Mini), Seção 3 Passo 5 (Passe Livre)
- **Casos de Uso:** UC4 (Vitória/Velha no Mini), UC5 (Passe Livre)

## Objetivo
Validar a detecção de vitória (linha, coluna, diagonal), velha (impasse) e a regra de escape (Passe Livre) no mini-tabuleiro.

## Conjunto de Testes (`test_uc4_uc5_minitabuleiro.py`)

| # | Teste | Verificação | Status TDD |
|---|---|---|---|
| 1 | `test_vitoria_mini_tabuleiro_linha` | 3 símbolos na mesma linha → `VENCIDO_X` | 🔴 RED |
| 2 | `test_vitoria_mini_tabuleiro_coluna` | 3 símbolos na mesma coluna → `VENCIDO_X` | 🔴 RED |
| 3 | `test_vitoria_mini_tabuleiro_diagonal` | 3 símbolos na diagonal → `VENCIDO_X` | 🔴 RED |
| 4 | `test_velha_mini_tabuleiro` | 9 jogadas sem trinca (via `jogar()`) → `EMPATADO` | 🔴 RED |
| 5 | `test_passe_livre_destino_vencido` | Destino `VENCIDO` → restrição vira `None` | 🔴 RED |
| 6 | `test_passe_livre_destino_empatado` | Destino `EMPATADO` → restrição vira `None` | 🔴 RED |
