-- tables
-- Table: conta_agua
CREATE TABLE `conta_agua` (
    `conta_agua_id` int AUTO_INCREMENT NOT NULL ,
    `codigo_rgi` int  NOT NULL,
    `agua_conta_mes` date  NOT NULL,
    `hidrometro` varchar(30) ,
    `consumo_agua` float(8,2) ,
    `consumo_esgoto` float(8,2) ,
    `valor_agua` float(8,2) ,
    `valor_esgoto` float(8,2) ,
    `total_conta_agua` float(8,2) ,
    `planta_agua` varchar(2) ,
    `fornecedor` varchar(100) ,
    CONSTRAINT `conta_agua_pk` PRIMARY KEY (`conta_agua_id`)
);

-- Table: conta_energia_grupo_a
CREATE TABLE `conta_energia_grupo_a` (
    `conta_energia_a_id` int AUTO_INCREMENT NOT NULL,
    `energia_conta_mes` date  NOT NULL,
    `total_conta_energia` float(8,2) ,
    `numero_instalacao` varchar(50) ,
    `fornecedor` varchar(100) ,
    `numero_medidor` varchar(50) ,
    `planta_energia` varchar(2) ,
    `demanda_pt` float(8,2) ,
    `demanda_fp_cap` float(8,2) ,
    `demanda_fp_ind` float(8,2) ,
    `consumo_pt_vd` float(8,2) ,
    `consumo_fp_cap_vd` float(8,2) ,
    `consumo_fp_ind_vd` float(8,2) ,
    `consumo_a_pt_tusd` float(8,2) ,
    `consumo_a_pt_te` float(8,2) ,
    `consumo_a_fp_tusd` float(8,2) ,
    `consumo_a_fp_te` float(8,2) ,
    CONSTRAINT `conta_energia_grupo_a_pk` PRIMARY KEY (`conta_energia_a_id`)
);

-- Table: conta_energia_grupo_b
CREATE TABLE `conta_energia_grupo_b` (
    `conta_energia_b_id` int AUTO_INCREMENT NOT NULL,
    `energia_conta_mes` date  NOT NULL,
    `total_conta_energia` float(8,2) ,
    `numero_instalacao` varchar(50)  NOT NULL,
    `fornecedor` varchar(100) ,
    `numero_medidor` varchar(50) ,
    `planta_energia` varchar(2) ,
    `uso_sist_distr` float(8,2) ,
    `uso_sist_distr_custo` float(8,2) ,
    CONSTRAINT `conta_energia_grupo_b_pk` PRIMARY KEY (`conta_energia_b_id`)
);

-- Table: contrato_agua
CREATE TABLE `contrato_agua` (
    `contrato_agua_id` int AUTO_INCREMENT NOT NULL,
    `nome_contrato_agua` varchar(100)  NOT NULL,
    `codigo_rgi` varchar(50)  NOT NULL,
    `hidrometro` varchar(30) ,
    `fornecedor_agua` varchar(50),
    `cnpj` varchar(50),
    CONSTRAINT `contrato_agua_pk` PRIMARY KEY (`contrato_agua_id`)
);

-- Table: contrato_energia
CREATE TABLE `contrato_energia` (
    `contrato_energia_id` int AUTO_INCREMENT NOT NULL,
    `nome_contrato_energia` varchar(100)  NOT NULL,
    `fornecedor_energia` varchar(50) ,
    `numero_medidor` varchar(30) ,
    `numero_instalacao` varchar(50)  NOT NULL,
    `demanda_ponta` float(10,2) ,
    `demanda_fora_ponta` float(10,2) ,
     `cnpj` varchar(50),
    CONSTRAINT `contrato_energia_pk` PRIMARY KEY (`contrato_energia_id`)
);

-- Table: fato_conta_agua
CREATE TABLE `fato_conta_agua` (
    `contrato_agua_id` int  NOT NULL,
    `conta_agua_id` int  NOT NULL,
    `unidade_cliente_id` int  NOT NULL,
    `tempo_id` int  NOT NULL,
    `local_planta_id` int  NOT NULL,
    `total_conta_agua` float(8,2) ,
    `total_consumo_agua` float(8,2) ,
    `total_consumo_esgoto` float(8,2) ,
    `total_valor_agua` float(8,2) ,
    `total_valor_esgoto` float(8,2) ,
    CONSTRAINT `fato_conta_agua_pk` PRIMARY KEY (`contrato_agua_id`,`conta_agua_id`,`tempo_id`,`unidade_cliente_id`,`local_planta_id`)
);

-- Table: fato_conta_energia
CREATE TABLE `fato_conta_energia` (
    `unidade_cliente_id` int  NOT NULL,
    `conta_energia_a_id` int  NULL,
    `conta_energia_b_id` int  NULL,
    `tempo_id` int  NOT NULL,
    `contrato_energia_id` int  NOT NULL,
    `local_planta_id` int  NOT NULL,
    `total_conta_energia` float(8,2) ,
    `consumo_total_b` float(8,2) ,
    `consumo_total_a` float(8,2) ,
    `demanda_pt` float(8,2) ,
    `demanda_fp_cap` float(8,2) ,
    `demanda_fp_ind` float(8,2) ,
    `demanda_ponta` float(10,2) ,
    `demanda_fora_ponta` float(10,2)
);

-- Table: local_planta
CREATE TABLE `local_planta` (
    `local_planta_id` int  AUTO_INCREMENT NOT NULL,
    `planta` varchar(2)  NOT NULL,
    CONSTRAINT `local_planta_pk` PRIMARY KEY (`local_planta_id`)
);

