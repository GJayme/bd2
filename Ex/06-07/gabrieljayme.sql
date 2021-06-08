-- Exercícios

-- 1. Faça uma função chamada fu_calcula_reajuste que receba por parâmetro o código de um atleta
-- e o percentual de reajuste do salário. A função deve aplicar o percentual de reajuste ao salário e
-- retornar o novo salário calculado do atleta. Depois, atualize o salário de algum atleta utilizando a
-- função criada.
create or replace function fu_calcula_reajuste(
    p_id in atleta.id%type,
    p_percentual in number
) return number is
    v_salario atleta.salario%type;
    v_valor_reajuste atleta.salario%type;
begin
    select salario into v_salario from atleta
        where id = p_id;

    v_valor_reajuste := v_salario * (1 + p_percentual/100);

    return v_valor_reajuste;
end fu_calcula_reajuste;

select fu_calcula_reajuste(4,10) as sal_reajustado from dual;


-- 2. Faça uma procedure chamada PR_REAJUSTA_SAL_CLUBE que receba por parâmetro o id de um clube e o percentual de
-- reajuste. Aplique e atualize na tabela o salário dos atletas do clube passado por parâmetro, aplicando o % de
-- reajuste informado. Utilize cursor para resolver o exercício e treinar sua utilização. Depois, execute a
-- procedure reajustando os salários dos atletas de algum clube.
create or replace procedure pr_reajusta_Sal_clube (
    p_clube in atleta.id_clube%type,
    p_percentual in number
) as
    cursor c_atlclube is
        select id from atleta where ID_CLUBE = p_clube;
begin
    for r_ateltaclube in c_atlclube loop
        update ATLETA set salario = salario * (1 + p_percentual/100) where ID = r_ateltaclube.ID;
    end loop;

exception
    when others then
        DBMS_OUTPUT.PUT_LINE('Erro: ' || sqlerrm);
        rollback;
end pr_reajusta_Sal_clube;

select * from ATLETA where ID_CLUBE = 10;
call pr_reajusta_Sal_clube(10, 5);
select * from ATLETA where ID_CLUBE = 10;


-- 3. Faça uma procedure chamada pr_calcula_reajuste2 que
-- transforme a função feita no exercício 1 em uma procedure.
-- Acrescente um parâmetro de saída que recebe o novo salário
-- do atleta. Crie um bloco PL/SQL para chamar a procedure.
create or replace procedure pr_calcula_reajuste2(
    p_id in atleta.id%type,
    p_percentual in number,
    p_salreaj out number
) is
    v_salario atleta.salario%type;
begin
    select salario into v_salario from atleta
        where id = p_id;

    p_salreaj := v_salario * (1 + p_percentual/100);
end pr_calcula_reajuste2;

select salario from ATLETA where id = 21;
declare
    v_novosal number;
begin
    pr_calcula_reajuste2(21,20, v_novosal);
    DBMS_OUTPUT.PUT_LINE('Novo salario ' || v_novosal);
end;


-- 4. Faça uma procedure chamada PR_VAGAS_CLUBE que receba
-- por parâmetro 3 IDs de clubes. A procedure deve retornar o
-- número de vagas para atletas paraolímpicos disponíveis em
-- cada clube, conforme a regra abaixo:
-- - Clubes de ID 1 a 10 podem ter até 3 atletas paraolímpicos;
-- - Clubes de ID 11 a 20 podem ter até 4 atletas paraolímpicos;
-- - Clubes de ID 21 a 30 podem ter até 5 atletas paraolímpicos;
-- A procedure deve permitir que o usuário a execute informando
-- um, dois ou três IDs de clubes, ou seja, o segundo e terceiro
-- parâmetros devem ser opcionais. Execute a procedure várias
-- vezes, informando 1, 2 e 3 IDs de clubes.
-- Exemplo de saída esperada:
-- Vagas paraolímpicas para o clube 11: 2
create or replace procedure pr_vagas_paraol(
    p_clube1 in atleta.id_clube%type,
    p_clube2 in atleta.id_clube%type default 0,
    p_clube3 in atleta.id_clube%type default 0
) is
    cursor c_vagas is
        select ID_CLUBE, count(*) as qtde from ATLETA a
            where ID_CLUBE in (p_clube1, p_clube2, p_clube3)
                and exists(select 1 from PARAOLIMPICO p where p.ID_ATLETA = a.ID)
            group by ID_CLUBE
            order by ID_CLUBE;
