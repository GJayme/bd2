-- PL/SQL:
declare
    altura number;
    base number;
    area number;
    v_salario atleta.salario%type; --pega o tipo direto da tabela
    v_nome atleta.nome%type;
begin
    altura := 3;
    base := 2;
    area := (base * altura)/2;
    DBMS_OUTPUT.PUT_LINE('Area do triângulo: ' || area);
end;

-- If, else, elsif
declare
    v_saldo number := 100;
    v_limite number := 1000;
begin
    if v_saldo > 0 then
        DBMS_OUTPUT.PUT_LINE('Saldo positivo');
        if v_limite > 0 then
            DBMS_OUTPUT.PUT_LINE('Limite ok!');
        end if;
    elsif v_saldo = 0 then
        DBMS_OUTPUT.PUT_LINE('Saldo é zero');
    else
        DBMS_OUTPUT.PUT_LINE('Saldo negativo');
    end if;
end;

-- Case
declare
    v_estado_civil char(1) := 'C';
    v_estecivil varchar2(20);
begin
    case v_estado_civil
        when 'C' then v_estecivil := 'Casado';
        when 'S' then v_estecivil := 'Solteiro';
        when 'D' then v_estecivil := 'Divorciado';
        else v_estecivil := 'Não informado';
    end case;
    DBMS_OUTPUT.PUT_LINE(v_estecivil);
end;

-- Repetição com Loop:
declare
    v_contador number := 0;
begin
    loop
        v_contador := v_contador + 1;
        /*if v_contador = 3 then
            continue;
        end if; */
        continue when v_contador = 3;
        DBMS_OUTPUT.PUT_LINE(v_contador);
        exit when v_contador = 5;
    end loop;
end;

-- Repetição com While:
declare
    v_contador number := 0;
begin
    while v_contador < 5 loop
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(v_contador);
    end loop;
end;

-- Repetição com For:
begin
    for v_contador in 1..5 loop
        DBMS_OUTPUT.PUT_LINE(v_contador);
    end loop;
end;

    -- For Invertido
begin
    for v_contador in reverse 1..5 loop
        DBMS_OUTPUT.PUT_LINE(v_contador);
    end loop;
end;

-- Recuperar nome e data de fundação de um clube:
declare
    v_nome clube.nome%type;
    v_data_fund clube.data_fundacao%type;
    v_id clube.id%type;
begin
    select nome, DATA_FUNDACAO into v_nome, v_data_fund
        from CLUBE
            where id = &&v_id;
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome || ', Fundação: ' || to_char(v_data_fund, 'dd/mm/yyyy'));
end;

-- Exercícios
-- 1.
declare
    v_numero number := 5;
begin
    for i in 1..10 loop
        DBMS_OUTPUT.PUT_LINE(v_numero || ' x ' || i || ' = ' || v_numero*i);
    end loop;
end;

-- 2.
begin
    for j in 1..10 loop
        for i in 1..10 loop
            DBMS_OUTPUT.PUT_LINE(j || ' x ' || i || ' = ' || j*i);
        end loop;
        DBMS_OUTPUT.PUT_LINE(' ');
    end loop;
end;

-- 3. Faça um bloco PL/SQL que tenha 3 variaveis declaradas (lado1, lado2 e lado3), atribuindo
-- valores a elas na delcaração. Depois, imprima na tela os lados e se o triângulo é equilatero,
-- isósceles ou escaleno
declare
    lado1 number := 5;
    lado2 number := 3;
    lado3 number := 1;
begin
    if lado1 = lado2 and lado1 = lado3 then
        DBMS_OUTPUT.PUT_LINE('Equilatero');
    elsif lado1 != lado2 and lado1 != lado3 and lado2 != lado3 then
        DBMS_OUTPUT.PUT_LINE('Escaleno');
    else
        DBMS_OUTPUT.PUT_LINE('Isosceles');
    end if;
end;

-- 4. Faça um bloco PL/SQL que selecione o nome, data de nascimento e sexo de um atleta específico. Depois,
-- calcule a idade desse atleta e imprima na tela suas informações, além de uma mensagem dizendo se é um
-- atleta masculino ou uma atleta feminina, maior ou menor de idade.
declare
    v_nome atleta.nome%type;
    v_datanasc atleta.datanasc%type;
    v_sexo atleta.sexo%type;
    v_idade number;
begin
    select nome, datanasc, sexo into v_nome, v_datanasc, v_sexo
        from atleta
            where id = 1;
    v_idade := trunc((sysdate - v_datanasc) / 365);

    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome || ', Data Nasc: ' || v_datanasc
        || ', Idade: ' || v_idade || 'e Sexo: ' || v_sexo);

    if v_idade < 18 and
end;