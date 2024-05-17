
insert into fato_conta_energia(energ_id,unid_cli_id,temp_id,mes_ref,contr_ener_id,total_conta_energ) 
SELECT e.energ_id, u.unid_cli_id, t.temp_id, e.ener_cont_mes AS mes_ref, c.contr_ener_id AS contr_id, 
SUM(e.total_conta_ener) AS total_conta_energia FROM unidade_cliente u INNER JOIN contrato_energia c 
ON u.camp_ext_3 = c.camp_ext_3 INNER JOIN energia e ON e.num_instal = c.num_instal INNER JOIN tempo t ON 
t.temp_mes = date_format(ener_cont_mes, '%d') AND t.temp_ano = date_format(e.ener_cont_mes, '%Y') GROUP BY 
c.contr_ener_id, e.energ_id, u.unid_cli_id, e.ener_cont_mes, t.temp_id;


INSERT INTO fato_conta_agua(contr_id,agua_id,unid_cli_id,temp_id,mes_ref,total_conta_agua)
SELECT c.contr_agua_id AS contr_id, a.agua_id, u.unid_cli_id, t.temp_id, a.agua_cont_mes AS mes_ref, SUM(a.total_conta_agua) AS total_conta_agua FROM unidade_cliente u INNER JOIN contrato_agua c ON u.camp_ext_3 = c.camp_ext_3 INNER JOIN agua a ON a.cod_rgi = c.cod_liga_rgi INNER JOIN tempo t ON t.temp_mes = date_format(agua_cont_mes, '%d') AND t.temp_ano = date_format(a.agua_cont_mes, '%Y') GROUP BY c.contr_agua_id, a.agua_id, u.unid_cli_id, a.agua_cont_mes, t.temp_id;