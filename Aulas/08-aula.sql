-- 24/05
-- revendo pl/sql
-- lembrar de dar enable dbmsoutput
declare
    v_test number := 1;
    v_nome atleta.nome%type;
begin
    while v_test < 10 loop
        v_test := v_test + 1;
        DBMS_OUTPUT.PUT_LINE('O valor é: ' || v_test);
    end loop;

    for i in 1..7 loop
        DBMS_OUTPUT.PUT_LINE('O valor é: ' || i);
    end loop;
end;

-- bloco dentro de bloco
declare
    v_aux number:= 12;
begin
    v_aux := v_aux + 10;
    declare
        v_aux2 number;
    begin
        v_aux2 := v_aux + 1;
        DBMS_OUTPUT.PUT_LINE(v_aux2);
    end;
    DBMS_OUTPUT.PUT_LINE('lalala: ' || v_aux);
end;

-- CURSOR:
-- uso de CURSOR:
-- Modo 1:
declare
    v_id atleta.id%type;
    v_nome atleta.nome%type;
    v_salario atleta.salario%type;
    cursor c_atleta is
        select id, nome, salario into v_id, v_nome, v_salario from ATLETA;
begin
    -- abre o cursor
    open c_atleta;
    -- abre um loop para pegar linha a linha
    loop
        -- faz um fetch
        fetch c_atleta into v_id, v_nome, v_salario;
        -- parada quando não encontrar atleta
        exit when c_atleta%notfound;
        DBMS_OUTPUT.PUT_LINE(v_id || ', ' || v_nome || ', ' || v_salario);
    end loop;
    close c_atleta;
end;

-- Modo 2:
declare
    -- linha de toda tabela
    v_atleta atleta%rowtype;
    cursor c_atleta is
        select * from ATLETA;
begin
    -- abre o cursor
    open c_atleta;
    -- abre um loop para pegar linha a linha
    loop
        -- faz um fetch
        fetch c_atleta into v_atleta;
        -- parada quando não encontrar atleta
        exit when c_atleta%notfound;
        DBMS_OUTPUT.PUT_LINE(v_atleta.ID || ', ' || v_atleta.NOME || ', ' || v_atleta.SALARIO);
    end loop;
    close c_atleta;
end;

-- Modo 3:
-- Cursor com for e declare:
declare
    cursor c_atl5 is
        select id, nome from ATLETA where ID_CLUBE = 11;
begin
    for v_aux in c_atl5 loop
        DBMS_OUTPUT.PUT_LINE(v_aux.ID || ', ' || v_aux.NOME);
    end loop;
end;

-- Modo 4:
-- Cursor com for sem declare:
begin
    for v_aux in (select id, nome from ATLETA where ID_CLUBE = 11) loop
        DBMS_OUTPUT.PUT_LINE(v_aux.ID || ', ' || v_aux.NOME);
    end loop;
end;

-- Exception
-- WHEN DUP_VAL_ON_INDEX
-- WHEN case_not_found
-- WHEN zero_divide then
-- WHEN invalid_number then

-- NO DATA FOUND EXCEPTION:
declare
    v_atleta atleta%rowtype;
begin
    select * into v_atleta from ATLETA where id=4333;
    DBMS_OUTPUT.PUT_LINE(v_atleta.ID || ', ' || v_atleta.NOME);
EXCEPTION
    when NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('Atleta não encontrado!');
    when TOO_MANY_ROWS then
        DBMS_OUTPUT.PUT_LINE('Consulta retornou mais que um atleta e era esperado somente um!');
end;

-- TOO MANY ROWS EXCEPTION:
declare
    v_atleta atleta%rowtype;
begin
    select * into v_atleta from ATLETA where id_clube=1;
    DBMS_OUTPUT.PUT_LINE(v_atleta.ID || ', ' || v_atleta.NOME);
EXCEPTION
    when NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('Atleta não encontrado!');
    when TOO_MANY_ROWS then
        DBMS_OUTPUT.PUT_LINE('Consulta retornou mais que um atleta e era esperado somente um!');
end;

-- WHEN OTHERS:
declare
    v_atleta atleta%rowtype;
begin
    select * into v_atleta from ATLETA where id_clube=1;
    DBMS_OUTPUT.PUT_LINE(v_atleta.ID || ', ' || v_atleta.NOME);
EXCEPTION
    when others then
        DBMS_OUTPUT.PUT_LINE('Erro ' || sqlerrm);
end;

-- Exercício:
-- 1. Faça um bloco PL/SQL que liste a média salarial dos atletas e, para cada atleta, liste o seu id,
-- nome, cpf e salário, e se ganha acima ou não da média salarial dos atletlas.
declare
    v_media_salarial atleta.salario%type := 0;
    cursor c_atleta is
        select * from ATLETA;
begin
    SELECT AVG(salario) into v_media_salarial from ATLETA;
    DBMS_OUTPUT.PUT_LINE('Média salarial dos atletas: ' || v_media_salarial);

    for v_aux2 in c_atleta loop
        if v_aux2.SALARIO > v_media_salarial then
            DBMS_OUTPUT.PUT_LINE('Nome: ' || v_aux2.NOME || ', CPF: ' || v_aux2.CPF || ', Salário: ' || v_aux2.SALARIO || ', Ganha Acima da média!');
        elsif v_aux2.SALARIO < v_media_salarial then
            DBMS_OUTPUT.PUT_LINE('Nome: ' || v_aux2.NOME || ', CPF: ' || v_aux2.CPF || ', Salário: ' || v_aux2.SALARIO || ', Ganha Abaixo da média!');
        else
            DBMS_OUTPUT.PUT_LINE('Nome: ' || v_aux2.NOME || ', CPF: ' || v_aux2.CPF || ', Salário: ' || v_aux2.SALARIO || ', Salário igual a média!');
        end if;
    end loop;
end;

