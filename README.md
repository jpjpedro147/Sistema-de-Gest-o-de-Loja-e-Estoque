# Sistema de Gestão de Loja e Estoque

**Tema:** controle de produtos, vendas, devoluções e reposição de estoque (pedidos de compra) de uma loja de varejo, com perfis de acesso (Administrador, Gerente, Vendedor e Estoquista).

**Disciplina:** Análise e Projeto de Sistemas

## Integrantes
- João Pedro Dionìsio
- Higor Ferreira
- Enzo Leal
- Gustavo Mendes

## Tecnologias
Java 21 · JavaFX · SQLite (sqlite-jdbc) · JDBC · Maven

## Como executar
Requisitos: JDK 21 e Maven 3.9+.

```bash
git clone <url-do-repositorio>
cd loja-estoque
mvn javafx:run
```

O banco SQLite (arquivo local) é criado pelo próprio sistema na primeira execução.

## Documentação
- [Casos de uso](docs/casos-de-uso.md)
- Diagrama de casos de uso: [PNG](docs/diagramas/casos-de-uso.png) · [fonte PlantUML](docs/diagramas/casos-de-uso.puml)
- Diagrama de classes: [docs/diagramas/classes.md](docs/diagramas/classes.md)

## Product Backlog
Histórias de usuário nas [Issues](../../issues), ordenadas por prioridade (labels `prioridade-alta`, `prioridade-media`, `prioridade-baixa`).
