-- Exercicios:
-- 1. Crie uma tabela chamada EMP_TEMP no esquema HR com os campos:
-- COD number(2) PK, NOME varchar2(20), SAL number(6,2)
create table EMP_TEMP (
    COD         number(2),
    NOME        varchar2(20),
    SAL         number(6,2),
    primary key (COD)
);

-- 2. Conceda privilégio de consulta, inserção, atualização e deleção na
-- tabela HR.EMP_TEMP ao Gabriel.
grant select, insert, update, delete on HR.EMP_TEMP to GABRIEL;

-- 4. Como HR, insira 2 registros na tabela EMP_TEMP.
insert into EMP_TEMP (COD, NOME, SAL)
    values (1, 'Loquinho', 2500);

insert into EMP_TEMP (COD, NOME, SAL)
    values (2, 'Zé Lele', 4000);

-- 6. Como HR, efetive permanentemente as inserções realizadas e depois,
-- como José, consulte novamente os registros EMP_TEMP.
commit;

-- 7. Como HR, insira outros 2 registros na tabela EMP_TEMP.
insert into EMP_TEMP (COD, NOME, SAL)
    values (3, 'Maluquinho', 1000);

insert into EMP_TEMP (COD, NOME, SAL)
    values (4, 'Caverinha', 100);

-- 9. Como HR, crie a tabela DEP_TEMP em seu esquema, com os campos:
-- NUM number(2), PK, NOME varchar2(20).
create table DEP_TEMP (
    NUM         number(2),
    NOME        varchar2(20),
    primary key (NUM)
);

-- 11. Como HR, faça um UPDATE em algum dos empregados dobrando o seu salário.
-- Depois, como Gabriel, faça um SELECT consultando as informações do empregado alterado.
-- Qual salário Gabriel enxerga? Por que?
update EMP_TEMP set SAL =  SAL*2 where NOME = 'Caverinha';
update EMP_TEMP set SAL =  SAL*2 where NOME = 'Maluquinho';

-- 12. Como HR, desfaça a alteração que dobrava o salário do empregado e consulte os dados do empregado.
-- Então, como Gabriel, consulte também os dados desse empregado.
rollback;
select * from EMP_TEMP where NOME = 'Caverinha';
select * from EMP_TEMP where NOME = 'Maluquinho';

-- 13. Como Gabriel, marque um SAVEPOINT chamado SP1. Apague 1 registro da tabela HR.EMP_TEMP.
-- Marque agora um novo SAVEPOINT chamado SP2. Apague outro registro qualquer da tabela EMP_TEMP.
-- Consulte a tabela EMP_TEMP como Gabriel e como HR. Quantos registros aparecem para cada um?
select * from HR.EMP_TEMP;
    -- No HR aparecem 4 registros.

-- 16. Como Gabriel, desfaça agora somente o ultimo DELETE realizado. Consulte a tabela EMP_TEMP como HR
-- e como GABRIEL e veja quantos registros aparecem para cada um.
select * from EMP_TEMP;
        -- No HR aparecem 4 registros.

-- 17. Como Gabriel, efetive todas as alterações pendentes. Consulte a tabela EMP_TEMP como HR e como Gabriel
-- e veja quantos registros aparecem para cada um agora.
select * from EMP_TEMP;
    -- Em ambas sessões aparecem 3 registros.

-- 18. Como HR, faça um UPDATE no salário de algum dos registros da EMP_TEMP. Como Gabriel, faça um UPDATE no MESMO registro,
-- modificando o salario para outro valor. O que acontecue em cada uma das sessões? Por que?

update EMP_TEMP set SAL =  SAL*2 where NOME = 'Maluquinho';
commit;