begin
    for r_vagas in c_vagas loop
        if r_vagas.ID_CLUBE between 1 and 10 then
            DBMS_OUTPUT.PUT_LINE('Vagas paraolimpicas para o clube ' || r_vagas.ID_CLUBE || ': ' || to_char(3 - r_vagas.qtde));
        elsif r_vagas.ID_CLUBE between 11 and 20 then
            DBMS_OUTPUT.PUT_LINE('Vagas paraolimpicas para o clube ' || r_vagas.ID_CLUBE || ': ' || to_char(4 - r_vagas.qtde));
        elsif r_vagas.ID_CLUBE between 21 and 30 then
            DBMS_OUTPUT.PUT_LINE('Vagas paraolimpicas para o clube ' || r_vagas.ID_CLUBE || ': ' || to_char(5 - r_vagas.qtde));
        end if;
    end loop;
end pr_vagas_paraol;

call pr_vagas_paraol(26, 4, 11);


-- 5. Modifique o exercício 4, criando agora uma função
-- auxiliar chamada FU_VAGAS_PARAOL, que recebe por
-- parâmetro o ID de um clube e a quantidade de atletas
-- paraolímpicos desse clube, retornando o número de vagas
-- paraolímpicas disponíveis para o clube, seguindo a mesma
-- regra do exercício anterior.
-- Modifique a procedure criada anteriormente, fazendo
-- agora uso da função FU_VAGAS_PARAOL dentro da
-- procedure para auxiliar no cálculo das vagas disponíveis.
-- Caso não queira substituir a procedure anterior, pode
-- modificá-la e salvá-la como PR_VAGAS_CLUBE2.
-- Execute a procedure algumas vezes, informando IDs de
-- clubes distintos, certificando-se que funciona.

-- 6. Faça uma procedure chamada PR_DEPTO_LOCAL que recebe
-- por parâmetro o ID de um clube e retorna o seu nome e o(s)
-- seu(s) telefone(s) dos centro(s) de treinamento.
-- Um exemplo de execução ao informar o clube 17 seria:
-- Clube: Alpha Team
-- Telefone 1: (212) 5469699
-- Telefone 2: (314) 7800399
-- Note que o nome do clube deve aparecer somente uma
-- vez, ainda que ele possua várias telefones nos centros
-- de treinamentos. Os telefones devem vir numerados
-- sequencialmente, conforme o exemplo.

create or replace procedure pr_clube_fone_ct(
    p_id in clube.id%type
) is
    v_nome clube.nome%type;
    v_fone centro_treinamento.fone%type;
    i number := 1;
    cursor c_fone is
        select c.nome, ct.fone from CLUBE c, CENTRO_TREINAMENTO ct
        where ct.ID_CLUBE = c.id and c.id = p_id
        order by 1;
begin
    open c_fone;
    loop
        fetch c_fone into v_nome, v_fone;
        exit when c_fone%notfound;
        if i = 1 then
            DBMS_OUTPUT.PUT_LINE('Clube: ' || v_nome);
        end if;
        DBMS_OUTPUT.PUT_LINE(' Telefone ' || i || ': ' || v_fone);
        i := i + 1;
    end loop;
    close c_fone;
end pr_clube_fone_ct;

call pr_clube_fone_ct(21);


-- 7. Faça uma procedure chamada PR_ATLETA_EXP que recebe por
-- parâmetro a descrição de uma modalidade esportiva e um tempo de
-- experiência. Então, liste os nomes dos atletas que praticam essa
-- modalidade e que têm experiência maior ou igual à informada e os que a
-- praticam e têm experiência menor que a informada.
-- Um exemplo de execução ao informar a modalidade Swimming e 20 anos de
-- experiência seria:
-- Possuem mais ou igual a 20 anos de experiência:
-- Ringo Vidgeon - 30,6 anos
-- Shurwood Soan - 27,5 anos
-- Leandra Piner - 27,4 anos
-- Possuem menos que 20 anos de experiência:
-- Lancelot Apdell - 19,2 anos
-- Averill Drogan - 13,7 anos
-- Note que o cabeçalho deve aparecer somente uma vez para quem possui
-- mais ou igual a 20 anos de experiência e uma vez apenas para quem
-- possui até 20 anos de experiência na modalidade.

