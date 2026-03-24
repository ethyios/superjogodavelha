# Regras de Negócio (Core Engine)

Este documento dita o comportamento matemático e lógico inflexível que será implementado na Engine. Qualquer ambiguidade na programação deve ser resolvida retornando a este texto.

## 1. Topologia do Jogo
- O "Macro-Tabuleiro" é uma matriz `3x3`.
- Dentro de cada célula do macro-tabuleiro, existe um "Mini-Tabuleiro" que é também uma matriz `3x3`.
- Portanto, existem 9 mini-tabuleiros (numerados conceitualmente de 0 a 8 ou representados por coords `[X][Y]`), totalizando 81 casas individuais.

## 2. Máquina de Estados

### 2.1 Mini-Tabuleiro (Estado Isolado)
Cada mini-tabuleiro individual só pode estar em um dos 4 estados abaixo:
1. `ATIVO`: Jogo está correndo, possui casas vazias e nenhum jogador fez linha/trinca.
2. `VENCIDO_X`: Jogador X fez uma linha.
3. `VENCIDO_O`: Jogador O fez uma linha.
4. `EMPATADO` ("Velha"): Nenhuma linha foi feita e não há mais espaços vazios (9 jogadas ocorreram).

*Ordem de Avaliação:* Logo após um input, a Engine verifica `Vitória`. Se houver linha, vira `VENCIDO`. Se não houver linha E o espaço está cheio, vira `EMPATADO`.

### 2.2 Macro-Tabuleiro (Partida)
1. `EM_ANDAMENTO`: Jogo corrente em turnos alternados.
2. `VITORIA_X`: X alinhou 3 mini-tabuleiros que estão em estado `VENCIDO_X`.
3. `VITORIA_O`: O alinhou 3 mini-tabuleiros que estão em estado `VENCIDO_O`.
4. `EMPATE`: Todos os 9 mini-tabuleiros saíram do estado `ATIVO` e nenhum alinhamento principal ocorreu.

## 3. Fluxo de Validação de Jogada

Todo input (`Coordenada_Macro`, `Coordenada_Mini`) enviado para a Engine passa pelo seguinte pipeline:

**Passo 1: Verificação de Turno**
- É a vez de quem enviou a jogada? Se não, lance `NotYourTurnException`.

**Passo 2: Verificação de Restrição Alvo**
- A propriedade do estado `proximo_mini_tabuleiro_obrigatorio` está setada?
- **SE SIM:** O `Coordenada_Macro` recebido confere com essa restrição? Se não conferir, lance `InvalidMiniBoardException`. (O jogador é obrigado a jogar onde a regra mandou).

**Passo 3: Verificação de Célula Livre**
- A célula destino descrita em `Coordenada_Mini` dentro do mini-tabuleiro selecionado está `"VAZIA"`?
- Se já tiver 'X' ou 'O', lance `CellOccupiedException`.

**Passo 4: Aplicação e Avaliação de Mini-Tabuleiro**
- Ocorre a marcação do símbolo do jogador.
- A Engine re-avalia o status do mini-tabuleiro alvo. Ele virou `VENCIDO` ou `EMPATADO`?

**Passo 5: Definição do Próximo Tabuleiro Obrigatório (A Regra de Ouro)**
- A Engine converte a `Coordenada_Mini` onde a jogada acabou de acontecer no índice de macro-tabuleiro.
- A Engine olha o status desse novo alvo do macro-tabuleiro que o jogador pretendia mandar oponente.
- **DELIBERAÇÃO DE STATUS:** Se o status desse novo mini-tabuleiro alvo for `ATIVO`, a regra se aplica: `proximo_mini_tabuleiro_obrigatorio` ganha a coordenada desse destino, prendendo o próximo jogador a nele.
- **'PASSE LIVRE' (Velha / Conquista):** Se o novo mini-tabuleiro alvo for `VENCIDO_X`, `VENCIDO_O` ou `EMPATADO`, a regra desliga. O valor de `proximo_mini_tabuleiro_obrigatorio` vira `LIVRE` (Null/Any). O próximo oponente ganha carta branca para escolher qualquer mini-tabuleiro que esteja `ATIVO`.

**Passo 6: Condição de Vitória Global**
- A Engine avalia o macro-tabuleiro inteiro com a mesma matemática de alinhamento 3x3 do Passo 4 para determinar o status do Macro-Tabuleiro.

## 4. Deliberações e Resoluções de Edge Cases

### 4.1. Quem Começa o Jogo?
- **Regra:** O primeiro jogador a mover é sempre o **X**.
- Não há input de escolha (Interface) para simplificar a estrutura do registro. Se os jogadores quiserem alternar quem começa as partidas (ex: Maria joga agora, na próxima quem começa é o João e ele será o X), o front fará apenas a adaptação visual de atribuição do jogador ao símbolo. A Engine sempre espera X iniciando o index 0.

### 4.2. Tratamento de Exceções Lógicas / Entradas Inválidas
- **Regra:** Jogadas inválidas (ex: tentar jogar na casa do oponente, num mini-tabuleiro errado ou já vencido, ou fora de sua vez) **NÃO** punem o jogador com perda de turno.
- **Fluxo:** A Engine apenas recusa a transação e lança a Exceção pertinente (`InvalidMoveException`). A Interface captura isso e mantém o jogador "preso" no turno atual aguardando uma jogada válida.

### 4.3. Regra de Esgotamento do Macro-Tabuleiro (Vitória por Pontos)
- **Regra:** O "empate verdadeiro" no macro-tabuleiro não ocorre em circunstâncias normais, pois o número ímpar (9) de mini-tabuleiros garante o desempate na contagem de conquiastas. Caso o tabuleiro global esgote de movimentos sem que ninguém alinhe 3 vitórias na tela primária, a Engine entra em Modo de Pontuação.
- **Fluxo:** A Engine conta a quantidade de Placas `VENCIDO_X` e `VENCIDO_O`. Quem tiver mais placas ganha o jogo. Um retorno de estado `EMPATE_ABSOLUTO` do Macro-Tabuleiro só existirá se a matemática de pontuações empatar estritamente devido às exceções de mini-tabuleiros que resultaram em "Velha".

### 4.4. A Estrutura do Registry (Registro Contínuo)
- **Regra:** A rastreabilidade do jogo **NÃO** gerará um pacote descentralizado de logs. Toda a execução da partida possui um Payload Único de Estado.
- **Fluxo:** Quando o jogo inicia, a Engine abre via Registry um objeto mestre `MatchPayload` (ou `ExecutionPayload`). Todo e qualquer evento (Jogada bem-sucedida, Jogada Inválida, Troca de Status, Exceptions da Engine ou demora de processamento da IA) é "appendado" como um step incremental na *timeline* desse payload. No encerramento da partida, o arquivo consolidado será salvo. Isso formará a base de treinamento da futura IA (pois contém a árvore de estado de todas as tomadas de decisão daquela partida em um só container legal).
