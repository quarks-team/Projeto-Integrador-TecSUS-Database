--Table: alertas_consumo_agua
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

--Create function
DELIMITER //

CREATE FUNCTION get_last_day_of_month(tempo_mes VARCHAR(2), tempo_ano VARCHAR(4))
RETURNS DATE
DETERMINISTIC
READS SQL DATA
BEGIN
    RETURN LAST_DAY(CONCAT(tempo_ano, '-', tempo_mes, '-01'));
END //

DELIMITER ;

--Create trigger
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
