/*
=========================================================
Projeto: Fundamentos de SQL - Qualidade e Tratamento de Dados
Arquivo: tabela1_qualidade_dados.sql

Descrição:
Este script demonstra a criação de um banco de dados com
dados propositalmente inconsistentes (duplicidades, letras
maiúsculas/minúsculas, valores nulos e tipos incorretos),
aplicando técnicas de tratamento, padronização e análise.

Objetivo:
Demonstrar domínio de:
- Criação de tabelas
- Inserção de dados com inconsistências
- Tratamento de textos (LOWER)
- Uso de COALESCE para valores nulos
- Criação de views
- CAST para conversão de tipos
- Normalização de dados para análise
- Consolidação de dados com JOIN

Autor(a): Marcela Morais
=========================================================
*/

-- ======================================================
-- Criação e uso do banco de dados
-- ======================================================

-- Cria o banco de dados tabela1
CREATE DATABASE tabela1;

-- Define o banco de dados ativo
USE tabela1;

-- ======================================================
-- Criação das tabelas
-- ======================================================

-- Tabela de clientes
CREATE TABLE customers (
    customerid INT PRIMARY KEY,
    customername VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

-- Tabela de produtos
CREATE TABLE products (
    productid INT PRIMARY KEY,
    productname VARCHAR(100),
    category VARCHAR(50),
    price VARCHAR(20)
);

-- Tabela de pedidos
CREATE TABLE orders (
    orderid INT PRIMARY KEY,
    customerid INT,
    productid INT,
    orderdate VARCHAR(20),
    quantity INT,
    total VARCHAR(20)
);

-- ======================================================
-- Inserção de dados (com inconsistências propositalmente)
-- ======================================================

-- Inserção de clientes
INSERT INTO customers VALUES
(1, 'Ana Silva', 'ana@email.com', 'São Paulo'),
(2, 'ana silva', 'ana@email.com', 'São Paulo'),
(3, 'Carlos Souza', NULL, 'Rio de Janeiro'),
(4, 'Mariana Lima', 'mariana@email.com', NULL),
(5, 'JOÃO PEREIRA', 'joao@email.com', 'Curitiba');

-- Inserção de produtos
INSERT INTO products VALUES
(1, 'Notebook Dell', 'Eletrônicos', '3500.00'),
(2, 'notebook dell', 'Eletrônicos', '3500'),
(3, 'Mouse Logitech', 'Periféricos', NULL),
(4, 'Teclado Mecânico', 'Periféricos', '450.50');

-- Inserção de pedidos
INSERT INTO orders VALUES
(1, 1, 1, '2024-01-10', 1, '3500'),
(2, 2, 1, '10/01/2024', 1, '3500'),
(3, 3, 3, '2024-02-05', 2, NULL),
(4, 4, 4, NULL, 1, '450.50');

-- ======================================================
-- Tratamento de texto e identificação de duplicidades
-- ======================================================

-- Criação de view para contagem de nomes duplicados
-- LOWER padroniza textos para comparação
-- COALESCE substitui valores nulos
CREATE VIEW vw_contagem_nomes AS
SELECT
    LOWER(customername) AS nomes,
    COALESCE(email, 'sem email cadastrado') AS email,
    COALESCE(city, 'sem cidade cadastrada') AS cidade,
    COUNT(*) AS total
FROM customers
GROUP BY
    LOWER(customername),
    email,
    city;

-- Visualizar a view de contagem
SELECT *
FROM vw_contagem_nomes;

-- Inserção adicional para testar duplicidade
INSERT INTO customers VALUES
(10, 'ana silva', 'ana@email.com', 'Rio de Janeiro');

-- ======================================================
-- Views para relatórios
-- ======================================================

-- View com clientes que possuem email cadastrado
CREATE VIEW vw_email_cadastrados AS
SELECT *
FROM customers
WHERE email IS NOT NULL;

-- Visualizar a view
SELECT *
FROM vw_email_cadastrados;

-- Visualizar estrutura e dados da tabela products
SELECT *
FROM products;

DESCRIBE products;

-- ======================================================
-- Conversão de tipos de dados
-- ======================================================

-- Criação de view com preço convertido para decimal
CREATE VIEW vw_produtos AS
SELECT
    productid,
    productname,
    category,
    CAST(price AS DECIMAL(10,2)) AS preco
FROM products
WHERE price IS NOT NULL;

-- Visualizar a view de produtos tratados
SELECT *
FROM vw_produtos;

-- ======================================================
-- Consulta consolidada sem duplicidades e sem valores nulos
-- ======================================================

-- Exibir produtos únicos, normalizados e com preço convertido
SELECT DISTINCT
    LOWER(productname) AS productname,
    category,
    CAST(price AS DECIMAL(10,2)) AS price
FROM products
WHERE price IS NOT NULL;

-- ======================================================
-- Relatório final consolidado de pedidos
-- ======================================================

-- Junta pedidos, clientes e produtos com tratamento completo
SELECT DISTINCT
    o.orderid AS id_pedido,
    LOWER(c.customername) AS nome_cliente,
    COALESCE(c.city, 'não informado') AS cidade,
    LOWER(p.productname) AS produto,
    p.category AS categoria,

    -- Conversão de datas com formatos diferentes
    CASE
        WHEN o.orderdate LIKE '%/%'
            THEN STR_TO_DATE(o.orderdate, '%d/%m/%Y')

