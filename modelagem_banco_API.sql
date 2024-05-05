-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-05-04 00:02:03.106

-- tables
-- Table: agua
CREATE TABLE `agua` (
    `agua_id` int NOT NULL AUTO_INCREMENT,
    `cod_rgi` int NOT NULL,
    `agua_cont_mes` date  NULL,
    `hidrom` varchar(30)  NULL,
    `consu_agua` float(8,2)  NULL,
    `consu_esgo` float(8,2)  NULL,
    `valor_agua` float(8,2)  NULL,
    `valor_esgo` float(8,2)  NULL,
    `total_conta_agua` float(8,2)  NULL,
    `planta_agua` varchar(2)  NULL,
    `fornecedor` varchar(100)  NULL,
    CONSTRAINT `agua_pk` PRIMARY KEY (`agua_id`)
);

-- Table: contrato_agua
CREATE TABLE `contrato_agua` (
    `contr_agua_id` int NOT NULL AUTO_INCREMENT,
    `nome_contr_agua` varchar(100)  UNSIGNED NULL,
    `cod_liga_rgi` varchar(50)  UNSIGNED NOT NULL,
    `hidrom` varchar(30)  UNSIGNED NULL,
    `forne_nome` varchar(30)  UNSIGNED NULL,
    CONSTRAINT `contrato_agua_pk` PRIMARY KEY (`contr_agua_id`)
);

-- Table: contrato_energia
CREATE TABLE `contrato_energia` (
    `contr_ener_id` int NOT NULL AUTO_INCREMENT,
    `nome_contr_ener` varchar(100) NOT NULL,
    `fornece_ener` varchar(30)  NULL,
    `num_medidor` varchar(30)  NULL,
    `num_instal` varchar(50)  NULL,
    CONSTRAINT `contrato_energia_pk` PRIMARY KEY (`contr_ener_id`)
);

-- Table: energia_grupo_a
CREATE TABLE `energia_grupo_a` (
    `energ_a_id` int NOT NULL AUTO_INCREMENT,
    `ener_cont_mes` date  NULL,
    `total_conta_ener` float(8,2)  NULL,
    `num_instal` varchar(50) NOT NULL,
    `fornecedor` varchar(100)  NULL,
    `num_medidor` varchar(50)  NULL,
    `planta_ener` varchar(2)  NULL,
    `demanda_pt` float(8,2)  NULL,
    `demanda_fp_cap` float(8,2)  NULL,
    `demanda_fp_ind` float(8,2)  NULL,
    `consu_pt_vd` float(8,2)  NULL,
    `consu_fp_cap_vd` float(8,2)  NULL,
    `consu_fp_ind_vd` float(8,2)  NULL,
    `consu_a_pt_tusd` float(8,2)  NULL,
    `consu_a_pt_te` float(8,2)  NULL,
    `consu_a_fp_tusd` float(8,2)  NULL,
    `consu_a_fp_te` float(8,2)  NULL,
    CONSTRAINT `energia_grupo_a_pk` PRIMARY KEY (`energ_a_id`)
);

-- Table: energia_grupo_b
CREATE TABLE `energia_grupo_b` (
    `energ_b_id` int NOT NULL,
    `ener_cont_mes` date  NULL,
    `total_conta_ener` float(8,2)  NULL,
    `num_instal` varchar(50) NOT NULL,
    `fornecedor` varchar(100)  NULL,
    `num_medidor` varchar(50)  NULL,
    `planta_ener` varchar(2)  NULL,
    `uso_sist_distr` float(8,2)  NULL,
    `uso_sist_distr_custo` float(8,2)  NULL,
    CONSTRAINT `energia_grupo_b_pk` PRIMARY KEY (`energ_b_id`)
);

-- Table: fato_conta_agua
CREATE TABLE `fato_conta_agua` (
    `contr_id` int  NULL,
    `agua_id` int  NULL,
    `unid_cli_id` int  NULL,
    `temp_id` int  NULL,
    `local_planta_id` int  NULL,
    `total_conta_agua` float(8,2)  NULL,
    `total_consumo_agua` float(8,2)  NULL,
    `total_consumo_esgoto` float(8,2)  NULL,
    `total_valor_agua` float(8,2)  NULL,
    `total_valor_esgoto` float(8,2)  NULL,
    CONSTRAINT `fato_conta_agua_pk` PRIMARY KEY (`contr_id`,`agua_id`,`temp_id`,`unid_cli_id`,`local_planta_id`)
);

