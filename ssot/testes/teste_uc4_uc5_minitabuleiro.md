# Documento de Teste: UC4 e UC5 - Estado do Mini-Tabuleiro

> **⚠️ STATUS: RASCUNHO (Não-Canônico)** 
> *Aguardando oficialização após conclusão da implementação.*

## Objetivo
Atacar metodicamente três das regras mais vitais da matriz secundária (O Mini-Tabuleiro 3x3): A detecção de vitória contínua, detecção de Velha sem vitória (Impasse) e a cláusula de fuga do design de jogo.

## Conjunto de Testes (`test_uc4_uc5_minitabuleiro.py`)

1. **`test_vitoria_mini_tabuleiro_linha`**
   - **Mecânica:** Valida que as checagens elásticas da Engine conseguem varrer as linhas (com replicações em colunas e diagonais na versão final) rastreando e computando que três células `X` invocam uma interrupção de matriz limpa.
   - **Critério Testado:** `MiniTabuleiro.status == "VENCIDO_X"` seguido do bloqueio do quadrante.

2. **`test_velha_mini_tabuleiro`**
   - **Mecânica:** Confirma o impasse crítico (US1.6). O loop não quebrou por vitória, contudo as 9 indexações esgotaram de `"VAZIO"` para arrays preenchidos.
   - **Critério Testado:** O quadrante entra no estado passivo `MiniTabuleiro.status == "EMPATADO"`. Ninguém pontua.

3. **`test_regra_passe_livre`**
   - **Mecânica:** Testa a proteção Anti-Locking do Jogador Humano perante a Regra de Ouro. O pipeline de destino obrigatório depara-se com a parede do Inativo.
   - **Critério Testado:** `Engine.proximo_mini_tabuleiro_obrigatorio` é resetado para `None` ao final da transação, devolvendo soberania total de clique para o próximo turno.
