/*
=========================================================
Projeto: Fundamentos de SQL
Arquivo: user_data_sql_basics.sql
Descrição:
Este script demonstra a criação de um banco de dados,
definição de tabela, inserção de dados e consultas SQL
básicas para análise de dados.

Objetivo:
Praticar comandos SQL essenciais utilizados no dia a dia
de analistas de dados, como SELECT, WHERE, ORDER BY e
funções de agregação.

Autor(a): Marcela Morais
=========================================================
*/

-- ======================================================
-- Criação e uso do banco de dados
-- ======================================================

-- Cria o banco de dados que armazenará as tabelas do projeto
CREATE DATABASE user_data_sql_basics;

-- Define o banco de dados ativo para execução dos comandos
USE user_data_sql_basics;

-- ======================================================
-- Criação da tabela user_data
-- ======================================================

-- Cria a tabela responsável por armazenar dados de usuários
CREATE TABLE user_data (
    -- Identificador único do usuário
    user_id INT AUTO_INCREMENT PRIMARY KEY,

    -- Nome da conta do usuário na plataforma
    account_name VARCHAR(100),

    -- Nome real do usuário
    user_name VARCHAR(100),

    -- Idade do usuário
    age INT,

    -- Gênero do usuário
    gender VARCHAR(10),

    -- Data de cadastro na plataforma
    date_joined DATE,

    -- Quantidade de postagens realizadas
    posts INT,

    -- Quantidade total de curtidas recebidas
    likes INT,

    -- Número de seguidores
    followers INT,

    -- Número de contas que o usuário segue
    following_user INT
);

-- ======================================================
-- Inserção de dados
-- ======================================================

-- Insere registros de usuários para simular uma base real
INSERT INTO user_data (
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
(1, 'starlight_dancer', 'Emma Johnson', 28, 'female', '2020-05-15', 120, 450, 200, 150),
(2, 'zen_master', 'Chris Roberts', 30, 'male', '2019-12-20', 80, 300, 150, 180),
(3, 'neon_ninja', 'Jordan Lee', 25, 'other', '2021-02-10', 95, 600, 250, 220),
(4, 'sky_wanderer', 'Alex Smith', 32, 'male', '2018-11-04', 200, 900, 350, 300),
(5, 'sunset_lover', 'Taylor Brown', 27, 'female', '2017-09-01', 150, 800, 400, 380);

-- ======================================================
-- Consultas básicas
-- ======================================================

-- Exibe todos os registros da tabela user_data
SELECT *
FROM user_data;

-- ======================================================
-- Consultas analíticas
-- ======================================================

-- 1. Listar contas ordenadas pelo número de seguidores (ranking)
SELECT
    account_name,
    followers
FROM user_data
ORDER BY followers
