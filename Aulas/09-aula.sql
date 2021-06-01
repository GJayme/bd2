-- 31/05
declare
    v_nome atleta.nome%type;
begin
    select nome into v_nome from ATLETA where ID_CLUBE = 1;
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome);
Exception
    when no_data_found then
        DBMS_OUTPUT.PUT_LINE('Atleta não encontrado!');
    when too_many_rows then
        DBMS_OUTPUT.PUT_LINE('Mais de um atleta encontrado!');
end;

-- CURSOR: usado para tratar mais de um retorno
-- Jeito 01:
declare
    v_nome atleta.nome%type;
    cursor c_atleta is
        select nome into v_nome from ATLETA where ID_CLUBE = 1;
begin
    open c_atleta;
    loop
        fetch c_atleta into v_nome;
        exit when c_atleta%notfound;
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome);
    end loop;
    close c_atleta;
Exception
    when no_data_found then
        DBMS_OUTPUT.PUT_LINE('Atleta não encontrado!');
    when too_many_rows then
        DBMS_OUTPUT.PUT_LINE('Mais de um atleta encontrado!');
    when others then
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ' || sqlerrm);
end;

-- Jeito 02: utilizando FOR
declare
    cursor c_atleta is
        select nome from ATLETA where ID_CLUBE = 1;
begin
    for v_atleta in c_atleta loop
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_atleta.NOME);
    end loop;
Exception
    when no_data_found then
        DBMS_OUTPUT.PUT_LINE('Atleta não encontrado!');
    when too_many_rows then
        DBMS_OUTPUT.PUT_LINE('Mais de um atleta encontrado!');
    when others then
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ' || sqlerrm);
end;

-- PROCEDURE:
grant create procedure to joao; -- quando eu dou permissao de procedure o usuario pode criar e executar funçoes e procedures

-- Parâmentros:
-- IN é opcional
-- OUT
-- IN OUT

-- Criar ou substituir uma procedure
create or replace procedure pr_altera_atleta_end_clube(
    p_id in atleta.id%type,
    p_end in atleta.endereco%type,
    p_clube in atleta.id_clube%type)
    is
    v_aux number;
begin
    --Verificar se existe o atleta
    select count(*) into v_aux from atleta where id = p_id;

    if v_aux > 0 then
        update atleta set ENDERECO = p_end, ID_CLUBE = p_clube
            where id = p_id;
        DBMS_OUTPUT.PUT_LINE('Atleta atualizado com sucesso');
        commit;
    end if;
exception
    when others then
        DBMS_OUTPUT.PUT_LINE('Erro ' || sqlerrm);
end pr_altera_atleta_end_clube;

-- Executar procedure
call pr_altera_atleta_end_clube(80, 'Teste Procedure', 7);

-- Executar a procedure com Notação Nomeada
call pr_altera_atleta_end_clube(p_end => 'Rua do IFSP, 27', p_clube => 11, p_id => 20);
select * from atleta where id = 20;

-- Executar a procedure com Notação Mista
call pr_altera_atleta_end_clube(20, p_clube => 8, p_end => 'Rua Novo IFSP, 43');
select * from atleta where id = 20;

-- Apagar procedure;
drop procedure pr_altera_atleta_end_clube;

create or replace procedure pr_sal_clube(
    p_clube in atleta.id_clube%type,
    p_media_sal out number
) is
begin
    -- Retorna a média salarial dos atletas do clube informado
    select avg(salario) into p_media_sal from atleta where ID_CLUBE = p_clube;
exception
    when others then
        DBMS_OUTPUT.PUT_LINE('Erro ' || sqlerrm);
end pr_sal_clube;

-- para executar uma procedure com valor de saida é necessário montar um bloco de execução
declare
    v_media number;
begin
    pr_sal_clube(1, v_media);
    DBMS_OUTPUT.PUT_LINE('Média salarial do clube ' || v_media);
end;

create or replace procedure pr_troca_val(
    p_valor1 in out number,
    p_valor2 in out number
) is
    v_aux number;
begin
    v_aux := p_valor1;
    p_valor1 := p_valor2;
    p_valor2 := v_aux;
end pr_troca_val;

declare
    v_val1 number := 5;
    v_val2 number := 7;
begin
    DBMS_OUTPUT.PUT_LINE('Valores ANTES: ' || v_val1 || ' , ' || v_val2);
    pr_troca_val(v_val1, v_val2);
    DBMS_OUTPUT.PUT_LINE('Valores DEPOIS: ' || v_val1 || ' , ' || v_val2);
end;

create or replace procedure pr_altera_dados(
    p_id in atleta.id%type,
    p_nome in atleta.nome%type,
    p_sal atleta.salario%type default 1000,
    p_cpf atleta.cpf%type,
    p_datanasc atleta.datanasc%type
) AS
    v_id number;
begin
    select id into v_id from ATLETA where ID = p_id;

    update ATLETA set nome = p_nome, salario = p_sal, DATANASC = p_datanasc, cpf = p_cpf
        where id = p_id;
    commit;
    DBMS_OUTPUT.PUT_LINE('Salario atualizado com sucesso!');
exception
    when no_data_found then
        DBMS_OUTPUT.PUT_LINE('Atleta não encontrado!');
    when others then
        DBMS_OUTPUT.PUT_LINE('Erro ' || sqlerrm);
end;

call pr_altera_dados(90, 'Miguel', 5000, '999888777', to_date('15/05/2001', 'dd/mm/yyyy'));
select * from ATLETA where id = 90;

call pr_altera_dados(p_id => 90, p_nome => 'Miguel', p_cpf => '999888777', p_datanasc => to_date('15/05/2001', 'dd/mm/yyyy'));
select * from ATLETA where id = 90;