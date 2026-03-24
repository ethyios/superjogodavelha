# Documento de Teste: UC2 e UC3 - Validação de Jogadas 

> **⚠️ STATUS: RASCUNHO (Não-Canônico)** 
> *Aguardando oficialização após conclusão da escrita teórica dos testes e transbordamento unânime.*

## Objetivo
Firmar documentação teórica para atestar o pipeline de segurança que as `Regras de Negócio: Seção 3 (Fluxo de Validação de Jogada)` instituem na nossa Engine TDD.

## Conjunto de Testes (`test_uc2_uc3_jogadas.py`)

1. **`test_jogada_invalida_turno_incorreto`**
   - **Mecânica:** Intercepta envio manual e criminoso de pacotes/clicks quando o ator não detém a vez ('X' joga após 'X' ou vice versa).
   - **Critério Testado:** `Exception` lançada. Falhou no Passo 1 da Validação. Status de Partida imutável no descarte.

2. **`test_jogada_invalida_celula_ocupada`**
   - **Mecânica:** Resta garantido que um símbolo já posicionado é inalterável via inputs corriqueiros.
   - **Critério Testado:** Exception atrelada ao Passo 3 lança falha restrita (`CellOccupied`).

3. **`test_jogada_invalida_mini_tabuleiro_restrito`**
   - **Mecânica:** Ratifica que "A Regra de Ouro do Super Jogo" funciona e barra jogadas fora do raio demarcado pela variável `proximo_mini_tabuleiro_obrigatorio`.

4. **`test_jogada_valida_marca_simbolo`**
   - **Mecânica:** Testa Passos de 1 a 4 com sucesso absoluto. Marcação persistente no Array.

5. **`test_jogada_valida_altera_turno_e_define_restricao`**
   - **Mecânica:** Ratifica Passo 5. Após um Input Válido que altera a State Machine, a coord-filha (Submatriz-Y, Submatriz-X) deve preencher a variável de restrição que aprisiona o Turno seguinte.
