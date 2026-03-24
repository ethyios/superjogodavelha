# Momentos Canônicos

Para manter a integridade da nossa Single Source of Truth (SSOT), adotamos o conceito de **Momentos Canônicos**.

## O que são?
Um momento canônico é um "snapshot" conceitual e documentado de como o sistema funciona ou deve funcionar em uma determinada versão principal (ex: V1, V2).

## Regras
1. **Imutabilidade Histórica:** Uma vez que um momento canônico é estabelecido (ex: a arquitetura do lançamento da V1), os documentos referentes a esse momento não devem ser alterados para refletir ideias novas. Novas ideias requerem a evolução para um próximo momento canônico (V2).
2. **Referência de Teste:** O momento canônico dita a lei do sistema. Os testes de Casos de Uso são garantidos por ele. Se a Engine não cumpre o que a SSOT canônica diz, a Engine tem um bug.
3. **Tags no Repositório:** A cada consolidação de um Momento Canônico, será gerada uma *tag* correspondente no controle de versão (ex: `ssot-v1.0`).

## Momentos Atuais

- **[V1 - Planejamento Inicial] (Atual):** A concepção e arquitetura dos 4 módulos em arquitetura 100% Python (Engine, Registry, IA e Flet para Interface Mobile/Web/Desktop), com regras do Super Jogo da Velha estabelecidas em testes (TDD), IA heurística inicial e alta rastreabilidade de eventos (logs e tracebacks).
