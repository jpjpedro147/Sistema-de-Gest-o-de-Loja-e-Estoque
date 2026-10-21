# Sistema de Gestão de Loja e Estoque — Casos de Uso

Modelo de especificação: *Engenharia de Software Moderna* (M. T. Valente), cap. 3 — nome com verbo no infinitivo, ator, fluxo normal, extensões. Passos incluídos aparecem <u>sublinhados</u>.

## 1. Visão geral
Sistema desktop (Java 21 + JavaFX + SQLite) para uma loja de varejo controlar o cadastro de produtos, as vendas de balcão, as devoluções, a reposição de estoque por pedidos de compra a fornecedores e os relatórios gerenciais. O acesso exige login, e o perfil do usuário define as funções disponíveis.

## 2. Atores (papéis de usuário)
| Ator | Descrição |
|---|---|
| Administrador | Gerencia usuários e perfis de acesso. |
| Gerente | Mantém produtos, categorias e fornecedores; aprova pedidos de compra; autoriza descontos; cancela vendas; emite relatórios. |
| Vendedor | Atende clientes: registra vendas, pagamentos e devoluções. |
| Estoquista | Controla o estoque: cria pedidos de compra, recebe mercadorias, ajusta inventário e consulta alertas. |

## 3. Glossário
- **Produto:** item comercializado, com código, preço de venda, custo e estoque mínimo.
- **Saldo:** quantidade atual de um produto em estoque.
- **Movimentação:** entrada, saída, ajuste ou devolução que altera o saldo.
- **Pedido de compra:** solicitação de reposição enviada a um fornecedor.

## 4. Regras de negócio
- **RN01:** a venda não pode deixar o saldo de um produto negativo.
- **RN02:** desconto acima de 10% do total exige autorização de um Gerente.
- **RN03:** total da venda = soma(quantidade × preço unitário) − desconto.
- **RN04:** produto com saldo ≤ estoque mínimo gera alerta de reposição.

**Entidade com ciclo de vida — Pedido de Compra:** Rascunho → Aguardando aprovação → Enviado → Recebido parcialmente → Recebido; Cancelado (a partir de Rascunho, Aguardando aprovação ou Enviado).

## 5. Histórias de usuário (Product Backlog, por prioridade)
| ID | História | Prioridade |
|---|---|---|
| US01 | Como usuário, eu gostaria de fazer login para acessar as funções do meu perfil | Alta |
| US02 | Como administrador, eu gostaria de cadastrar usuários e definir seus perfis | Alta |
| US03 | Como gerente, eu gostaria de cadastrar produtos com preço e estoque mínimo | Alta |
| US04 | Como gerente, eu gostaria de organizar produtos em categorias | Média |
| US05 | Como vendedor, eu gostaria de registrar uma venda com vários itens | Alta |
| US06 | Como vendedor, eu gostaria de registrar a forma de pagamento da venda | Alta |
| US07 | Como vendedor, eu gostaria de aplicar desconto em uma venda | Média |
| US08 | Como gerente, eu gostaria de autorizar descontos altos | Média |
| US09 | Como vendedor, eu gostaria de cadastrar clientes para vincular às vendas | Média |
| US10 | Como vendedor, eu gostaria de registrar a devolução de itens vendidos | Média |
| US11 | Como gerente, eu gostaria de cancelar uma venda indevida | Média |
| US12 | Como estoquista, eu gostaria de ser avisado de produtos com estoque baixo | Alta |
| US13 | Como estoquista, eu gostaria de criar pedidos de compra para repor produtos | Alta |
| US14 | Como gerente, eu gostaria de aprovar e enviar pedidos de compra | Alta |
| US15 | Como gerente, eu gostaria de cadastrar fornecedores | Média |
| US16 | Como estoquista, eu gostaria de registrar o recebimento total ou parcial de um pedido | Alta |
| US17 | Como estoquista, eu gostaria de ajustar o estoque após o inventário | Média |
| US18 | Como estoquista, eu gostaria de consultar o histórico de movimentações de um produto | Baixa |
| US19 | Como gerente, eu gostaria de um relatório de vendas por período | Média |
| US20 | Como gerente, eu gostaria de um relatório de estoque com valor total e curva ABC | Baixa |

## 6. Lista de casos de uso e rastreabilidade
| ID | Caso de uso | Ator principal | Origem |
|---|---|---|---|
| UC01 | Autenticar usuário | Todos | US01 |
| UC02 | Gerenciar usuários e perfis (CRUD) | Administrador | US02 |
| UC03 | Gerenciar produtos (CRUD) | Gerente | US03 |
| UC04 | Gerenciar categorias (CRUD) | Gerente | US04 |
| UC05 | Gerenciar fornecedores (CRUD) | Gerente | US15 |
| UC06 | Gerenciar clientes (CRUD) | Vendedor | US09 |
| UC07 | Registrar venda | Vendedor | US05 |
| UC08 | Aplicar desconto | Vendedor | US07, US08 |
| UC09 | Registrar pagamento | Vendedor | US06 |
| UC10 | Cancelar venda | Gerente | US11 |
| UC11 | Registrar devolução | Vendedor | US10 |
| UC12 | Criar pedido de compra | Estoquista | US13 |
| UC13 | Aprovar e enviar pedido de compra | Gerente | US14 |
| UC14 | Receber mercadoria | Estoquista | US16 |
| UC15 | Ajustar estoque | Estoquista | US17 |
| UC16 | Consultar estoque e alertas de reposição | Estoquista | US12 |
| UC17 | Emitir relatório de vendas | Gerente | US19 |
| UC18 | Emitir relatório de estoque | Gerente | US20 |
| UC19 | Consultar histórico de movimentações | Estoquista | US18 |