-- Table: fato_conta_energia
CREATE TABLE `fato_conta_energia` (
    `unid_cli_id` int  NULL,
    `energ_a_id` int  NULL,
    `energ_b_id` int  NULL,
    `temp_id` int  NULL,
    `contr_ener_id` int  NULL,
    `local_planta_id` int  NULL,
    `total_conta_energ` float(8,2)  NULL,
    `consu_total_b` float(8,2)  NULL,
    `consu_total_a` float(8,2)  NULL,
    `demanda_pt` float(8,2)  NULL,
    `demanda_fp_cap` float(8,2)  NULL,
    `demanda_fp_ind` float(8,2)  NULL,
    CONSTRAINT `fato_conta_energia_pk` PRIMARY KEY (`unid_cli_id`,`contr_ener_id`,`temp_id`,`energ_b_id`,`energ_a_id`,`local_planta_id`)
);

-- Table: local_planta
CREATE TABLE `local_planta` (
    `local_planta_id` int  NULL,
    `planta` varchar(2)  NULL,
    CONSTRAINT `local_planta_pk` PRIMARY KEY (`local_planta_id`)
);

-- Table: tempo
CREATE TABLE `tempo` (
    `temp_id` int  NULL AUTO_INCREMENT,
    `temp_mes` varchar(2)  NULL,
    `temp_ano` varchar(4)  NULL,
    CONSTRAINT `tempo_pk` PRIMARY KEY (`temp_id`)
);

-- Table: unidade_cliente
CREATE TABLE `unidade_cliente` (
    `unid_cli_id` int  NULL AUTO_INCREMENT,
    `cnpj` varchar(50)  NULL,
    CONSTRAINT `unidade_cliente_pk` PRIMARY KEY (`unid_cli_id`)
);

-- foreign keys
-- Reference: conta_agua (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `conta_agua` FOREIGN KEY `conta_agua` (`agua_id`)
    REFERENCES `agua` (`agua_id`);

-- Reference: conta_contrato (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `conta_contrato` FOREIGN KEY `conta_contrato` (`contr_id`)
    REFERENCES `contrato_agua` (`contr_agua_id`);

-- Reference: fato_conta_agua_local_planta (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `fato_conta_agua_local_planta` FOREIGN KEY `fato_conta_agua_local_planta` (`local_planta_id`)
    REFERENCES `local_planta` (`local_planta_id`);

-- Reference: fato_conta_agua_tempo (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `fato_conta_agua_tempo` FOREIGN KEY `fato_conta_agua_tempo` (`temp_id`)
    REFERENCES `tempo` (`temp_id`);

-- Reference: fato_conta_agua_unidade_cliente (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `fato_conta_agua_unidade_cliente` FOREIGN KEY `fato_conta_agua_unidade_cliente` (`unid_cli_id`)
    REFERENCES `unidade_cliente` (`unid_cli_id`);

-- Reference: fato_conta_energia_contrato_energia (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_contrato_energia` FOREIGN KEY `fato_conta_energia_contrato_energia` (`contr_ener_id`)
    REFERENCES `contrato_energia` (`contr_ener_id`);

-- Reference: fato_conta_energia_energia_grupo_a (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_energia_grupo_a` FOREIGN KEY `fato_conta_energia_energia_grupo_a` (`energ_a_id`)
    REFERENCES `energia_grupo_a` (`energ_a_id`);

-- Reference: fato_conta_energia_energia_grupo_b (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_energia_grupo_b` FOREIGN KEY `fato_conta_energia_energia_grupo_b` (`energ_b_id`)
    REFERENCES `energia_grupo_b` (`energ_b_id`);

-- Reference: fato_conta_energia_local_planta (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_local_planta` FOREIGN KEY `fato_conta_energia_local_planta` (`local_planta_id`)
    REFERENCES `local_planta` (`local_planta_id`);

-- Reference: fato_conta_energia_tempo (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_tempo` FOREIGN KEY `fato_conta_energia_tempo` (`temp_id`)
    REFERENCES `tempo` (`temp_id`);

-- Reference: fato_conta_energia_unidade_cliente (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_unidade_cliente` FOREIGN KEY `fato_conta_energia_unidade_cliente` (`unid_cli_id`)
    REFERENCES `unidade_cliente` (`unid_cli_id`);

-- End of file.

