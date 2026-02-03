/*
=========================================================
Projeto: Análise de Vendas com SQL
Arquivo: tabela2_vendas_relacionamentos.sql

Descrição:
Este script demonstra a criação de um banco de dados
relacional com tabelas de clientes, produtos e pedidos.
Inclui consultas analíticas, criação de views e métricas
de negócio como faturamento total, ranking de produtos
e clientes e análise de pedidos por período.

Objetivo:
Demonstrar domínio de:
- Modelagem relacional
- Criação de tabelas e chaves estrangeiras
- Inserção de dados
- JOIN entre múltiplas tabelas
- Funções de agregação (SUM, COUNT)
- GROUP BY, ORDER BY e HAVING
- Criação e uso de views
- CASE WHEN para classificação

Autor(a): Marcela Morais
=========================================================
*/

-- ======================================================
-- Criação e uso do banco de dados
-- ======================================================

-- Cria o banco de dados tabela2
CREATE DATABASE tabela2;

-- Define o banco de dados ativo
USE tabela2;

-- ======================================================
-- Criação das tabelas
-- ======================================================

-- Tabela de produtos
CREATE TABLE products (
    productid INT PRIMARY KEY,
    productname VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Tabela de clientes
CREATE TABLE customers (
    customerid INT PRIMARY KEY,
    customername VARCHAR(100)
);

-- Tabela de pedidos com relacionamento
CREATE TABLE orders (
    orderid INT PRIMARY KEY,
    orderdate DATE,
    customerid INT,
    productid INT,
    quantity INT,
    total DECIMAL(10, 2),

    -- Relacionamento com clientes
    FOREIGN KEY (customerid) REFERENCES customers(customerid),

    -- Relacionamento com produtos
    FOREIGN KEY (productid) REFERENCES products(productid)
);

-- ======================================================
-- Inserção de dados
-- ======================================================

-- Inserção de produtos
INSERT INTO products (productid, productname, price)
VALUES
(1001, 'widget a', 20.00),
(1002, 'widget b', 30.00),
(1003, 'widget c', 40.00),
(1004, 'widget d', 50.00);

-- Inserção de clientes
INSERT INTO customers (customerid, customername)
VALUES
(101, 'john doe'),
(102, 'jane smith'),
(103, 'bob johnson'),
(104, 'alice brown'),
(105, 'mary davis');

-- Inserção de pedidos
INSERT INTO orders (orderid, orderdate, customerid, productid, quantity, total)
VALUES
(1, '2023-12-01', 101, 1001, 10, 200.00),
(2, '2023-12-02', 102, 1002, 5, 150.00),
(3, '2023-12-03', 103, 1001, 3, 60.00),
(4, '2023-12-03', 104, 1003, 8, 240.00),
(5, '2023-12-05', 101, 1001, 15, 300.00),
(6, '2023-12-06', 102, 1004, 7, 350.00),
(7, '2023-12-07', 103, 1002, 6, 180.00),
(8, '2023-12-08', 104, 1003, 10, 400.00),
(9, '2023-12-09', 105, 1001, 12, 240.00);

-- ======================================================
-- Exercícios e consultas analíticas
-- ======================================================

-- Exercício 1
-- Valor total de vendas por cliente
SELECT
    c.customername,
    SUM(o.total) AS valortotalvendas
FROM customers c
JOIN orders o
    ON c.customerid = o.customerid
GROUP BY c.customername;

-- Exercício 2
-- Produto com maior quantidade vendida
SELECT
    p.productname,
    SUM(o.quantity) AS quantidadetotal
FROM products p
JOIN orders o
    ON p.productid = o.productid
GROUP BY p.productname
ORDER BY quantidadetotal DESC
LIMIT 1;

-- Exercício 3
-- Receita total gerada por produto
SELECT
    p.productname,
    SUM(o.total) AS receitatotal
FROM products p
JOIN orders o
    ON p.productid = o.productid
GROUP BY p.productname;

-- Exercício 4
-- Quantidade de pedidos por data
SELECT
    orderdate,
    COUNT(orderid) AS quantidadepedidos
FROM orders
GROUP BY orderdate;

-- Exercício 5
-- Top 3 clientes por valor total de vendas
SELECT
    c.customername,
    SUM(o.total) AS valortotalvendas
FROM customers c
JOIN orders o
    ON c.customerid = o.customerid
GROUP BY c.customername
ORDER BY valortotalvendas DESC
LIMIT 3;

-- ======================================================
-- Criação de view
-- ======================================================

-- View com faturamento total por cliente
CREATE VIEW total_vendas_clientes1 AS
SELECT
    c.customername,
    SUM(o.total) AS total_vendas
FROM orders o
JOIN customers c
    ON c.customerid = o.customerid
GROUP BY c.customername;

-- Visualizar dados da view
SELECT *
FROM total_vendas_clientes1;

-- ======================================================
-- Tarefas adicionais
-- ======================================================

-- Tarefa 1
-- Pedidos de produtos com preço acima de us$ 25
SELECT
    o.orderid,
    o.productid,
    o.quantity,
    o.total
FROM orders o
JOIN products p
    ON o.productid = p.productid
WHERE p.price > 25.00;

-- Tarefa 2
-- Quantidade total de produtos solicitados por cliente
SELECT
    c.customername,
    SUM(o.quantity) AS quantidadetotal
FROM customers c
JOIN orders o
    ON c.customerid = o.customerid
GROUP BY c.customername
ORDER BY quantidadetotal DESC;

-- Tarefa 3
-- Classificação de produtos por receita
SELECT
    p.productname,
    SUM(o.total) AS totalvendas,
    CASE
        WHEN SUM(o.total) > 300 THEN 'high revenue'
        ELSE 'low revenue'
    END AS classificacao
FROM products p
JOIN orders o
    ON p.productid = o.productid
GROUP BY p.productname;

-- Tarefa 4
-- Clientes com pelo menos dois pedidos acima de us$ 100 em dezembro de 2023
SELECT
    c.customername,
    COUNT(o.orderid) AS qtdpedidosqualificados
FROM customers c
JOIN orders o
    ON c.customerid = o.customerid
WHERE o.orderdate BETWEEN '2023-12-01' AND '2023-12-31'
  AND o.total > 100
GROUP BY c.customername
HAVING COUNT(o.orderid) >= 2;

-- Tarefa 5
-- Pedidos com iniciais do cliente, produto e valor total
SELECT
    LEFT(c.customername, 3) AS iniciaiscliente,
    p.productname,
    o.total
FROM orders o
JOIN customers c
    ON o.customerid = c.customerid
JOIN products p
    ON o.productid = p.productid;

-- ======================================================
-- Fim do script
-- ======================================================
