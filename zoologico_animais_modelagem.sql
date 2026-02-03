/*
=========================================================
Projeto: Fundamentos de SQL - Sistema de Zoológico
Arquivo: zoologico_modelagem_sql.sql

Descrição:
Este script demonstra a criação de um banco de dados
e a modelagem inicial de um sistema de zoológico,
incluindo tabelas de animais, recintos, tratadores
e alimentação.

Objetivo:
Praticar conceitos fundamentais de SQL, como:
- Criação de banco de dados
- Criação de tabelas
- Definição de chaves primárias
- Uso de tipos de dados e enums
- Organização inicial de um modelo relacional

Autor(a): Marcela Morais
=========================================================
*/

-- ======================================================
-- Criação e uso do banco de dados
-- ======================================================

-- Cria o banco de dados do zoológico
CREATE DATABASE zoologico;

-- Define o banco de dados ativo
USE zoologico;

-- Exibe todos os bancos de dados disponíveis
SHOW DATABASES;

-- ======================================================
-- Criação da tabela animal
-- ======================================================

-- Cria a tabela responsável por armazenar os animais
CREATE TABLE animal (
    -- Identificador único do animal
    id INT AUTO_INCREMENT PRIMARY KEY,

    -- Nome do animal
    nome VARCHAR(100) NOT NULL,

    -- Espécie do animal
    especie VARCHAR(100) NOT NULL,

    -- Sexo do animal
    sexo ENUM('m','f') NOT NULL,

    -- Data de nascimento do animal
    data_nascimento DATE,

    -- Recinto onde o animal está alocado
    recinto VARCHAR(100),

    -- Nome do tratador responsável pelo animal
    tratador_responsavel VARCHAR(100)
);

-- Exibe as tabelas criadas no banco de dados
SHOW TABLES;

-- ======================================================
-- Criação da tabela recinto
-- ======================================================

-- Cria a tabela responsável por armazenar os recintos
CREATE TABLE recinto (
    -- Identificador único do recinto
    id_recinto INT AUTO_INCREMENT PRIMARY KEY,

    -- Nome do recinto
    nome_recinto VARCHAR(255) NOT NULL,

    -- Tipo do recinto
    tipo_recinto ENUM('savana', 'aquario', 'insetário', 'floresta', 'lago', 'outro'),

    -- Localização física do recinto
    localizacao_recinto VARCHAR(255) NOT NULL,

    -- Capacidade máxima de animais no recinto
    capacidade_recinto INT NOT NULL
);

-- Exibe os dados da tabela recinto
SELECT *
FROM recinto;

-- ======================================================
-- Criação da tabela tratador
-- ======================================================

-- Cria a tabela responsável por armazenar os tratadores
CREATE TABLE tratador (
    -- Identificador único do tratador
    id_tratador INT AUTO_INCREMENT PRIMARY KEY,

    -- CPF do tratador (valor único)
    cpf_tratador BIGINT UNIQUE NOT NULL,

    -- Quantidade de animais sob responsabilidade do tratador
    filho_tratado INT
);

-- ======================================================
-- Criação da tabela alimentacao
-- ======================================================

-- Cria a tabela de alimentação (estrutura inicial)
-- Esta tabela pode ser expandida futuramente
CREATE TABLE alimentacao (
    -- Identificador do registro de alimentação
    id INT
);

-- ======================================================
-- Verificação final das tabelas criadas
-- ======================================================

-- Exibe todas as tabelas do banco de dados
SHOW TABLES;

-- ======================================================
-- Fim do script
-- ======================================================
