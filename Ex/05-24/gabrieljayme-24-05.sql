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

-- 2. Adapte o exercício 1, só que agora verifique se os atletas ganham acima ou não da média salarial do clube
-- que pertencem.
declare
    v_media atleta.salario%type;
    cursor c_clube is
        select * from clube;
    cursor c_atleta is
        select * from ATLETA;
begin
    for aux_clube in c_clube loop
        SELECT AVG(salario) into v_media from ATLETA where ID_CLUBE = aux_clube.id;
        DBMS_OUTPUT.PUT_LINE('Clube: ' || aux_clube.ID || ' Média salárial: ' || v_media);
        for aux_atleta in c_atleta loop
            if aux_atleta.ID_CLUBE = aux_clube.id then
                if aux_atleta.SALARIO > v_media then
                    DBMS_OUTPUT.PUT_LINE('Nome: ' || aux_atleta.NOME || ', CPF: ' || aux_atleta.CPF || ', Salário: ' || aux_atleta.SALARIO || ', Ganha Acima da média!');
                elsif aux_atleta.SALARIO < v_media then
                    DBMS_OUTPUT.PUT_LINE('Nome: ' || aux_atleta.NOME || ', CPF: ' || aux_atleta.CPF || ', Salário: ' || aux_atleta.SALARIO || ', Ganha Abaixo da média!');
                else
                    DBMS_OUTPUT.PUT_LINE('Nome: ' || aux_atleta.NOME || ', CPF: ' || aux_atleta.CPF || ', Salário: ' || aux_atleta.SALARIO || ', Salário igual a média!');
                end if;
            end if;
        end loop;
        DBMS_OUTPUT.PUT_LINE(' ');
    end loop;
end;

-- 3. Escreva um programa que inverta os salários dos atletas Ringo Vidgeon e Merwyn Sivills. No final, exiba uma mensagem
-- informando que a troca foi feita.
declare
    v_sal_a1 atleta.salario%type;
    v_sal_a2 atleta.salario%type;
begin
    SELECT salario into v_sal_a1 from ATLETA where nome = 'Ringo Vidgeon';
    SELECT salario into v_sal_a2 from ATLETA where nome = 'Merwyn Sivills';
    DBMS_OUTPUT.PUT_LINE('Ringo: ' || v_sal_a1);
    DBMS_OUTPUT.PUT_LINE('Merwyn: ' || v_sal_a2);

    update atleta set salario = v_sal_a2 where nome = 'Ringo Vidgeon';
    update atleta set salario = v_sal_a1 where nome = 'Merwyn Sivills';
    DBMS_OUTPUT.PUT_LINE('Troca realizada com sucesso!');

    SELECT salario into v_sal_a1 from ATLETA where nome = 'Ringo Vidgeon';
    SELECT salario into v_sal_a2 from ATLETA where nome = 'Merwyn Sivills';
    DBMS_OUTPUT.PUT_LINE('Ringo: ' || v_sal_a1);
    DBMS_OUTPUT.PUT_LINE('Merwyn: ' || v_sal_a2);
end;

-- 4. Escreva um programa que atualize o salário e endereço do atlta de ID 15 com os dados do atleta cujo nome comece com Grace.
-- Se não houver nenhuma Grace, o salário deve ser o salário médio dos atletas, e o endereço deve ser nulo.
declare
    v_sal   atleta.salario%type;
    v_end   atleta.ENDERECO%type;
    v_media number;
    cursor c_atleta_grace is select SALARIO, ENDERECO
                             from HR.ATLETA
                             where NOME like '%Grace%';
begin
    open c_atleta_grace;
    fetch c_atleta_grace into v_sal, v_end;
    if c_atleta_grace%notfound then
        select avg(SALARIO) into v_media from HR.ATLETA;
        update HR.ATLETA set SALARIO = v_media, ENDERECO = v_end where id = 15;
    end if;
    close c_atleta_grace;
end;

-- 5.
declare
    v_aux number := -1;
    cursor c_clube is
        select c.id, c.nome, ct.*
            from clube c join CENTRO_TREINAMENTO ct on c.id = ct.ID_CLUBE order by c.id;
begin
    for r_clube in c_clube loop
        if v_aux <> r_clube.ID_CLUBE then
            DBMS_OUTPUT.PUT_LINE('CTs do clube: ' || r_clube.ID || ' - ' || r_clube.NOME);
        end if;
        DBMS_OUTPUT.PUT_LINE(' Cidade: ' || r_clube.CIDADE || ', UF: ' || r_clube.UF);
        v_aux := r_clube.ID;
    end loop;
end;