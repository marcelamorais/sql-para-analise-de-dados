/*
=========================================================
Projeto: Fundamentos de SQL - Sistema Imobiliário
Arquivo: imobiliaria_sql_fundamentos.sql

Descrição:
Este script demonstra a criação de um banco de dados,
definição de tabela, inserção, consulta, atualização,
remoção de dados e alteração de estrutura de tabela,
utilizando um cenário de imobiliária.

Objetivo:
Praticar comandos SQL essenciais utilizados no dia a dia
de analistas de dados e profissionais de tecnologia,
como CREATE, INSERT, SELECT, UPDATE, DELETE e ALTER TABLE.

Autor(a): Marcela Morais
=========================================================
*/

-- ======================================================
-- Criação e uso do banco de dados
-- ======================================================

-- Cria a base de dados da imobiliária
CREATE DATABASE imobiliaria;

-- Define o banco de dados ativo
USE imobiliaria;

-- Exibe todos os bancos de dados disponíveis
SHOW DATABASES;

-- ======================================================
-- Criação da tabela imoveis
-- ======================================================

-- Cria a tabela responsável por armazenar os imóveis
CREATE TABLE imoveis (
    -- Identificador único do imóvel
    id_moveis INT AUTO_INCREMENT PRIMARY KEY,

    -- Cidade onde o imóvel está localizado
    cidade_imoveis VARCHAR(255) NOT NULL,

    -- Tipo do imóvel (valores pré-definidos)
    tipo_imoveis ENUM('casa', 'sobrado', 'terreno', 'comercial') NOT NULL,

    -- Valor do imóvel
    valor_imoveis DECIMAL(12,2) NOT NULL,

    -- Data de anúncio do imóvel
    data_anuncio_imoveis DATE NOT NULL
);

-- Exibe as tabelas criadas no banco de dados
SHOW TABLES;

-- ======================================================
-- Inserção de dados
-- ======================================================

-- Insere registros de imóveis para simular uma base real
INSERT INTO imoveis (
    cidade_imoveis,
    tipo_imoveis,
    valor_imoveis,
    data_anuncio_imoveis
)
VALUES
('cambuci', 'terreno', 80000.00, '2025-12-12'),
('analia franco', 'comercial', 90000.00, '2025-11-12'),
('praia grande', 'casa', 150000.00, '2025-12-11'),
('campinas', 'casa', 680000.00, '2024-03-10'),
(
