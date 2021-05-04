-- 03/05
-- Criar usuário:
grant create session, create table, create any table, drop any table to Usuário;
grant select, insert, update, delete on HR.Atleta to Usuário;
create role desenvolvedor;

-- criando um grupo de privilégios
grant select, insert, update, delete on HR.Atleta to desenvolvedor;
grant desenvolvedor to Usuário-2;

-- remover permissão
revoke delete on HR.Atleta from desenvolvedor;
revoke drop any table from Usuário;

-- repassando privilégios para outros usuários
grant select, insert on HR.CLUBE to Usuário with grant option;

-- trocar senha do usuário system:
-- logar como sysdba
connect / as sysdba
alter user system identified by <senha> account unlock

--03/05: Dicionário de Dados e Transações
-- Ordem de grandeza: DBA_ > ALL_ > USER_
select * from USER_TABLES;
select * from all_tables where owner not like '%SYS%';

select * from USER_TAB_COLUMNS order by TABLE_NAME;
select * from ALL_TAB_COLUMNS where TABLE_NAME = 'ATLETA' order by TABLE_NAME;

select * from USER_CONSTRAINTS;
select * from ALL_CONSTRAINTS;
select * from USER_CONS_COLUMNS;
select * from USER_CONS_COLUMNS where TABLE_NAME = 'PRATICA';
select a.constraint_name, constraint_type, search_condition, b.column_name, b.position
    from USER_CONSTRAINTS a join USER_CONS_COLUMNS b
    on a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
    where a.TABLE_NAME = 'ATLETA';

select * from USER_VIEWS;
select view_name, text from USER_VIEWS where VIEW_NAME = 'V_ATLETA_CLUBE';

select * from USER_SEQUENCES;
select * from ALL_SEQUENCES;

select * from USER_OBJECTS where OBJECT_TYPE in ('TABLE', 'VIEW');
select * from ALL_OBJECTS where OBJECT_TYPE in ('TABLE', 'VIEW');

select * from DICTIONARY;
select * from DICTIONARY where TABLE_NAME like '%TRIG%';

-- Controle de Transações em Oracle:
grant select, insert, update, delete on HR.ATLETA to GABRIEL;
update HR.ATLETA set salario = 8000 where nome = 'Miquela Malloy';
-- enquanto não efetivar esse update, nenhum outro usuário vai enxergar

select id, nome, salario from HR.ATLETA
    where nome = 'Miquela Malloy';

insert into ATLETA (id, nome, cpf, salario)
    values (1199, 'Zé das Medalhas', '888-77-5555', 2500);

select id, nome, salario from HR.ATLETA
    where id = 1199;

-- para efetivar um update é necessário fazer um commit
commit;

update hr.ATLETA set salario = 4000 where id = 1199;
grant select on clube to GABRIEL;

update hr.ATLETA set salario = 98000 where id = 1199;
-- rollback desfaz os insert, update que não foram commitados
rollback;

-- SAVE POINT:
update ATLETA set salario = 17000 where nome = 'Oren Peers';
update ATLETA set salario = 3800 where nome = 'Johna Belf';

select id, nome, salario from HR.ATLETA
    where id = 46;

select id, nome, salario from HR.ATLETA
    where nome = 'Johna Belf';

-- savepoint utilizado para marcar onde deseja voltar. Lembrando que funciona apenas se não tiver dado commit
savepoint atualiza;

update hr.ATLETA set salario = 100000 where id = 1199;
select id, nome, salario from HR.ATLETA
    where id = 1199;

rollback to atualiza;

update ATLETA set SALARIO = 7300 where NOME = 'Lambert Taffs';
select * from ATLETA where nome in 'Lambert Taffs';
commit;

update ATLETA set SALARIO = 8000 where NOME = 'Lambert Taffs';
commit;

-- Consistência de Leitura: