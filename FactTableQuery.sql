
insert into fato_conta_energia(energ_id,unid_cli_id,temp_id,mes_ref,contr_ener_id,total_conta_energ) 
SELECT e.energ_id, u.unid_cli_id, t.temp_id, e.ener_cont_mes AS mes_ref, c.contr_ener_id AS contr_id, 
SUM(e.total_conta_ener) AS total_conta_energia FROM unidade_cliente u INNER JOIN contrato_energia c 
ON u.camp_ext_3 = c.camp_ext_3 INNER JOIN energia e ON e.num_instal = c.num_instal INNER JOIN tempo t ON 
t.temp_mes = date_format(ener_cont_mes, '%d') AND t.temp_ano = date_format(e.ener_cont_mes, '%Y') GROUP BY 
c.contr_ener_id, e.energ_id, u.unid_cli_id, e.ener_cont_mes, t.temp_id;


INSERT INTO fato_conta_agua(contr_id,agua_id,unid_cli_id,temp_id,mes_ref,total_conta_agua)
SELECT c.contr_agua_id AS contr_id, a.agua_id, u.unid_cli_id, t.temp_id, a.agua_cont_mes AS mes_ref, SUM(a.total_conta_agua) AS total_conta_agua FROM unidade_cliente u INNER JOIN contrato_agua c ON u.camp_ext_3 = c.camp_ext_3 INNER JOIN agua a ON a.cod_rgi = c.cod_liga_rgi INNER JOIN tempo t ON t.temp_mes = date_format(agua_cont_mes, '%d') AND t.temp_ano = date_format(a.agua_cont_mes, '%Y') GROUP BY c.contr_agua_id, a.agua_id, u.unid_cli_id, a.agua_cont_mes, t.temp_id;



INSERT INTO fato_conta_energia (
    unidade_cliente_id, conta_energia_a_id, conta_energia_b_id, tempo_id, contrato_energia_id, 
    local_planta_id, total_conta_energia, consumo_total_b, consumo_total_a, demanda_pt, 
    demanda_fp_cap, demanda_fp_ind, demanda_ponta, demanda_fora_ponta
)
SELECT 
    uc.unidade_cliente_id,
    cea.conta_energia_a_id,
    ceb.conta_energia_b_id,
    t.tempo_id,
    ce.contrato_energia_id,
    lp.local_planta_id,
    cea.total_conta_energia,
    ceb.uso_sist_distr,
    cea.consumo_a_pt_te + cea.consumo_a_fp_te,
    cea.demanda_pt,
    cea.demanda_fp_cap,
    cea.demanda_fp_ind,
    ce.demanda_ponta,
    ce.demanda_fora_ponta
FROM 
    conta_energia_grupo_a cea
JOIN 
    conta_energia_grupo_b ceb ON cea.numero_instalacao = ceb.numero_instalacao AND cea.energia_conta_mes = ceb.energia_conta_mes
JOIN 
    contrato_energia ce ON cea.numero_medidor = ce.numero_medidor AND cea.numero_instalacao = ce.numero_instalacao
JOIN 
    tempo t ON date_format(cea.energia_conta_mes, '%d') = t.tempo_mes AND date_format(cea.energia_conta_mes, '%Y') = t.tempo_ano
JOIN 
    local_planta lp ON cea.planta_energia = lp.planta
JOIN 
    unidade_cliente uc ON ce.cnpj = uc.cnpj;


INSERT INTO fato_conta_agua (
    contrato_agua_id, conta_agua_id, unidade_cliente_id, tempo_id, local_planta_id, 
    total_conta_agua, total_consumo_agua, total_consumo_esgoto, total_valor_agua, total_valor_esgoto
)
SELECT 
    ca.contrato_agua_id,
    cagua.conta_agua_id,
    uc.unidade_cliente_id,
    t.tempo_id,
    lp.local_planta_id,
    cagua.total_conta_agua,
    cagua.consumo_agua,
    cagua.consumo_esgoto,
    cagua.valor_agua,
    cagua.valor_esgoto
FROM 
    conta_agua cagua
JOIN 
    contrato_agua ca ON cagua.codigo_rgi = ca.codigo_rgi AND cagua.hidrometro = ca.hidrometro
JOIN 
    tempo t ON date_format(cagua.agua_conta_mes, '%d') = t.tempo_mes AND date_format(cagua.agua_conta_mes, '%Y') = t.tempo_ano
JOIN 
    local_planta lp ON cagua.planta_agua = lp.planta
JOIN 
    unidade_cliente uc ON ca.cnpj = uc.cnpj;
