--- tables
-- Table: conta_agua
CREATE TABLE `conta_agua` (
    `agua_id` BIGINT AUTO_INCREMENT,
    `cod_rgi` VARCHAR(50),
    `agua_cont_mes` DATE NOT NULL,
    `hidrometro` VARCHAR(50),
    `consu_agua` DOUBLE,
    `consu_esgoto` DOUBLE,
    `valor_agua` DOUBLE,
    `valor_esgo` DOUBLE,
    `total_conta` DOUBLE  NOT NULL,
    `planta` VARCHAR(2)  NOT NULL,
    CONSTRAINT `agua_pk` PRIMARY KEY (`agua_id`)
);

-- Table: contrato_agua
CREATE TABLE `contrato_agua` (
    `contr_agua_id` BIGINT AUTO_INCREMENT,
    `nome_contr_agua` VARCHAR(100)  NULL,
    `cod_liga_rgi` VARCHAR(50),
    `num_instal` VARCHAR(50)  NOT NULL,
    `forne_nome` VARCHAR(50),
    `cnpj` VARCHAR (50),
	`planta` VARCHAR(2)  NOT NULL,
    CONSTRAINT `contrato_agua_pk` PRIMARY KEY (`contr_agua_id`)
);

-- Table: contrato_energia
CREATE TABLE `contrato_energia` (
    `contr_energ_id` BIGINT AUTO_INCREMENT,
    `nome_contr_energ` VARCHAR(100),
    `forne_nome` VARCHAR(100),
    `num_medidor` VARCHAR(50),
    `tensao` VARCHAR(50),
    `unid_metric` VARCHAR(5),
    `cnpj` VARCHAR (50),
    `planta` VARCHAR(2),
    CONSTRAINT `contrato_energia_pk` PRIMARY KEY (`contr_energ_id`)
);

-- Table: conta_energia
CREATE TABLE `conta_energia` (
    `energ_id` BIGINT AUTO_INCREMENT,
    `energ_cont_mes` DATE NOT NULL,
    `num_instal` VARCHAR(50),
    `total_conta_energ` DOUBLE  NOT NULL,
    `num_medidor` VARCHAR(100),
    `consumo_total` DOUBLE,
    `planta` VARCHAR(2)  NOT NULL,
    CONSTRAINT `energia_pk` PRIMARY KEY (`energ_id`)
);

-- Table: fato_conta_agua
CREATE TABLE `fato_conta_agua` (
    `fato_agua_id` BIGINT  auto_increment,
    `contr_id` BIGINT   NOT NULL,
    `agua_id` BIGINT   NOT NULL,
    `unid_cli_id` BIGINT   NOT NULL,
    `temp_id` BIGINT   NOT NULL,
    `mes_ref` DATE  NOT NULL,
    `contr_agua` VARCHAR(100),
    `planta` VARCHAR(2),
    `total_consumo_esgoto` DOUBLE  NOT NULL,
    `total_consumo_agua` DOUBLE  NOT NULL,
    `total_valor_esgoto` DOUBLE  NOT NULL,
    `total_valor_agua` DOUBLE  NOT NULL,
    `total_conta_agua` DOUBLE  NOT NULL,
    CONSTRAINT `fato_conta_agua_pk` PRIMARY KEY (`fato_agua_id`)
);

-- Table: fato_conta_energia
CREATE TABLE `fato_conta_energia` (
    `fato_energ_id` BIGINT  auto_increment,
    `energ_id` BIGINT   NOT NULL,
    `unid_cli_id` BIGINT   NOT NULL,
    `temp_id` BIGINT   NOT NULL,
    `contr_energ_id` BIGINT   NOT NULL,
    `mes_ref` DATE  NOT NULL,
    `contr_energ` VARCHAR(100),
    `planta` VARCHAR(2),
    `total_conta_energ` DOUBLE  NOT NULL,
    CONSTRAINT `fato_conta_energia_pk` PRIMARY KEY (`fato_energ_id`)
);

-- Table: tempo
CREATE TABLE `tempo` (
    `temp_id` BIGINT AUTO_INCREMENT,
    `temp_mes` VARCHAR(2)  NOT NULL,
    `temp_ano` VARCHAR(4)  NOT NULL,
    CONSTRAINT `tempo_pk` PRIMARY KEY (`temp_id`)
);

-- Table: unidade_cliente
CREATE TABLE `unidade_cliente` (
    `unid_cli_id` BIGINT AUTO_INCREMENT,
    `planta` VARCHAR(2)  NOT NULL,
    `cnpj` VARCHAR (50)  NOT NULL,
    CONSTRAINT `unidade_cliente_pk` PRIMARY KEY (`unid_cli_id`)
);

-- foreign keys
-- Reference: conta_agua (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `conta_agua` FOREIGN KEY `conta_agua` (`agua_id`)
    REFERENCES `conta_agua` (`agua_id`);

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
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_contrato_energia` FOREIGN KEY `fato_conta_energia_contrato_energia` (`contr_energ_id`)
    REFERENCES `contrato_energia` (`contr_energ_id`);

-- Reference: fato_conta_energia_energia (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_energia` FOREIGN KEY `fato_conta_energia_energia` (`energ_id`)
    REFERENCES `conta_energia` (`energ_id`);

-- Reference: fato_conta_energia_tempo (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_tempo` FOREIGN KEY `fato_conta_energia_tempo` (`temp_id`)
    REFERENCES `tempo` (`temp_id`);

-- Reference: fato_conta_energia_unidade_cliente (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_unidade_cliente` FOREIGN KEY `fato_conta_energia_unidade_cliente` (`unid_cli_id`)
    REFERENCES `unidade_cliente` (`unid_cli_id`);