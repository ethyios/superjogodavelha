# Plano de Implementação: Reescrita Super Jogo da Velha

Este documento define o plano para a reescrita total do Super Jogo da Velha, focando na modularização, mudança de stack e alta rastreabilidade, preparando o terreno para a futura implementação de Machine Learning.

## User Review Required

- **Stack Tecnológica Aprovada:** 100% Python! O backend (Engine, AI, Registry) usará lógica Python otimizada e o frontend utilizará o framework **Flet**, o que nos permite desenvolver a interface gráfica do jogo inteiramente em Python e, ao mesmo tempo, garantir a portabilidade para web, desktop e **mobile** sem mudar de ecossistema. Flet é a escolha perfeita para evitar transição de contexto entre linguagens.
- **Formato SSOT:** A documentação está estruturada na pasta `ssot/` em Markdown, orientada por momentos canônicos.

## Proposed Changes

A reescrita dividirá o sistema nos 4 módulos exigidos, sendo orquestrados da seguinte forma:

### 1. Módulo: Engine (Regras de Negócio)
- **Tecnologia:** Python.
- **Responsabilidade:** Gerenciar o estado do jogo do "Super Jogo da Velha" (9 mini-tabuleiros). Validar jogadas, determinar vitórias nos mini-tabuleiros e no tabuleiro principal.
- **Comunicação:** Exporá um pacote ou API REST (FastAPI) / Serveless functions para ser consumido pelos clientes.

### 2. Módulo: Interface (Cliente Humano)
- **Tecnologia:** Flet (Python).
- **Responsabilidade:** Renderizar o tabuleiro complexo de forma clara e responsiva para qualquer dispositivo (Mobile, Web, Desktop).
- **Comunicação:** Rodará consumindo os estados gerados pela Engine, atualizando a UI assincronamente refletindo o tabuleiro.

### 3. Módulo: AI (Inteligência Artificial)
- **Tecnologia:** Python.
- **Responsabilidade:** Receber o estado do jogo e devolver a melhor jogada.
- **Fase Inicial:** Heurística (ex: Minimax com poda Alpha-Beta ou heurísticas baseadas em peso dos mini-tabuleiros).
- **Fase Futura:** Pronta para receber modelos de ML (Deep Q-Learning, etc) puxandos features da Engine.

### 4. Módulo: Registry (Registro e Rastreabilidade)
- **Tecnologia:** Python (Modulo de Logging customizado + Banco de Dados / Arquivos JSON).
- **Responsabilidade:** Rastreabilidade estrita. Toda ação na Engine, exceções, e metadados de partidas inteiras (movimento a movimento) serão gravados aqui.
- **Uso:** Servirá para reproduzir casos de uso (tracebacks), debugar erros e como dataset para o treinamento da IA no futuro.

---

### Estrutura de Diretórios Inicial Proposta (Visão Macro)

```text
superjogodavelha-rewrite/
├── ssot/                 # (Biblioteca Single Source of Truth)
│   ├── arquitetura.md
│   ├── momentos_canonicos/
│   └── modulos/
├── backend/              # Engine, AI e Registry
│   ├── engine/
│   ├── ai/
│   ├── registry/
│   └── api/              # FastAPI endpoints que conectam Engine <-> Interface
└── frontend/             # Interface
    └── main.py           # Ponto de entrada do aplicativo Flet
```

## Verification Plan

### Automated Tests (TDD)
- **O desenvolvimento será estritamente guiado por testes (TDD).**
- Os casos de uso definidos na SSOT originarão testes automatizados `pytest` antes da implementação do código da Engine.
- Validação rigorosa de cada regra do Super Jogo da Velha (vitórias em tabuleiro menor, empates, jogada livre, etc).

### Manual Verification
- A validação manual consistirá em executar o aplicativo desenvolvido em Flet interagindo graficamente, gerando transações reais para o Registry e consumindo as respostas da IA.
