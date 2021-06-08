-- 1. 1. Crie uma função chamada
-- FU_GET_PREMIACAO_ATLETA_PERIODO que receba por
-- parâmetros o nome de um atleta, uma data inicial e uma
-- data final, retornando o valor total (arredondado para 2
-- casas decimais) de premiação ganho por ele nos
-- campeonatos disputados no período indicado. A data
-- final poderá ser omitida na execução da função e, nesse
-- caso, o valor padrão deve ser sysdate. Depois de criada a
-- função, faça uma consulta para utilizá-la para um atleta já
-- exista na tabela e um período qualquer que desejar
-- informando data inicial e data final, e uma outra consulta
-- para utilizá-la informando apenas o nome do atleta e uma
-- data inicial, omitindo a data final.

create or replace function fu_get_premiacao_atleta_periodo(
    p_nome_atleta atleta.nome%type,
    p_data_inicial date,
    p_data_final date default sysdate
) return number as
    v_id_atleta atleta.id%type;
    v_total_horas number;
begin
    select id into v_id_atleta from ATLETA where nome = p_nome_atleta;

    select sum(p.valor_premiacao) into v_total_horas from PARTICIPA p
        join CAMPEONATO c on p.ID_CAMPEONATO = c.ID
        join ESPORTE e on e.REGISTRO_ATLETA = p.REGISTRO_ATLETA
    where e.ID_ATLETA = v_id_atleta
      and NVL(c.DATA_INICIO,sysdate) >= p_data_inicial
      and NVL(c.DATA_FIM,to_date('01/01/1900', 'dd/mm/yyyy')) <= p_data_final;

    return round(v_total_horas, 2);
end fu_get_premiacao_atleta_periodo;
select fu_get_premiacao_atleta_periodo('Leandra Piner', to_date('01/01/1990', 'dd/mm/yyyy'), to_date('31/12/2020', 'dd/mm/yyyy')) from dual;
select fu_get_premiacao_atleta_periodo('Leandra Piner', to_date('01/01/1990', 'dd/mm/yyyy')) from dual;