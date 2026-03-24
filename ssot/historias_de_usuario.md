# Histórias de Usuário (User Stories)

Este documento elenca as histórias de usuário divididas por Épicos. Elas abstraem os requisitos funcionais, técnicos e regras de negócio estritas que irão guiar os testes (TDD).

## Épico 1: A Engine e as Regras de Negócio (Core)

**US1.1: Inicialização**
> "Como jogador, quero iniciar uma partida com um macro-tabuleiro vazio composto de 9 mini-tabuleiros, para começar o jogo com o tabuleiro limpo."
- *Critério de Aceite:* A engine inicializa uma matriz de estado representando os 9x9 espaços. Nenhuma posição preenchida. 

**US1.2: Jogada Básica e Posicionamento**
> "Como jogador, quero que o sistema registre meu 'X' ou 'O', validando se a célula está vazia."
- *Critério de Aceite:* Uma jogada numa célula não-vazia deve retornar erro/invalid match.

**US1.3: Restrição de Movimento (A Regra de Ouro)**
> "Como sistema, quero forçar o próximo jogador a jogar no mini-tabuleiro correspondente à posição relativa da última jogada feita pelo oponente."
- *Critério de Aceite:* Se a última jogada ocorreu na Célula Central (linha 1, coluna 1 do mini-tabuleiro que vai de 0 a 2), o próximo input DEVE obrigatoriamente ser no mini-tabuleiro Central. Qualquer outro input será rejeitado.

**US1.4: Conquista de Mini-Tabuleiro**
> "Como jogador, quero dominar um mini-tabuleiro inteiro caso eu alinhe 3 símbolos nele (horizontal, vertical ou diagonal)."
- *Critério de Aceite:* A engine muda o status do mini-tabuleiro para Vencido por [X/O] permanentemente, independente se os próximos oponentes caírem nele de novo.

**US1.5: 'Passe Livre' (Célula Cheia/Finalizada)**
> "Como jogador, quero ganhar o direito de jogar em *qualquer* mini-tabuleiro aberto caso a jogada anterior do meu oponente me direcione para um mini-tabuleiro que já foi completado (sem espaços, empatado) ou já foi conquistado por alguém."
- *Critério de Aceite:* A validação de destino ignorará qualquer restrição no turno atual, contanto que o destino seja um mini-tabuleiro ainda disputável.

**US1.6: Empate ('Velha') em Mini-Tabuleiro**
> "Como jogador, quero que o sistema reconheça quando um mini-tabuleiro 'deu velha' (9 células preenchidas sem vencedor)."
- *Critério de Aceite:* O mini-tabuleiro muda para status "Empatado", não concedendo vitória a ninguém. Fica indisponível para jogadas e concede "Passe Livre" a quem for mandado para ele.

**US1.7: Condição de Fim de Jogo (Vitória)**
> "Como jogador, quero ganhar o jogo inteiro (Game Over) ao formar uma linha, coluna ou diagonal de mini-tabuleiros conquistados."
- *Critério de Aceite:* A engine identifica padrões de vitória no macro-tabuleiro e imediatamente marca a partida como ENCERRADA.

**US1.8: Empate ('Velha') no Macro-Tabuleiro**
> "Como jogador, quero que o jogo decrete Game Over caso não seja mais possível fazer jogadas (todos os 9 mini-tabuleiros finalizados por vitória ou velha) sem que alguém forme uma trinca."
- *Critério de Aceite:* O sistema impede novas ações e encerra o estado do jogo sob o status "Empatado".

**US1.9: Desempate do Macro-Tabuleiro (Opcional)**
> "Como jogador, ao dar velha no macro-tabuleiro, quero saber quem conquistou mais mini-tabuleiros para decidir o vencedor por pontos."
- *Critério de Aceite:* Match-Resolution avaliará o score X vs O. Em caso de pontuações iguais nos totais de mini-tabuleiros, a partida termina num empate absoluto (Draw).

## Épico 2: Interface de Usuário (Flet)

**US2.1: Orientação Visual**
> "Como usuário, quero saber instantaneamente em qual mini-tabuleiro eu posso ou devo jogar."
- *Critério de Aceite:* O Frontend deve aplicar highlights visuais e desativar interações (CSS/Flet desabilitado) nos quadrantes em que não é o turno do jogador.

## Épico 3: Inteligência Artificial

**US3.1: Oponente Solitário**
> "Como jogador humano, quero jogar contra a máquina (IA)."
- *Critério de Aceite:* O Módulo AI recebe o state board da Engine e retorna a tupla exata de jogada (linha, coluna) dentro do tempo de resposta admissível. A Engine deve aceitar isso como uma jogada válida equivalente à do humano.

## Épico 4: Registry e Rastreabilidade

**US4.1: Correlation de Eventos**
> "Como mantenedor (desenvolvedor), quero que cada jogada, erro de regra, ou validação crie um registro único com payload completo do estado daquele momento."
- *Critério de Aceite:* Falhas na API (FastAPI) originadas na Engine devem disparar um dump. O Registry exporta os objetos de erro num padrão estruturado com "Correlation ID".
