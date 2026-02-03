/*
=========================================================
Projeto: Fundamentos de SQL - Relacionamentos entre Tabelas
Arquivo: relacoes_clientes_pedidos_produtos.sql

Descrição:
Este script demonstra a criação de um banco de dados
relacional, com tabelas de clientes, produtos e pedidos,
incluindo chaves estrangeiras e consultas analíticas
utilizando joins e funções de agregação.

Objetivo:
Praticar conceitos fundamentais de SQL, como:
- Criação de banco de dados e tabelas
- Relacionamentos com foreign keys
- Inserção de dados
- Consultas com inner join e left join
- Funções de agregação (sum)
- Group by e filtros condicionais

Autor(a): Marcela Morais
=========================================================
*/

-- ======================================================
-- Criação e uso do banco de dados
-- ======================================================

-- Cria o banco de dados relacoes
CREATE DATABASE relacoes;

-- Define o banco de dados ativo
USE relacoes;

-- ======================================================
-- Criação das tabelas
-- ======================================================

-- Tabela de clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(255) NOT NULL,
    cidade_cliente VARCHAR(255) NOT NULL
);

-- Tabela de produtos
CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(255) NOT NULL,
    preco_produto DECIMAL(10,2) NOT NULL
);

-- Tabela de pedidos com relacionamentos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade_pedido INT NOT NULL,
    data_pedido DATE NOT NULL,

    -- Relacionamento com a tabela clientes
    CONSTRAINT fk_cliente
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),

    -- Relacionamento com a tabela produtos
    CONSTRAINT fk_produtos
        FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- ======================================================
-- Inserção de dados
-- ======================================================

-- Inserção de clientes
INSERT INTO clientes VALUES
(1, 'Ana Silva', 'São Paulo'),
(2, 'Bruno Costa', 'Rio de Janeiro'),
(3, 'Carla Mendes', 'Belo Horizonte'),
(4, 'Daniel Rocha', 'Curitiba'),
(5, 'Eduarda Lima', 'Porto Alegre'),
(6, 'Felipe Santos', 'Campinas'),
(7, 'Gabriela Alves', 'São Paulo'),
(8, 'Henrique Pires', 'Niterói'),
(9, 'Isabela Torres', 'Recife'),
(10, 'João Martins', 'Fortaleza'),
(11, 'Karen Souza', 'Manaus'),
(12, 'Lucas Nogueira', 'Brasília'),
(13, 'Mariana Farias', 'Salvador'),
(14, 'Nathan Ribeiro', 'Goiânia'),
(15, 'Olivia Barros', 'Florianópolis'),
(16, 'Paulo Azevedo', 'Vitória'),
(17, 'Renata Cunha', 'Natal'),
(18, 'Samuel Teixeira', 'São Luís'),
(19, 'Tatiana Lopes', 'Aracaju'),
(20, 'Victor Moraes', 'Belém');

-- Inserção de produtos
INSERT INTO produtos VALUES
(1, 'Notebook', 3500.00),
(2, 'Mouse', 80.00),
(3, 'Teclado', 150.00),
(4, 'Monitor 24"', 900.00),
(5, 'Headset', 200.00),
(6, 'Impressora', 1200.00),
(7, 'Webcam', 250.00),
(8, 'HD Externo', 450.00),
(9, 'SSD 1TB', 650.00),
(10, 'Pen Drive 64GB', 60.00),
(11, 'Cadeira Gamer', 1100.00),
(12, 'Mesa Escritório', 800.00),
(13, 'Roteador Wi-Fi', 300.00),
(14, 'Fonte 600W', 500.00),
(15, 'Placa de Vídeo', 2800.00),
(16, 'Memória RAM 16GB', 400.00),
(17, 'Processador', 1500.00),
(18, 'Cooler CPU', 180.00),
(19, 'Estabilizador', 220.00),
(20, 'Notebook Stand', 120.00);

-- Inserção de pedidos
INSERT INTO pedidos VALUES
(1, 1, 1, 1, '2024-01-10'),
(2, 1, 2, 2, '2024-01-15'),
(3, 2, 4, 1, '2024-01-18'),
(4, 3, 3, 1, '2024-01-20'),
(5, 4, 5, 1, '2024-01-22'),
(6, 5, 6, 1, '2024-01-25'),
(7, 6, 2, 3, '2024-01-28'),
(8, 7, 7, 1, '2024-02-01'),
(9, 8, 8, 1, '2024-02-03'),
(10, 9, 9, 1, '2024-02-05'),
(11, 10, 10, 4, '2024-02-07'),
(12, 11, 11, 1, '2024-02-10'),
(13, 12, 12, 1, '2024-02-12'),
(14, 13, 13, 1, '2024-02-15'),
(15, 14, 14, 1, '2024-02-18'),
(16, 15, 15, 1, '2024-02-20'),
(17, 16, 16, 2, '2024-02-22'),
(18, 17, 17, 1, '2024-02-25'),
(19, 18, 18, 1, '2024-02-27'),
(20, 19, 2, 1, '2024-03-01');

-- Inserção adicional de pedidos
INSERT INTO pedidos (id_cliente, id_produto, quantidade_pedido, data_pedido)
VALUES
(6, 15, 3, '2025-12-17'),
(9, 3, 3, '2025-12-16');

-- ======================================================
-- Consultas com join e análises
-- ======================================================

-- Exibir vendas com cliente, produto e faturamento
SELECT
    c.nome_cliente,
    p.id_pedido,
    prod.nome_produto,
    prod.preco_produto,
    p.quantidade_pedido,
    p.quantidade_pedido * prod.preco_produto AS faturamento
FROM pedidos p
INNER JOIN clientes c
    ON p.id_cliente = c.id_cliente
INNER JOIN produtos prod
    ON p.id_produto = prod.id_produto;

-- ======================================================
-- Consultas com left join
-- ======================================================

-- Exibir clientes mesmo que não tenham realizado pedidos
SELECT
    c.nome_cliente,
    COALESCE(prod.nome_produto, 'sem produto comprado') AS nome_produto,
    p.id_pedido
FROM clientes c
LEFT JOIN pedidos p
    ON c.id_cliente = p.id_cliente
LEFT JOIN produtos prod
    ON p.id_produto = prod.id_produto;

-- ======================================================
-- Agregações e métricas
-- ======================================================

-- Calcular o faturamento total por cliente
SELECT
    c.nome_cliente,
    SUM(p.quantidade_pedido * prod.preco_produto) AS faturamento
FROM pedidos p
JOIN clientes c
    ON p.id_cliente = c.id_cliente
JOIN produtos prod
    ON p.id_produto = prod.id_produto
GROUP BY c.nome_cliente;

-- ======================================================
-- Identificação de clientes sem pedidos
-- ======================================================

-- Exibir apenas clientes que não realizaram pedidos
SELECT
    c.nome_cliente
FROM clientes c
LEFT JOIN pedidos p
    ON c.id_cliente = p.id_cliente
WHERE p.id_produto IS NULL;

-- ======================================================
-- Fim do script
-- ======================================================
