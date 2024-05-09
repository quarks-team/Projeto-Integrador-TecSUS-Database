-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-05-04 00:02:03.106

-- tables
-- Table: agua
CREATE TABLE `conta_agua` (
    `conta_agua_id` int NOT NULL AUTO_INCREMENT,
    `codigo_rgi` int NOT NULL,
    `agua_conta_mes` date  NULL,
    `hidrometro` varchar(30)  NULL,
    `consumo_agua` float(8,2)  NULL,
    `consumo_esgoto` float(8,2)  NULL,
    `valor_agua` float(8,2)  NULL,
    `valor_esgoto` float(8,2)  NULL,
    `total_conta_agua` float(8,2)  NULL,
    `planta_agua` varchar(2)  NULL,
    `fornecedor_agua` varchar(100)  NULL,
    CONSTRAINT `conta_agua_pk` PRIMARY KEY (`conta_agua_id`)
);

-- Table: contrato_agua
CREATE TABLE `contrato_agua` (
    `contrato_agua_id` int NOT NULL AUTO_INCREMENT,
    `nome_contrato_agua` varchar(100)  UNSIGNED NULL,
    `codigo_rgi` varchar(50)  UNSIGNED NOT NULL,
    `hidrometro` varchar(30)  UNSIGNED NULL,
    `fornecedor_agua` varchar(30)  UNSIGNED NULL,
    CONSTRAINT `contrato_agua_pk` PRIMARY KEY (`contrato_agua_id`)
);

-- Table: contrato_energia
CREATE TABLE `contrato_energia` (
    `contrato_energia_id` int NOT NULL AUTO_INCREMENT,
    `nome_contrato_energia` varchar(100) NOT NULL,
    `fornecedor_energia` varchar(30)  NULL,
    `numero_medidor` varchar(30)  NULL,
    `numero_instalacao` varchar(50)  NULL,
    CONSTRAINT `contrato_energia_pk` PRIMARY KEY (`contrato_energia_id`)
);

-- Table: energia_grupo_a
CREATE TABLE `conta_energia_grupo_a` (
    `conta_energia_grupo_a_id` int NOT NULL AUTO_INCREMENT,
    `energia_conta_mes` date  NULL,
    `total_conta_energia` float(8,2)  NULL,
    `numero_instalacao` varchar(50) NOT NULL,
    `fornecedor_energia` varchar(100)  NULL,
    `numero_medidor` varchar(50)  NULL,
    `planta_energia` varchar(2)  NULL,
    `demanda_pt` float(8,2)  NULL,
    `demanda_fp_cap` float(8,2)  NULL,
    `demanda_fp_ind` float(8,2)  NULL,
    `consumo_pt_vd` float(8,2)  NULL,
    `consumo_fp_cap_vd` float(8,2)  NULL,
    `consumo_fp_ind_vd` float(8,2)  NULL,
    `consumo_a_pt_tusd` float(8,2)  NULL,
    `consumo_a_pt_te` float(8,2)  NULL,
    `consumo_a_fp_tusd` float(8,2)  NULL,
    `consumo_a_fp_te` float(8,2)  NULL,
    CONSTRAINT `conta_energia_grupo_a_pk` PRIMARY KEY (`conta_energia_grupo_a_id`)
);

-- Table: energia_grupo_b
CREATE TABLE `conta_energia_grupo_b` (
    `conta_energia_grupo_b_id` int NOT NULL,
    `energia_conta_mes` date  NULL,
    `total_conta_energia` float(8,2)  NULL,
    `numero_instalacao` varchar(50) NOT NULL,
    `fornecedor` varchar(100)  NULL,
    `numero_medidor` varchar(50)  NULL,
    `planta_energia` varchar(2)  NULL,
    `uso_sist_distr` float(8,2)  NULL,
    `uso_sist_distr_custo` float(8,2)  NULL,
    CONSTRAINT `conta_energia_grupo_b_pk` PRIMARY KEY (`conta_energia_grupo_b_id`)
);

-- Table: fato_conta_agua
CREATE TABLE `fato_conta_agua` (
    `contrato_agua_id` int NOT NULL,
    `conta_agua_id` int NOT NULL,
    `unidade_cliente_id` int NOT NULL,
    `tempo_id` int NOT NULL,
    `local_planta_id` int NOT NULL,
    `total_conta_agua` float(8,2)  NULL,
    `total_consumo_agua` float(8,2)  NULL,
    `total_consumo_esgoto` float(8,2)  NULL,
    `total_valor_agua` float(8,2)  NULL,
    `total_valor_esgoto` float(8,2)  NULL,
    CONSTRAINT `fato_conta_agua_pk` PRIMARY KEY (`contrato_agua_id`,`conta_agua_id`,`tempo_id`,`unidade_cliente_id`,`local_planta_id`)
);

