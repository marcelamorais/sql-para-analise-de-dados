/*
=========================================================
Projeto: Análises SQL - Loja Analytics
Arquivo: loja_analytics_consultas.sql

Descrição:
Este script contém consultas SQL voltadas para análise
de vendas em um cenário de loja, utilizando relações
entre tabelas, cálculos de faturamento e funções de
agregação para geração de métricas de negócio.

Objetivo:
Demonstrar domínio de:
- Consultas básicas com SELECT
- Relacionamento entre tabelas com JOIN
- Cálculos de faturamento
- Funções de agregação (COUNT, SUM, AVG, MIN, MAX)
- Métricas de negócio como ticket médio e faturamento total

Autor(a): Marcela Morais
=========================================================
*/

-- ======================================================
-- Criação e uso do banco de dados
-- ======================================================

-- Cria o banco de dados da loja
CREATE DATABASE loja_analytics;

-- Define o banco de dados ativo
USE loja_analytics;

-- Exibe as tabelas existentes no banco de dados
SHOW TABLES;

-- ======================================================
-- Consultas básicas
-- ======================================================

-- Exibir o id da venda e a quantidade vendida
SELECT
    id_venda,
    quantidade
FROM vendas;

-- Exibir o nome do produto e o preço
SELECT
    nome_produto,
    preco
FROM produtos;

-- ======================================================
-- Relacionamento entre tabelas e cálculo de faturamento
-- ======================================================

-- Exibir vendas com informações do produto e faturamento
SELECT
    v.id_venda,
    p.nome_produto,
    p.preco,
    v.quantidade,
    p.preco * v.quantidade AS faturamento
FROM vendas v
JOIN produtos p
    ON v.id_produto = p.id_produto;

-- ======================================================
-- Análise de gastos por cliente
-- ======================================================

-- Exibir o nome do cliente, produto e valor gasto,
-- considerando apenas gastos acima de 1000
SELECT
    c.nome AS nome_cliente,
    p.nome_produto,
    p.preco * v.quantidade AS gasto_cliente
FROM vendas v
JOIN clientes c
    ON v.id_cliente = c.id_cliente
JOIN produtos p
    ON v.id_produto = p.id_produto
WHERE p.preco * v.quantidade > 1000;

-- ======================================================
-- Funções de agregação
-- ======================================================

-- Contar o total de vendas realizadas
SELECT
    COUNT(*) AS total_vendas
FROM vendas;

-- Contar a quantidade de clientes distintos
SELECT
    COUNT(DISTINCT id_cliente) AS total_clientes
FROM vendas;

-- ======================================================
-- Análise de faturamento
-- ======================================================

-- Calcular o faturamento individual por venda
SELECT
    v.quantidade * p.preco AS faturamento_total
FROM vendas v
JOIN produtos p
    ON v.id_produto = p.id_produto;

-- Calcular o faturamento total da loja
SELECT
    SUM(v.quantidade * p.preco) AS faturamento_total_das_vendas
FROM vendas v
JOIN produtos p
    ON v.id_produto = p.id_produto;

-- ======================================================
-- Métricas de produtos
-- ======================================================

-- Calcular o preço médio dos produtos
SELECT
    AVG(preco) AS preco_medio
FROM produtos;

-- Calcular o ticket médio das vendas
SELECT
    AVG(p.preco * v.quantidade) AS ticket_medio
FROM vendas v
JOIN produtos p
    ON v.id_produto = p.id_produto;

-- Identificar o menor e o maior preço dos produtos
SELECT
    MIN(preco) AS menor_preco,
    MAX(preco) AS maior_preco
FROM produtos;

-- ======================================================
-- Fim do script
-- ======================================================
