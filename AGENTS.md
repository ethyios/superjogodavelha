# Guia do Agente — Super Jogo da Velha

Este documento é o ponto de entrada para qualquer agente de IA que venha a trabalhar neste projeto. Leia-o integralmente antes de qualquer ação.

> **Manutenção obrigatória:** Este documento é um **artefato vivo**. O agente **deve atualizá-lo** ao final de cada sessão de trabalho, refletindo mudanças no estado do projeto (seção 4), novos Momentos Canônicos (seção 3) ou ajustes nas regras (seção 5). Isso garante que qualquer agente futuro receba contexto preciso.

## 1. O que é este projeto?

Um **Super Jogo da Velha** (Ultimate Tic-Tac-Toe) 100% Python, com arquitetura modular em 4 módulos:

| Módulo | Tecnologia | Papel |
| --- | --- | --- |
| **Engine** | Python puro | Regras de negócio, estado do jogo, validação de jogadas |
| **Interface** | Flet (Python) | UI multiplataforma (Mobile, Desktop, Web) |
| **AI** | Python | Oponente heurístico V1, preparado para ML futuro |
| **Registry** | Python | Rastreabilidade, payloads JSON de partidas |

**Ferramenta de gerenciamento Python:** `uv` (não pip/venv).

## 2. O Processo de Desenvolvimento (3 Etapas Rígidas)

O projeto segue um processo encadeado com **3 etapas sequenciais**. O agente **nunca deve pular ou antecipar etapas** sem autorização explícita do usuário.

### Etapa 1 — Planejamento (Documentação)

- Elicitação de requisitos, design, regras de negócio, casos de uso, histórias de usuário.
- **Restrição absoluta:** Nenhuma implementação de código, testes ou infraestrutura (nem instalar Python).
- Os documentos vivem na pasta `ssot/` e formam o **Cânone** (ver seção 3).

### Etapa 2 — Testes TDD

- Criação de todos os testes unitários (`pytest`) derivados da documentação do Cânone.
- Os testes devem seguir fielmente as regras de negócio, casos de uso e histórias de usuário.
- Os testes são escritos em estado **RED** — falham intencionalmente até que a implementação exista.
- **Restrição:** Não implementar o código do software, somente testes.

### Interlúdio de Revisão (entre Etapa 2 e Etapa 3)

Após concluir a Etapa 2, é feita uma **revisão formal**:

- A documentação está clara, concisa e completa?
- Os testes cobrem todos os casos de uso e regras?
- Há lacunas em qualquer etapa anterior?

Se a revisão **não for satisfatória**, retorna-se à Etapa 1. Isso já aconteceu uma vez na história do projeto.

### Etapa 3 — Implementação

- O código real é escrito para satisfazer os testes RED → GREEN.
- Só ocorre após aprovação explícita do usuário no interlúdio de revisão.

## 3. O Cânone (SSOT)

A pasta `ssot/` contém a **Single Source of Truth** do projeto. Os documentos ali são a autoridade máxima.

**Regra de Ouro:** Os documentos do Cânone **não são alterados** sem solicitação explícita do usuário. Qualquer ambiguidade no código deve ser resolvida retornando ao Cânone.

### Momentos Canônicos

São commits especiais que **fixam** o estado da documentação. Cada Momento Canônico é um marco irrevogável. O registro deles está em `ssot/canone.md`.

| Momento | Descrição |
| --- | --- |
| V1 | Planejamento inicial — 4 módulos, stack Python, Flet |
| V2 | Regras de negócio da Engine, casos de uso, histórias de usuário |
| V3 | Testes TDD da Engine (21 testes, 4 arquivos) — obsoletos, removidos na Etapa 2 |
| **V4 (Atual)** | Especificação completa de todos os módulos (AI, Registry, Interface, Design) |

### Documentos do Cânone

| Documento | Conteúdo |
| --- | --- |
| `ssot/canone.md` | Definição do Cânone e registro histórico de Momentos Canônicos |
| `ssot/arquitetura.md` | Arquitetura macro (4 pilares), diagramas Mermaid |
| `ssot/regras_de_negocio.md` | **Documento central** — 7 seções + edge cases. Topologia, máquina de estados, pipeline de validação, exceções, regras da IA, Registry e Interface |
| `ssot/casos_de_uso.md` | 13 Use Cases (UC1–UC13) com diagrama de atores |
| `ssot/historias_de_usuario.md` | 4 Épicos, ~22 User Stories com critérios de aceite |
| `ssot/design_de_interface.md` | Layout, wireframes, paleta de cores, componentes Flet, animações |
| `ssot/plano_de_implementacao.md` | Plano geral, estrutura de diretórios, estratégia TDD |

## 4. Estado Atual do Projeto

- **Etapa atual: 2 — Testes TDD**
- O mockup da Engine e os testes anteriores (V3) foram **removidos**. Os testes serão recriados do zero com base no Cânone V4.
- Não há infraestrutura Python configurada ainda (sem `pyproject.toml`, sem `__init__.py`, sem ambiente virtual).
- A pasta `backend/engine/tests/` existe mas está vazia.
- A pasta `ssot/testes/` existe mas está vazia (as specs de teste foram removidas junto).

### Próximo passo

Criar os testes unitários `pytest` para todos os módulos, começando pela Engine, seguindo estritamente a documentação vigente (V4). A infraestrutura Python (pyproject.toml, dependências, etc.) deve ser configurada como parte desta etapa.

## 5. Regras para o Agente

1. **Não altere o Cânone** sem solicitação explícita do usuário.
2. **Não pule etapas.** Se estamos na Etapa 2, não implemente código do software.
3. **Toda decisão técnica deve ser rastreável** a um documento do Cânone (referencie a seção).
4. **Pergunte quando houver ambiguidade** ao invés de assumir.
5. **`uv`** é a ferramenta de gerenciamento — não use `pip install` ou `python -m venv` diretamente.
6. **Commits de Momento Canônico** só são feitos com autorização do usuário.