-- Table: tempo
CREATE TABLE `tempo` (
    `tempo_id` int AUTO_INCREMENT NOT NULL,
    `tempo_mes` varchar(2)  NOT NULL,
    `tempo_ano` varchar(4)  NOT NULL,
    CONSTRAINT `tempo_pk` PRIMARY KEY (`tempo_id`)
);

-- Table: unidade_cliente
CREATE TABLE `unidade_cliente` (
    `unidade_cliente_id` int AUTO_INCREMENT NOT NULL,
    `cnpj` varchar(50)  NOT NULL,
    CONSTRAINT `unidade_cliente_pk` PRIMARY KEY (`unidade_cliente_id`)
);

-- Table: alertas_consumo_agua
CREATE TABLE alertas_consumo_agua (
    alerta_consumo_agua_id INT AUTO_INCREMENT PRIMARY KEY,
    contrato_agua_id INT,
    unidade_cliente_id INT,
    local_planta_id INT,
    data_alerta DATE,
    consumo_atual DECIMAL(8, 2),
    media_trimestral DECIMAL(8, 2),
    excesso_percentual DECIMAL(8, 2)
);

-- foreign keys
-- Reference: conta_agua (table: fato_conta_agua)
ALTER TABLE `fato_conta_agua` ADD CONSTRAINT `conta_agua` FOREIGN KEY `conta_agua` (`conta_agua_id`)
    REFERENCES `conta_agua` (`conta_agua_id`);

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
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_contrato_energia` FOREIGN KEY `fato_conta_energia_contrato_energia` (`contrato_energia_id`)
    REFERENCES `contrato_energia` (`contrato_energia_id`);

-- Reference: fato_conta_energia_energia_grupo_a (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_energia_grupo_a` FOREIGN KEY `fato_conta_energia_energia_grupo_a` (`conta_energia_a_id`)
    REFERENCES `conta_energia_grupo_a` (`conta_energia_a_id`);

-- Reference: fato_conta_energia_energia_grupo_b (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_energia_grupo_b` FOREIGN KEY `fato_conta_energia_energia_grupo_b` (`conta_energia_b_id`)
    REFERENCES `conta_energia_grupo_b` (`conta_energia_b_id`);

-- Reference: fato_conta_energia_local_planta (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_local_planta` FOREIGN KEY `fato_conta_energia_local_planta` (`local_planta_id`)
    REFERENCES `local_planta` (`local_planta_id`);

-- Reference: fato_conta_energia_tempo (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_tempo` FOREIGN KEY `fato_conta_energia_tempo` (`tempo_id`)
    REFERENCES `tempo` (`tempo_id`);

-- Reference: fato_conta_energia_unidade_cliente (table: fato_conta_energia)
ALTER TABLE `fato_conta_energia` ADD CONSTRAINT `fato_conta_energia_unidade_cliente` FOREIGN KEY `fato_conta_energia_unidade_cliente` (`unidade_cliente_id`)
    REFERENCES `unidade_cliente` (`unidade_cliente_id`);

-- unique key for fato conta_energia, not a PK because bill type a or b can be null(not both at the same row) 
ALTER TABLE `fato_conta_energia`
ADD CONSTRAINT `unique_fato_conta_energia`
UNIQUE (`unidade_cliente_id`, `contrato_energia_id`, `tempo_id`, `conta_energia_b_id`, `conta_energia_a_id`, `local_planta_id`);



-- Create function
DELIMITER //

CREATE FUNCTION get_last_day_of_month(tempo_mes VARCHAR(2), tempo_ano VARCHAR(4))
RETURNS DATE
DETERMINISTIC
READS SQL DATA
BEGIN
    RETURN LAST_DAY(CONCAT(tempo_ano, '-', tempo_mes, '-01'));
END //

DELIMITER ;

-- Create trigger
DELIMITER //

CREATE TRIGGER trg_CheckConsumo
AFTER INSERT ON fato_conta_agua
FOR EACH ROW
BEGIN
    DECLARE media_trimestral DECIMAL(8, 2);
    DECLARE data_consumo DATE;

    -- Obtém a data de consumo com base no tempo_id
    SELECT get_last_day_of_month(tempo_mes, tempo_ano) INTO data_consumo
    FROM tempo
    WHERE tempo_id = NEW.tempo_id;

    -- Calcula a média trimestral dos últimos 3 meses
    SELECT AVG(total_consumo_agua) INTO media_trimestral
    FROM fato_conta_agua
    WHERE unidade_cliente_id = NEW.unidade_cliente_id
      AND local_planta_id = NEW.local_planta_id
      AND tempo_id IN (
          SELECT tempo_id
          FROM tempo
          WHERE STR_TO_DATE(CONCAT(tempo_ano, '-', tempo_mes, '-01'), '%Y-%m-%d') >= DATE_SUB(data_consumo, INTERVAL 3 MONTH)
      );

    -- Verifica se o consumo atual é 30% maior que a média trimestral
    IF NEW.total_consumo_agua > media_trimestral * 1.30 THEN
        INSERT INTO alertas_consumo_agua (
            contrato_agua_id,
            unidade_cliente_id,
            local_planta_id,
            data_alerta,
            consumo_atual,
            media_trimestral,
            excesso_percentual
        )
        VALUES (
            NEW.contrato_agua_id,
            NEW.unidade_cliente_id,
            NEW.local_planta_id,
            data_consumo,
            NEW.total_consumo_agua,
            media_trimestral,
            ((NEW.total_consumo_agua - media_trimestral) / media_trimestral) * 100
        );
    END IF;
END //

DELIMITER ;
