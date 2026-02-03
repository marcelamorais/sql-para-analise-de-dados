/*
=========================================================
Projeto: Fundamentos de SQL - Sample Users
Arquivo: sample_users_sql_desafios.sql

Descrição:
Este script demonstra a criação de uma tabela de usuários,
inserção de dados e consultas SQL utilizando filtros,
operadores lógicos e comandos de atualização.

Objetivo:
Praticar comandos SQL fundamentais, incluindo:
- CREATE TABLE
- INSERT
- SELECT com WHERE
- Operadores AND / OR
- UPDATE com operações aritméticas

Autor(a): Marcela Morais
=========================================================
*/

-- ======================================================
-- Seleção do banco de dados
-- ======================================================

-- Define o banco de dados ativo
-- Observação: o banco deve existir previamente
USE exemplo;

-- ======================================================
-- Criação da tabela sample_users
-- ======================================================

-- Cria a tabela responsável por armazenar dados de usuários
CREATE TABLE sample_users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    account_name VARCHAR(255),
    user_name VARCHAR(255),
    age INT,
    gender VARCHAR(255),
    date_joined DATE,
    posts INT,
    likes INT,
    followers INT,
    following_user INT
);

-- ======================================================
-- Inserção de dados
-- ======================================================

-- Insere registros de usuários para simular uma base real
INSERT INTO sample_users (
    user_id,
    account_name,
    user_name,
    age,
    gender,
    date_joined,
    posts,
    likes,
    followers,
    following_user
)
VALUES
(1, 'john_doe123', 'John Doe', 30, 'male', '2023-01-01', 100, 250, 150, 200),
(2, 'jane_smith456', 'Jane Smith', 28, 'female', '2023-02-15', 85, 300, 200, 180),
(3, 'carol_star', 'Carol Star', 22, 'female', '2023-03-10', 50, 120, 90, 60),
(4, 'mike_dev', 'Mike Dev', 35, 'male', '2023-01-20', 200, 500, 300, 280);

-- ======================================================
-- Consulta de verificação
-- ======================================================

-- Exibe todos os registros da tabela
SELECT *
FROM sample_users;

-- ======================================================
-- Desafio 1 (Fácil)
-- ======================================================

-- Mostrar todos os dados de usuários com mais de 25 anos
SELECT *
FROM sample_users
WHERE age > 25;

-- Mostrar todos os usuários com mais de 100 curtidas
SELECT *
FROM sample_users
WHERE likes > 100;

-- ======================================================
-- Desafio 2 (Médio)
-- ======================================================

-- Mostrar o nome dos usuários com mais de 80 posts e mais de 200 curtidas
SELECT
    user_name
FROM sample_users
WHERE posts > 80
  AND likes > 200;

-- ======================================================
-- Desafio 3 (Intermediário)
-- ======================================================

-- Mostrar o nome dos usuários com mais de 250 curtidas
-- ou mais de 100 seguidores
SELECT
    user_name
FROM sample_users
WHERE likes > 250
   OR followers > 100;

-- ======================================================
-- Desafio 4 (Difícil)
-- ======================================================

-- Atualizar a coluna likes somando 50 curtidas ao valor atual
UPDATE sample_users
SET likes = likes + 50;

-- Exibir o nome do usuário e a nova quantidade de curtidas
SELECT
    user_name,
    likes
FROM sample_users;

-- Consulta final para validação dos dados
SELECT *
FROM sample_users;

-- ======================================================
-- Fim do script
-- ======================================================
