-- select and insert for fato_conta_energia
INSERT INTO fato_conta_energia (
    unidade_cliente_id,
    conta_energia_a_id,
    conta_energia_b_id,
    tempo_id,
    contrato_energia_id,
    local_planta_id,
    total_conta_energia,
    consumo_total_b,
    consumo_total_a,
    demanda_pt,
    demanda_fp_cap,
    demanda_fp_ind,
    demanda_ponta,
    demanda_fora_ponta
)
SELECT 
    u.unidade_cliente_id,
    conta_a.conta_energia_a_id,
    conta_b.conta_energia_b_id,
    t.tempo_id,
    c.contrato_energia_id,
    l.local_planta_id,
    COALESCE(conta_a.total_conta_energia, conta_b.total_conta_energia) AS total_conta_energia,
    conta_b.uso_sist_distr AS consumo_total_b,
    (conta_a.consumo_pt_vd + conta_a.consumo_fp_cap_vd + conta_a.consumo_fp_ind_vd + conta_a.consumo_a_pt_tusd + conta_a.consumo_a_pt_te + conta_a.consumo_a_fp_tusd + conta_a.consumo_a_fp_te) AS consumo_total_a,
    conta_a.demanda_pt,
    conta_a.demanda_fp_cap,
    conta_a.demanda_fp_ind,
    c.demanda_ponta,
    c.demanda_fora_ponta
FROM 
    unidade_cliente u
LEFT JOIN 
    contrato_energia c ON u.cnpj = c.cnpj
LEFT JOIN 
    conta_energia_grupo_a conta_a ON conta_a.numero_instalacao = c.numero_instalacao
LEFT JOIN 
    conta_energia_grupo_b conta_b ON conta_b.numero_instalacao = c.numero_instalacao
INNER JOIN 
    local_planta l ON l.planta = COALESCE(conta_a.planta_energia, conta_b.planta_energia)
INNER JOIN 
    tempo t ON t.tempo_mes = DATE_FORMAT(COALESCE(conta_a.energia_conta_mes, conta_b.energia_conta_mes), '%m') 
             AND t.tempo_ano = DATE_FORMAT(COALESCE(conta_a.energia_conta_mes, conta_b.energia_conta_mes), '%Y')
WHERE 
    conta_a.conta_energia_a_id IS NOT NULL 
    OR conta_b.conta_energia_b_id IS NOT NULL;



-- select and insert for fato_conta_agua
 INSERT INTO fato_conta_agua (
    contrato_agua_id,
    conta_agua_id,
    unidade_cliente_id,
    tempo_id,
    local_planta_id,
    total_conta_agua,
    total_consumo_agua,
    total_consumo_esgoto,
    total_valor_agua,
    total_valor_esgoto
)
SELECT 
    c.contrato_agua_id, 
    conta.conta_agua_id, 
    u.unidade_cliente_id, 
    t.tempo_id, 
    l.local_planta_id,
    SUM(conta.total_conta_agua) AS total_conta_agua, 
    SUM(conta.consumo_agua) AS total_consumo_agua,
    SUM(conta.consumo_esgoto) AS total_consumo_esgoto, 
    SUM(conta.valor_agua) AS total_valor_agua, 
    SUM(conta.valor_esgoto) AS total_valor_esgoto
FROM 
    conta_agua conta
INNER JOIN 
    contrato_agua c ON conta.codigo_rgi = c.codigo_rgi
INNER JOIN 
    unidade_cliente u ON c.cnpj = u.cnpj
INNER JOIN 
    local_planta l ON l.planta = conta.planta_agua
INNER JOIN 
    tempo t ON t.tempo_mes = DATE_FORMAT(conta.agua_conta_mes, '%m') 
              AND t.tempo_ano = DATE_FORMAT(conta.agua_conta_mes, '%Y')
GROUP BY 
    c.contrato_agua_id, 
    conta.conta_agua_id, 
    u.unidade_cliente_id, 
    t.tempo_id, 
    l.local_planta_id;