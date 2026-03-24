# Casos de Uso (Momento Canônico V1)

Este documento dita as regras exatas do que cada módulo deve cumprir na orquestração do Super Jogo da Velha. Servirá como guia para TDD/BDD na fase de execução.

## Casos de Uso Principais (Engine & Interface)

1. **Inicialização de Partida**
   - *Ação:* Uma nova partida é solicitada.
   - *Comportamento:* A Engine gera um tabuleiro com 9 mini-tabuleiros vazios. Turno inicial definido (ex: Jogador X). Interface é atualizada mostrando o tabuleiro limpo, permitindo que a primeira jogada aconteça em *qualquer* mini-tabuleiro.

2. **Jogada Válida e Restrição de Próximo Tabuleiro**
   - *Ação:* Jogador X joga na célula Central do mini-tabuleiro Superior-Direito.
   - *Comportamento:* A Engine registra "X" nessa posição. A Engine determina que a próxima jogada do Jogador O deve obrigatoriamente acontecer no mini-tabuleiro Central. Interface bloqueia visualmente os outros 8 mini-tabuleiros.

3. **Vitória de Mini-Tabuleiro**
   - *Ação:* Jogador alinha 3 símbolos num mini-tabuleiro.
   - *Comportamento:* A Engine marca aquele mini-tabuleiro inteiro como "vencido" pelo jogador. Se a próxima jogada cair neste mini-tabuleiro, o jogador seguinte ganha "jogada livre".

4. **Jogada Livre**
   - *Ação:* Oponente envia o Jogador da vez para um mini-tabuleiro que já está cheio ou já foi vencido.
   - *Comportamento:* A Engine desabilita a restrição de destino nesta rodada. A Interface deve refletir que todos os mini-tabuleiros válidos (não concluídos) estão abertos para jogada.

5. **Vitória no Tabuleiro Principal**
   - *Ação:* Jogador conquista 3 mini-tabuleiros formando uma linha no macro-tabuleiro.
   - *Comportamento:* A Engine decreta Game Over e vitória do Jogador. Interface exibe animação/tela de triunfo. State é salvo.

## Casos de Uso de Rastreabilidade (Registry)

1. **Gravação Extensiva (Traceability)**
   - *Ação:* Qualquer interligação na API (uma jogada é disparada pela Interface).
   - *Comportamento:* O Registry cria um Correlation ID único para a jogada. O estado "Antes" do tabuleiro, o input (posição logada) e o estado "Depois" gerado pela Engine são gravados de forma estruturada nas logs/banco do Registry.
   
2. **Traceback em Falha**
   - *Ação:* A Engine crasha por um erro de limite de array (ex: IndexOutOfBounds).
   - *Comportamento:* O Registry acopla junto da exceção (traceback padrão) o `correlation_id` e o payload exato da partida, permitindo reprodução literal no ambiente de testes local usando as ferramentas de replay.
