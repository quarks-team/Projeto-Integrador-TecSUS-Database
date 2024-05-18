
insert into fato_conta_energia(energ_id,unid_cli_id,temp_id,mes_ref,contr_ener_id,total_conta_energ) 
SELECT e.energ_id, u.unid_cli_id, t.temp_id, e.ener_cont_mes AS mes_ref, c.contr_ener_id AS contr_id, 
SUM(e.total_conta_ener) AS total_conta_energia FROM unidade_cliente u INNER JOIN contrato_energia c 
ON u.camp_ext_3 = c.camp_ext_3 INNER JOIN energia e ON e.num_instal = c.num_instal INNER JOIN tempo t ON 
t.temp_mes = date_format(ener_cont_mes, '%d') AND t.temp_ano = date_format(e.ener_cont_mes, '%Y') GROUP BY 
c.contr_ener_id, e.energ_id, u.unid_cli_id, e.ener_cont_mes, t.temp_id;

--Select para conta agua funcional
INSERT INTO fato_conta_agua(contrato_agua_id, conta_agua_id, unidade_cliente_id, tempo_id, local_planta_id, total_conta_agua, total_consumo_agua, total_consumo_esgoto, total_valor_agua, total_valor_esgoto)
SELECT c.contrato_agua_id, conta.conta_agua_id, u.unidade_cliente_id, t.tempo_id, l.local_planta_id, 
SUM(conta.total_conta_agua) AS total_conta_agua, SUM(conta.consumo_agua) AS total_consumo_agua,
SUM(conta.consumo_esgoto) AS total_consumo_esgoto, SUM(conta.consumo_esgoto) AS total_consumo_esgoto,
SUM(conta.valor_agua) AS total_valor_agua, SUM(conta.valor_esgoto) AS total_valor_esgoto
FROM unidade_cliente u INNER JOIN contrato_agua c ON u.cnpj = c.cnpj 
INNER JOIN conta_agua conta ON conta.codigo_rgi = c.codigo_rgi 
INNER JOIN local_planta l ON l.planta = conta.planta_agua
INNER JOIN tempo t ON t.tempo_mes = date_format(conta.agua_conta_mes, '%m') 
AND t.tempo_ano = date_format(conta.agua_conta_mes, '%Y') 
GROUP BY c.contrato_agua_id, conta.conta_agua_id, u.unidade_cliente_id, conta.agua_conta_mes,
 t.tempo_id, l.local_planta_id;