-- 8. Faça uma procedure chamada PR_PREMIO_CAMP que receba 1 parâmetro de
-- entrada (número do campeonato) e 2 parâmetros de saída (nome do campeonato
-- e total em premiação do campeonato).
-- Depois, monte um bloco PL/SQL que chame a procedure criada e imprima na tela
-- o ID do campeonato, seu nome e o total em premiação dada no campeonato.
create or replace procedure pr_premio_camp(
    p_camp in char,
    p_nome out campeonato.nome%type,
    p_premiacao out number
) is
begin
    select c.nome, sum(p.valor_premiacao) into p_nome, p_premiacao
        from PARTICIPA p join CAMPEONATO c on p.ID_CAMPEONATO = c.ID and c.id = p_camp
    group by c.nome;
end pr_premio_camp;

declare
    v_idcamp campeonato.id%type;
    v_nomecamp campeonato.nome%type;
    v_premiacao number;
begin
    pr_premio_camp(4, v_nomecamp, v_premiacao);
    DBMS_OUTPUT.PUT_LINE(' ID do Campeonato: ' || 4 || ', Nome: ' || v_nomecamp || ', Total em premiação: ' || v_premiacao );
end;


-- 9. Faça uma procedure chamada PR_ATUALIZA_CLUBE que receba os parâmetros
-- de entrada:
-- - Modo de alteração: deve ser A para Atualizar e R para Remover
-- - ID do clube: obrigatório
-- - Nome do clube: opcional (pode ser usado no modo A)
-- - Data de fundação: opcional (pode ser usado no modo A)
-- - Id do presidente: opcional (pode ser usado no modo A)
-- Caso seja passado A no primeiro parâmetro, a procedure deve verificar se o clube
-- existe (por meio do ID). Caso sim, atualize suas informações, caso não, insira o
-- novo clube.
-- Se o parâmetro for R, o clube deve ser removido da tabela
create or replace procedure pr_autualiza_clube(
    p_modo in char,
    p_clube in clube.id%type,
    p_nome in clube.nome%type default null,
    p_fundacao in clube.data_fundacao%type default null,
    p_presidente clube.id_presidente%type default null
) is
    v_clube clube%rowtype;
begin
    if upper(p_modo) = 'A' then
        begin
            select * into v_clube from clube where id = p_clube;
            update clube
                set nome = nvl(p_nome, v_clube.nome),
                    DATA_FUNDACAO = nvl(p_fundacao, v_clube.DATA_FUNDACAO),
                    ID_PRESIDENTE = nvl(p_presidente, v_clube.ID_PRESIDENTE)
            where id = p_clube;
            commit;
            DBMS_OUTPUT.PUT_LINE('Clube atualizado com sucesso!');
        exception
            when no_data_found then
                insert into CLUBE(id, nome, DATA_FUNDACAO, ID_PRESIDENTE)
                values (p_clube, p_nome, p_fundacao, p_presidente);
                commit;
                DBMS_OUTPUT.PUT_LINE('Clube inserido com sucesso!');
        end;
    elsif upper(p_modo) = 'R' then
        delete from CLUBE where id = p_clube;
        commit;
        DBMS_OUTPUT.PUT_LINE('Clube removido com sucesso!');
    else
        DBMS_OUTPUT.PUT_LINE('Modo inválido! Informe A para Atualização ou R para Remoção.');
    end if;
exception
    when others then
        DBMS_OUTPUT.PUT_LINE('Erro: ' || sqlerrm);
end pr_autualiza_clube;

call pr_autualiza_clube('A', 45, 'Teste Clube', sysdate, 10);
call pr_autualiza_clube('A', 45, p_presidente => 8);

select * from clube where id = 45;


-- 10. Faça uma função que receba o ID de um atleta por parâmetro e
-- retorne o valor do imposto devido pelo atleta.
-- O valor do imposto é calculado com base no salário anual do atleta,
-- seguindo as regras:
-- - Se o salário anual for maior/igual a 500.000, o imposto é de 30%.
-- - Se o salário anual for maior/igual a 250.000, o imposto é de 20%.
-- - Se o salário anual for maior/igual a 100.000, o imposto é de 10%.
-- - Se o salário anual for menor do que 100.000, o imposto é de 5%.
-- Depois, faça uma consulta SQL que retorne o ID, nome, salário,
-- salário anual e o valor do imposto devido pelos atletas.