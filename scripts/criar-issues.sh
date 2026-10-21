#!/usr/bin/env bash
# Cria labels e as 20 histórias como issues, em ordem de prioridade.
# Requer GitHub CLI autenticado (gh auth login) e rodar dentro do repositório clonado.
set -e
gh label create prioridade-alta  --color D73A4A --force
gh label create prioridade-media --color FBCA04 --force
gh label create prioridade-baixa --color 0E8A16 --force
gh label create historia-de-usuario --color 1D76DB --force

mk() { # titulo | prioridade | casos de uso
  gh issue create --title "$1" --label "historia-de-usuario,prioridade-$2" \
    --body "**História:** $1

**Prioridade:** $2
**Casos de uso:** $3"
}

# Alta
mk "Como usuário, eu gostaria de fazer login para acessar as funções do meu perfil" alta "UC01"
mk "Como administrador, eu gostaria de cadastrar usuários e definir seus perfis" alta "UC02"
mk "Como gerente, eu gostaria de cadastrar produtos com preço e estoque mínimo" alta "UC03"
mk "Como vendedor, eu gostaria de registrar uma venda com vários itens" alta "UC07"
mk "Como vendedor, eu gostaria de registrar a forma de pagamento da venda" alta "UC09"
mk "Como estoquista, eu gostaria de ser avisado de produtos com estoque baixo" alta "UC16"
mk "Como estoquista, eu gostaria de criar pedidos de compra para repor produtos" alta "UC12"
mk "Como gerente, eu gostaria de aprovar e enviar pedidos de compra" alta "UC13"
mk "Como estoquista, eu gostaria de registrar o recebimento total ou parcial de um pedido" alta "UC14"
# Média
mk "Como gerente, eu gostaria de organizar produtos em categorias" media "UC04"
mk "Como vendedor, eu gostaria de aplicar desconto em uma venda" media "UC08"
mk "Como gerente, eu gostaria de autorizar descontos altos" media "UC08"
mk "Como vendedor, eu gostaria de cadastrar clientes para vincular às vendas" media "UC06"
mk "Como vendedor, eu gostaria de registrar a devolução de itens vendidos" media "UC11"
mk "Como gerente, eu gostaria de cancelar uma venda indevida" media "UC10"
mk "Como gerente, eu gostaria de cadastrar fornecedores" media "UC05"
mk "Como estoquista, eu gostaria de ajustar o estoque após o inventário" media "UC15"
mk "Como gerente, eu gostaria de um relatório de vendas por período" media "UC17"
# Baixa
mk "Como estoquista, eu gostaria de consultar o histórico de movimentações de um produto" baixa "UC19"
mk "Como gerente, eu gostaria de um relatório de estoque com valor total e curva ABC" baixa "UC18"