19 casos de uso, 5 CRUD, 4 atores. Relações do diagrama: UC07 inclui UC09; UC08 estende UC07; UC12 estende UC16. Nos demais casos de uso (exceto UC01), a pré-condição é o usuário estar autenticado (UC01) com o perfil do ator.

## 7. Especificações

### UC01 — Autenticar usuário
**Ator:** Todos os atores
**Fluxo normal:**
1. Usuário informa login e senha
2. Sistema valida as credenciais
3. Sistema identifica o perfil do usuário
4. Sistema libera as funções do perfil

**Extensões:**
- 2a. Credenciais incorretas: informar o erro e solicitar novas credenciais
- 2b. Usuário inativo: negar o acesso
- 2c. Três tentativas incorretas seguidas: bloquear o login por 5 minutos

### UC02 — Gerenciar usuários e perfis
**Ator:** Administrador
**Fluxo normal:** o administrador cadastra, consulta, altera e desativa usuários, informando nome, login, senha e perfil (Administrador, Gerente, Vendedor ou Estoquista).
**Extensões:**
- a. Login já existente: solicitar outro login
- b. Desativar o último administrador ativo: negar a operação

### UC03 — Gerenciar produtos
**Ator:** Gerente
**Fluxo normal:** o gerente cadastra, consulta, altera e inativa produtos, informando código, nome, categoria, custo, preço de venda e estoque mínimo.
**Extensões:**
- a. Código já existente: solicitar outro código
- b. Preço de venda menor ou igual a zero: solicitar novo valor
- c. Excluir produto com movimentações: apenas inativar

### UC04 — Gerenciar categorias
**Ator:** Gerente
**Fluxo normal:** o gerente cadastra, consulta, altera e exclui categorias de produtos.
**Extensões:**
- a. Nome já existente: solicitar outro nome
- b. Excluir categoria com produtos: negar a operação

### UC05 — Gerenciar fornecedores
**Ator:** Gerente
**Fluxo normal:** o gerente cadastra, consulta, altera e inativa fornecedores, informando razão social, CNPJ e contato.
**Extensões:**
- a. CNPJ inválido ou já cadastrado: solicitar novo CNPJ
- b. Inativar fornecedor com pedido em andamento: negar a operação

### UC06 — Gerenciar clientes
**Ator:** Vendedor
**Fluxo normal:** o vendedor cadastra, consulta, altera e inativa clientes, informando nome, CPF e telefone.
**Extensões:**
- a. CPF inválido ou já cadastrado: solicitar novo CPF

### UC07 — Registrar venda
**Ator:** Vendedor
**Fluxo normal:**
1. Vendedor inicia uma nova venda
2. Vendedor informa o cliente
3. Vendedor informa produto e quantidade de cada item, até concluir a lista
4. Sistema calcula o total da venda (RN03)
5. Vendedor confirma os itens
6. <u>Registrar pagamento</u>
7. Sistema grava a venda e baixa o estoque dos itens
8. Sistema emite o comprovante

**Extensões:**
- 2a. Cliente não identificado: registrar a venda sem cliente
- 3a. Produto inexistente ou inativo: informar o erro e solicitar outro produto
- 3b. Quantidade maior que o saldo: recusar o item e informar o saldo (RN01)
- 3c. Vendedor remove um item: recalcular o total
- 4a. Vendedor deseja conceder desconto: Aplicar desconto (UC08)
- 6a. Pagamento não concluído: cancelar a venda sem baixar o estoque

### UC08 — Aplicar desconto
**Ator:** Vendedor (apoio: Gerente)
**Fluxo normal:**
1. Vendedor informa o desconto (valor ou percentual)
2. Sistema valida o desconto contra o limite (RN02)
3. Sistema recalcula o total da venda

**Extensões:**
- 2a. Desconto maior que o total: solicitar novo valor
- 2b. Desconto acima de 10%: solicitar autorização de um Gerente
- 2c. Gerente informa suas credenciais e autoriza: seguir para o passo 3
- 2d. Gerente nega a autorização: descartar o desconto

### UC09 — Registrar pagamento
**Ator:** Vendedor
**Fluxo normal:**
1. Vendedor seleciona a forma de pagamento (dinheiro, cartão ou Pix)
2. Vendedor informa o valor recebido
3. Sistema calcula o troco
4. Sistema registra o pagamento

**Extensões:**
- 2a. Valor menor que o total: solicitar novo valor
- 2b. Pagamento recusado: solicitar outra forma de pagamento

