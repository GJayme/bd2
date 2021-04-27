-- 26/04

-- VIEWS
-- Create or REplace ele substitui ou cria a view
create or replace view v_atleta_clube10(nome_atleta, salario_anual) as
SELECT nome, sum(salario) from atleta
 where id_clube = 10
 group by nome;
 
desc v_atleta_clube10;

-- read only so deixa fazer select
-- with check option vai verificar todas as condições do meu where
create or replace view v_clube_menor5 as
 select id, nome from clube where id < 5
 with read only;
-- with check option constraint v_clube_menor_ck;
 
select * from v_clube_menor5;

insert into v_clube_menor5 values(-2, 'Teste Club');
delete from v_clube_menor5 where id = 8;

desc clube;
select * from clube;

-- 1. Crie uma visão que liste o nome do clube e os nomes de todos os seus 
-- centros de treinamentos, sendo que o clube deve ser presidido por Billie Dargavel
-- ou Conrado Dumbare.
create or replace view v_clube_ct as
select c.nome as nome_clube, ct.cidade
  from clube c join centro_treinamento ct on c.id = ct.id_clube
 where c.id_presidente in (select id from presidente
                            where nome in ('Billie Dargavel', 'Conrado Dumbare'));

select * from v_clube_ct;
desc v_clube_ct;

-- 2. Crie uma visão que contenha o nome do atleta, o seu salário e a quantidade de 
-- modalidades que pratica. Depois, consulte esta visão mostrando o nome do atleta e 
-- o valor da divisão de seu salário pela quantidade de modalidades que pratica.

-- 3. Crie uma visão que tenha o nome do atleta, seu id, o nome do campeonato que disputou e o
-- valor de premiação recebido para os atletas paraolímpicos, com os resultados ordenados por nome de 
-- atleta.

-- 4. Crie uma visão que tenha o nome do clube, o nome de seu presidente, a quantidade de atletas
-- e o total em valor de premiação já recebido pelo clube.

-- 5. Crie a visão v_soccer que contenha o id do atleta, seu nome e o id da modalidade que pratica,
-- para todos os atletas que praticam a modalidade Soccer. As colunas devem se chamar id_atl, nome_atle e
-- id_modalidade, respectivamente. Para segurança, não permita que nenhum atleta seja realocado
-- para outra modalidade por meio da view criada. Chame a constraint criada de v_soccer_ck.
create or replace view v_soccer (id_atl, nome_atl, id_modalidade) as 
select a.id, a.nome, p.id_modalidade
  from atleta a join pratica p on p.id_atleta = a.id
   and p.id_modalidade = (select id from modalidade
                           where descricao = 'Soccer')
with check option constraint v_soccer_ck;

-- 6. Tente realocar o atleta Allie Tessier para a modalidade 5 (Hocker) por meio da visão criada no
-- exercício anterior.

select * from v_soccer;
update v_soccer set id_modalidade = 5 where nome_atl = 'Allie Tessier';

-- 7.

create or replace view v_atl_olimp_paraolimp(atleta, tipo, observacao) as
select a.nome, 'O', o.incentivo_governo
  from olimpico o join atleta a on o.id_atleta = a.id
union
select a.nome, 'P', p.deficiencia
  from paraolímpico p join atleta a on p.id_atleta = a.id;

select * from v_atl_olimp_paraolimp;

-- Privileges
-- system comandos
-- comando dado para permitir criar role e sessions
alter session set "_oracle_script"=true;

create user gabriel identified by gabriel;
create user hr identified by hr;
grant create session to hr;
grant create any table to hr;
grant create any sequence to hr;
grant select any table to hr;
grant update any table to hr;
grant insert any table to hr;
grant create any view to gabriel;
grant drop any view to gabriel;
alter user hr quota unlimited on users;

-- role é facil de dar manutencão passando vários privilégios ao mesmo tempo
drop role desenvolvedor;
create role desenvolvedor;
grant create session, create table, create view, create sequence to desenvolvedor;
create user maria identified by maria;
grant desenvolvedor to maria;

revoke create session, create table from gabriel;
grant create session, create table to gabriel;

revoke create sequence from desenvolvedor;

-- trocar senha de usuario
alter user gabriel identified by gabriel123;
-- destravar conta

-- travar conta
alter user gabriel identified by gabriel123 account unlock ;
-- Privilegios de objetos:
grant insert on HR.ATLETA to hr;
grant insert on HR.PRESIDENTE to hr;


-- utilizando os usuários criados pelo system
create table teste_priv (cod number(1), texto char(1));
alter table teste_priv modify texto varchar2(10);
insert into teste_priv values (1, 'aaaaaa');

create sequence teste_id_seq increment by 1 start with 2 nocache;
insert into teste_priv values (teste_id_seq.nextval, 'bbbbbb');
select * from teste_priv;

create view v_teste_priv as select texto from teste_priv;

create table hr.teste_priv2(id number(1), descricao varchar2(10));