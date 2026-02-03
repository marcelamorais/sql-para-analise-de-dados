/*
=========================================================
Projeto: Fundamentos de SQL - Cadastro de Animais
Arquivo: zoologico_animais_fundamentos.sql

Descrição:
Este script demonstra a criação de um banco de dados
e de uma tabela para cadastro de animais em um zoológico,
além de consultas básicas para verificação dos dados.

Objetivo:
Praticar comandos SQL fundamentais, incluindo:
- CREATE DATABASE
- USE
- CREATE TABLE
- Tipos de dados e ENUM
- SELECT
- SHOW TABLES

Autor(a): Marcela Morais
=========================================================
*/

-- ======================================================
-- Criação e uso do banco de dados
-- ======================================================

-- Cria o banco de dados do zoológico
CREATE DATABASE zoologico;

-- Exibe todos os bancos de dados disponíveis
SHOW DATABASES;

-- Define o banco de dados ativo
USE zoologico;

-- ======================================================
-- Criação da tabela animal
-- ======================================================

-- Cria a tabela responsável por armazenar os animais
CREATE TABLE animal (
    -- Identificador único do animal
    id_animal INT AUTO_INCREMENT PRIMARY KEY,

    -- Nome do animal
    nome_animal VARCHAR(255) NOT NULL,

    -- Espécie do animal
    especie_animal VARCHAR(255) NOT NULL,

    -- Sexo do animal
    sexo_animal ENUM('m', 'f') NOT NULL,

    -- Data de nascimento do animal
    data_nasc_animal DATE,

    -- Recinto onde o animal está localizado
    recinto_animal VARCHAR(255) NOT NULL,

    -- Nome do tratador responsável pelo animal
    tratador_animal VARCHAR(255)
);

-- ======================================================
-- Consultas de verificação
-- ======================================================

-- Exibe todos os registros da tabela animal
SELECT *
FROM animal;

-- Exibe todas as tabelas criadas no banco de dados
SHOW TABLES;

-- ======================================================
-- Fim do script
-- ======================================================
