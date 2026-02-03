/*
=========================================================
Projeto: Consultas SQL com Joins e Agregações
Arquivo: tarefas_sql_joins_agregacoes.sql

Descrição:
Este script contém consultas SQL que utilizam joins,
funções de agregação, filtros, ordenações e classificações
condicionais, simulando análises comuns no dia a dia de
um analista de dados.

Objetivo:
Demonstrar domínio de:
- JOIN entre múltiplas tabelas
- Funções de agregação (SUM, COUNT)
- GROUP BY e HAVING
- Filtros por data e valor
- CASE WHEN para classificação de dados

Autor(a): Marcela Morais
=========================================================
*/

-- ======================================================
-- Tarefa 1
-- Obter todos os pedidos de produtos com preço maior que us$ 25
-- Exibir: id do pedido, id do produto, quantidade e valor total
-- ======================================================

SELECT
    o.orderid,
    o.productid,
    o.quantity,
    o.total
FROM orders o
JOIN products p
    ON o.productid = p.productid
WHERE p.price > 25;

-- ======================================================
-- Tarefa 2
-- Listar cada cliente com a quantidade total de produtos solicitados
-- Ordenar pela maior quantidade total
-- ======================================================

SELECT
    c.customername,
    SUM(o.quantity) AS quantidade_total
FROM customers c
JOIN orders o
    ON c.customerid = o.customerid
GROUP BY c.customername
ORDER BY quantidade_total DESC;

-- ======================================================
-- Tarefa 3
-- Exibir o nome de cada produto e o total de vendas
-- Classificar como:
-- - "high revenue" se o total de vendas for maior que us$ 300
-- - "low revenue" caso contrário
-- ======================================================

SELECT
    p.productname,
    SUM(o.quantity * p.price) AS total_vendas,
    CASE
        WHEN SUM(o.quantity * p.price) > 300 THEN 'high revenue'
        ELSE 'low revenue'
    END AS classificacao
FROM orders o
JOIN products p
    ON p.productid = o.productid
GROUP BY p.productname;

-- ======================================================
-- Tarefa 4
-- Encontrar clientes que fizeram pelo menos dois pedidos
-- em dezembro de 2023, com pedidos acima de us$ 100
-- Exibir o nome do cliente e a quantidade de pedidos válidos
-- ======================================================

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

-- ======================================================
-- Tarefa 5
-- Listar cada pedido exibindo:
-- - As três primeiras letras do nome do cliente
-- - O nome do produto
-- - O valor total do pedido
-- ======================================================

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
