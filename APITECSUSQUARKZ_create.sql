-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-04-09 01:06:23.421

-- tables
-- Table: conta_agua
CREATE TABLE conta_agua (
    id_conta bigint auto_increment  NOT NULL,
    contrato_agua bigint  NOT NULL,
    planta varchar(2)  NOT NULL,
    data_conta date  NOT NULL,
    data_vencimento date  NOT NULL,
    consumo_agua double  NULL,
    consumo_esgoto double  NULL,
    valor_agua double  NULL,
    valor_esgoto double  NULL,
    total_conta double  NOT NULL,
    hidrometro varchar(20)   NULL,
    CONSTRAINT conta_agua_pk PRIMARY KEY (id_conta)
);

-- Table: contrato_agua
CREATE TABLE contrato_agua (
    id_contrato bigint auto_increment NOT NULL,
    planta varchar(2)  NOT NULL,
    nome_contrato varchar(50)  NOT NULL,
    tipo_consumidor varchar(20)  NOT NULL,
    fornecedor varchar(50)  NOT NULL,
    hidrometro varchar(20)   NULL,
    cnpj varchar(20)  NOT NULL,
    CONSTRAINT contrato_agua_pk PRIMARY KEY (id_contrato)
);

-- foreign keys
-- Reference: conta_agua_contrato_agua (table: conta_agua)
ALTER TABLE conta_agua ADD CONSTRAINT conta_agua_contrato_agua FOREIGN KEY conta_agua_contrato_agua (contrato_agua)
    REFERENCES contrato_agua (id_contrato);