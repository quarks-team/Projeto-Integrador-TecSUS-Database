-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-04-13 01:20:42.31

--- tables
-- Table: agua
CREATE TABLE `agua` (
    `agua_id` int AUTO_INCREMENT  NOT NULL,
    `cod_rgi` varchar(50),
    `agua_cont_mes` date NOT NULL,
    `hidrom` varchar(30),
    `consu_agua` float(8,2),
    `consu_esgo` float(8,2),
    `valor_agua` float(8,2),
    `valor_esgo` float(8,2),
    `total_conta_agua` float(8,2)  NOT NULL,
    `planta_agua` varchar(2)  NOT NULL,
    CONSTRAINT `agua_pk` PRIMARY KEY (`agua_id`)
);

-- Table: contrato_agua
CREATE TABLE `contrato_agua` (
    `contr_agua_id` int AUTO_INCREMENT  NOT NULL,
    `nome_contr_agua` varchar(100)  NULL,
    `cod_liga_rgi` varchar(50),
    `forne_nome` varchar(30)  NOT NULL,
    `camp_ext_3` varchar(30),
    `camp_ext_4` varchar(30),
	`planta` varchar(2)  NOT NULL,
    CONSTRAINT `contrato_agua_pk` PRIMARY KEY (`contr_agua_id`)
);

-- Table: contrato_energia
CREATE TABLE `contrato_energia` (
    `contr_ener_id` int AUTO_INCREMENT  NOT NULL,
    `nome_contr_ener` varchar(100),
    `fornece_ener` varchar(50),
    `num_medidor` varchar(30),
    `num_instal` varchar(30),
    `camp_ext_3` varchar(30),
    `camp_ext_4` varchar(30),
    `planta` varchar(2),
    CONSTRAINT `contrato_energia_pk` PRIMARY KEY (`contr_ener_id`)
);

-- Table: energia
CREATE TABLE `energia` (
    `energ_id` int AUTO_INCREMENT  NOT NULL,
    `ener_cont_mes` date NOT NULL,
    `num_instal` varchar(50),
    `total_conta_ener` float(8,2)  NOT NULL,
    `fornecedor` varchar(30)  NOT NULL,
    `num_medidor` varchar(30),
    `consumo_total` float(8,2),
    `planta_ener` varchar(2)  NOT NULL,
    CONSTRAINT `energia_pk` PRIMARY KEY (`energ_id`)
);

-- Table: fato_conta_agua
CREATE TABLE `fato_conta_agua` (
    `fato_agua_id` int  auto_increment NOT NULL,
    `contr_id` int   NOT NULL,
    `agua_id` int   NOT NULL,
    `unid_cli_id` int   NOT NULL,
    `temp_id` int   NOT NULL,
    `mes_ref` date  NOT NULL,
    `total_conta_agua` float(8,2)  NOT NULL,
    CONSTRAINT `fato_conta_agua_pk` PRIMARY KEY (`fato_agua_id`)
);

-- Table: fato_conta_energia
CREATE TABLE `fato_conta_energia` (
    `fato_energ_id` int  auto_increment NOT NULL,
    `energ_id` int   NOT NULL,
    `unid_cli_id` int   NOT NULL,
    `temp_id` int   NOT NULL,
    `mes_ref` date  NOT NULL,
    `contr_ener_id` int   NOT NULL,
    `total_conta_energ` float(8,2)  NOT NULL,
    CONSTRAINT `fato_conta_energia_pk` PRIMARY KEY (`fato_energ_id`)
);

-- Table: tempo
CREATE TABLE `tempo` (
    `temp_id` int AUTO_INCREMENT  NOT NULL,
    `temp_mes` VARCHAR(2)  NOT NULL,
    `temp_ano` VARCHAR(4)  NOT NULL,
    CONSTRAINT `tempo_pk` PRIMARY KEY (`temp_id`)
);

-- Table: unidade_cliente
CREATE TABLE `unidade_cliente` (
    `unid_cli_id` int AUTO_INCREMENT  NOT NULL,
    `planta` varchar(2)  NOT NULL,
    `camp_ext_3` varchar(50)  NOT NULL,
    `camp_ext_4` varchar(50)  NOT NULL,
    CONSTRAINT `unidade_cliente_pk` PRIMARY KEY (`unid_cli_id`)
);

-- foreign keys
-- Reference: conta_agua (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `conta_agua` FOREIGN KEY `conta_agua` (`agua_id`)
    REFERENCES `agua` (`agua_id`);

-- Reference: conta_contrato (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `conta_contrato` FOREIGN KEY `conta_contrato` (`contr_id`)
    REFERENCES `contrato_agua` (`contr_agua_id`);

-- Reference: fato_conta_agua_tempo (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `fato_conta_agua_tempo` FOREIGN KEY `fato_conta_agua_tempo` (`temp_id`)
    REFERENCES `tempo` (`temp_id`);

-- Reference: fato_conta_agua_unidade_cliente (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `fato_conta_agua_unidade_cliente` FOREIGN KEY `fato_conta_agua_unidade_cliente` (`unid_cli_id`)
    REFERENCES `unidade_cliente` (`unid_cli_id`);

-- Reference: fato_conta_energia_contrato_energia (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_contrato_energia` FOREIGN KEY `fato_conta_energia_contrato_energia` (`contr_ener_id`)
    REFERENCES `contrato_energia` (`contr_ener_id`);

-- Reference: fato_conta_energia_energia (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_energia` FOREIGN KEY `fato_conta_energia_energia` (`energ_id`)
    REFERENCES `energia` (`energ_id`);

-- Reference: fato_conta_energia_tempo (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_tempo` FOREIGN KEY `fato_conta_energia_tempo` (`temp_id`)
    REFERENCES `tempo` (`temp_id`);

-- Reference: fato_conta_energia_unidade_cliente (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_unidade_cliente` FOREIGN KEY `fato_conta_energia_unidade_cliente` (`unid_cli_id`)
    REFERENCES `unidade_cliente` (`unid_cli_id`);