### UC10 — Cancelar venda
**Ator:** Gerente
**Fluxo normal:**
1. Gerente pesquisa a venda
2. Gerente informa o motivo do cancelamento
3. Sistema marca a venda como cancelada
4. Sistema devolve ao estoque os itens vendidos

**Extensões:**
- 1a. Venda não encontrada: informar o erro
- 3a. Venda já cancelada ou com devolução registrada: negar a operação

### UC11 — Registrar devolução
**Ator:** Vendedor
**Fluxo normal:**
1. Vendedor pesquisa a venda original
2. Vendedor seleciona os itens e as quantidades devolvidos
3. Vendedor informa o motivo da devolução
4. Sistema valida o prazo e as quantidades
5. Sistema registra a devolução, repõe o estoque e calcula o valor a estornar

**Extensões:**
- 1a. Venda não encontrada ou cancelada: informar o erro
- 4a. Prazo de devolução maior que 30 dias: recusar a devolução
- 4b. Quantidade maior que a vendida: solicitar nova quantidade

### UC12 — Criar pedido de compra
**Ator:** Estoquista
**Fluxo normal:**
1. Estoquista seleciona o fornecedor
2. Estoquista informa produtos e quantidades
3. Sistema calcula o valor total estimado
4. Estoquista envia o pedido para aprovação
5. Sistema registra o pedido na situação "Aguardando aprovação"

**Extensões:**
- 1a. Fornecedor inativo: solicitar outro fornecedor
- 2a. Pedido iniciado a partir de alerta de estoque baixo: sistema sugere os produtos e as quantidades
- 4a. Estoquista salva sem enviar: registrar o pedido na situação "Rascunho"

### UC13 — Aprovar e enviar pedido de compra
**Ator:** Gerente
**Fluxo normal:**
1. Gerente consulta os pedidos aguardando aprovação
2. Gerente seleciona um pedido e confere itens e valor
3. Gerente aprova o pedido
4. Sistema altera a situação para "Enviado" e gera o documento do pedido para o fornecedor

**Extensões:**
- 3a. Gerente rejeita o pedido e informa o motivo: devolver o pedido à situação "Rascunho"
- 3b. Gerente cancela o pedido: alterar a situação para "Cancelado"

### UC14 — Receber mercadoria
**Ator:** Estoquista
**Fluxo normal:**
1. Estoquista seleciona um pedido na situação "Enviado" ou "Recebido parcialmente"
2. Estoquista informa a quantidade recebida de cada item
3. Sistema valida as quantidades contra o pedido
4. Sistema atualiza o saldo dos produtos recebidos
5. Sistema altera a situação do pedido para "Recebido"

**Extensões:**
- 2a. Quantidade recebida menor que a pedida em algum item: no passo 5, alterar a situação para "Recebido parcialmente"
- 3a. Quantidade recebida maior que a pedida: recusar o excedente e solicitar nova quantidade

### UC15 — Ajustar estoque
**Ator:** Estoquista
**Fluxo normal:**
1. Estoquista seleciona o produto
2. Estoquista informa a quantidade contada no inventário
3. Estoquista informa o motivo do ajuste
4. Sistema calcula a diferença em relação ao saldo
5. Sistema registra a movimentação de ajuste e atualiza o saldo

**Extensões:**
- 2a. Quantidade negativa: solicitar nova quantidade
- 3a. Motivo não informado: solicitar o motivo
- 4a. Sem diferença: informar que o saldo já está correto

### UC16 — Consultar estoque e alertas de reposição
**Ator:** Estoquista
**Fluxo normal:**
1. Estoquista informa filtros (produto ou categoria)
2. Sistema lista os produtos com o saldo atual
3. Sistema destaca os produtos com saldo menor ou igual ao estoque mínimo (RN04)

**Extensões:**
- 1a. Nenhum filtro informado: listar todos os produtos
- 3a. Estoquista decide repor os produtos destacados: Criar pedido de compra (UC12)

### UC17 — Emitir relatório de vendas
**Ator:** Gerente
**Fluxo normal:**
1. Gerente informa o período
2. Sistema totaliza vendas, descontos e devoluções do período
3. Sistema exibe o relatório

**Extensões:**
- 1a. Data inicial maior que a final: solicitar novo período
- 2a. Nenhuma venda no período: informar que não há dados

### UC18 — Emitir relatório de estoque
**Ator:** Gerente
**Fluxo normal:**
1. Gerente seleciona a categoria
2. Sistema calcula o valor total do estoque ao preço de custo
3. Sistema classifica os produtos em A, B e C pelo valor vendido nos últimos 90 dias
4. Sistema exibe o relatório

**Extensões:**
- 1a. Nenhuma categoria selecionada: considerar todos os produtos
- 3a. Produto sem vendas no período: classificar como C

### UC19 — Consultar histórico de movimentações
**Ator:** Estoquista
**Fluxo normal:**
1. Estoquista informa o produto e o período
2. Sistema lista as entradas, saídas, ajustes e devoluções do período
3. Sistema exibe o saldo após cada movimentação

**Extensões:**
- 2a. Nenhuma movimentação no período: informar que não há dados