-- Table: fato_conta_energia
CREATE TABLE `fato_conta_energia` (
    `unidade_cliente_id` int NOT NULL,
    `conta_energia_grupo_a_id` int NOT NULL,
    `conta_energia_grupo_b_id` int NOT NULL,
    `tempo_id` int NOT NULL,
    `contrato_energia_id` int NOT NULL,
    `local_planta_id` int NOT NULL,
    `total_conta_energia` float(8,2)  NULL,
    `consumo_total_b` float(8,2)  NULL,
    `consumo_total_a` float(8,2)  NULL,
    `demanda_pt` float(8,2)  NULL,
    `demanda_fp_cap` float(8,2)  NULL,
    `demanda_fp_ind` float(8,2)  NULL,
    CONSTRAINT `fato_conta_energia_pk` PRIMARY KEY (`unidade_cliente_id`,`contrato_energia_id`,`tempo_id`,`conta_energia_grupo_b_id`,`conta_energia_grupo_a_id`,`local_planta_id`)
);

-- Table: local_planta
CREATE TABLE `local_planta` (
    `local_planta_id` int NOT NULL,
    `planta` varchar(2)  NULL,
    CONSTRAINT `local_planta_pk` PRIMARY KEY (`local_planta_id`)
);

-- Table: tempo
CREATE TABLE `tempo` (
    `tempo_id` int NOT NULL AUTO_INCREMENT,
    `tempo_mes` varchar(2)  NULL,
    `tempo_ano` varchar(4)  NULL,
    CONSTRAINT `tempo_pk` PRIMARY KEY (`tempo_id`)
);

-- Table: unidade_cliente
CREATE TABLE `unidade_cliente` (
    `unidade_cliente_id` int NOT NULL AUTO_INCREMENT,
    `cnpj` varchar(50)  NULL,
    CONSTRAINT `unidade_cliente_pk` PRIMARY KEY (`unidade_cliente_id`)
);

-- foreign keys
-- Reference: conta_agua (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `conta_agua` FOREIGN KEY `conta_agua` (`agua_id`)
    REFERENCES `agua` (`agua_id`);

-- Reference: conta_contrato (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `conta_contrato` FOREIGN KEY `conta_contrato` (`contrato_agua_id`)
    REFERENCES `contrato_agua` (`contrato_agua_id`);

-- Reference: fato_conta_agua_local_planta (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `fato_conta_agua_local_planta` FOREIGN KEY `fato_conta_agua_local_planta` (`local_planta_id`)
    REFERENCES `local_planta` (`local_planta_id`);

-- Reference: fato_conta_agua_tempo (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `fato_conta_agua_tempo` FOREIGN KEY `fato_conta_agua_tempo` (`tempo_id`)
    REFERENCES `tempo` (`tempo_id`);

-- Reference: fato_conta_agua_unidade_cliente (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `fato_conta_agua_unidade_cliente` FOREIGN KEY `fato_conta_agua_unidade_cliente` (`unidade_cliente_id`)
    REFERENCES `unidade_cliente` (`unidade_cliente_id`);

-- Reference: fato_conta_energia_contrato_energia (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_contrato_energia` FOREIGN KEY `fato_conta_energia_contrato_energia` (`contr_ener_id`)
    REFERENCES `contrato_energia` (`contrato_energia_id`);

-- Reference: fato_conta_energia_energia_grupo_a (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_energia_grupo_a` FOREIGN KEY `fato_conta_energia_energia_grupo_a` (`energ_a_id`)
    REFERENCES `energia_grupo_a` (`energia_grupo_a_id`);

-- Reference: fato_conta_energia_energia_grupo_b (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_energia_grupo_b` FOREIGN KEY `fato_conta_energia_energia_grupo_b` (`energ_b_id`)
    REFERENCES `energia_grupo_b` (`energia_grupo_b_id`);

-- Reference: fato_conta_energia_local_planta (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_local_planta` FOREIGN KEY `fato_conta_energia_local_planta` (`local_planta_id`)
    REFERENCES `local_planta` (`local_planta_id`);

-- Reference: fato_conta_energia_tempo (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_tempo` FOREIGN KEY `fato_conta_energia_tempo` (`tempo_id`)
    REFERENCES `tempo` (`tempo_id`);

-- Reference: fato_conta_energia_unidade_cliente (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_unidade_cliente` FOREIGN KEY `fato_conta_energia_unidade_cliente` (`unid_cli_id`)
    REFERENCES `unidade_cliente` (`unidade_cliente_id`);

-- End of file.

