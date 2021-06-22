--Script pré aula
create table pessoa(
  id        number,
  nome      varchar2(30),
  sexo      char(1),
  cor_olhos char(1),
  categ_id  number(2),
  constraint pessoa_pk primary key(id)
);

create table categoria(
  categ_id  number(2),
  descricao varchar2(20),
  constraint categoria_pk primary key(categ_id)
);

alter table pessoa add constraint pessoa_categ_fk foreign key(categ_id) references categoria(categ_id);

begin
dbms_output.put_line('Populando a tabela Categoria...');
insert into categoria values (1, 'Nivel A');
insert into categoria values (2, 'Nivel B');
insert into categoria values (3, 'Nivel C');
insert into categoria values (4, 'Nivel D');
insert into categoria values (5, 'Nivel E');
insert into categoria values (6, 'Nivel F');
insert into categoria values (7, 'Nivel G');
insert into categoria values (8, 'Nivel H');
insert into categoria values (9, 'Nivel I');
insert into categoria values (10, 'Nivel J');
insert into categoria values (11, 'Nivel K');
insert into categoria values (12, 'Nivel L');
insert into categoria values (13, 'Nivel M');
insert into categoria values (14, 'Nivel N');
insert into categoria values (15, 'Nivel O');
insert into categoria values (16, 'Nivel P');
insert into categoria values (17, 'Nivel Q');
insert into categoria values (18, 'Nivel R');
insert into categoria values (19, 'Nivel S');
insert into categoria values (20, 'Nivel T');
commit;

dbms_output.put_line('Iniciando a carga de dados da tabela Pessoa...');
for i in 1..100000 loop
  insert into pessoa(id, nome) values(i, 'Joao' || to_char(i,'000000'));
  if mod(i,10000) = 0 then
    commit;
  end if;
end loop;
commit;
dbms_output.put_line('Carga de dados da tabela Pessoa conclu�da com sucesso!');

dbms_output.put_line('Atualizando a coluna cor dos olhos...');
update pessoa set cor_olhos = 'A' where mod(id,4)=0;
update pessoa set cor_olhos = 'V' where mod(id,4)=1;
update pessoa set cor_olhos = 'C' where mod(id,4)=2;
update pessoa set cor_olhos = 'P' where mod(id,4)=3;
commit;
dbms_output.put_line('Atualizando a coluna sexo...');
update pessoa set sexo = 'M' where mod(id,2) = 0;
update pessoa set sexo = 'F' where mod(id,2) = 1;
commit;
dbms_output.put_line('Atualizando a coluna categ_id...');
update pessoa set categ_id = 1 where mod(id,20)=0;
update pessoa set categ_id = 2 where mod(id,20)=1;
update pessoa set categ_id = 3 where mod(id,20)=2;
update pessoa set categ_id = 4 where mod(id,20)=3;
update pessoa set categ_id = 5 where mod(id,20)=4;
update pessoa set categ_id = 6 where mod(id,20)=5;
update pessoa set categ_id = 7 where mod(id,20)=6;
update pessoa set categ_id = 8 where mod(id,20)=7;
update pessoa set categ_id = 9 where mod(id,20)=8;
update pessoa set categ_id = 10 where mod(id,20)=9;
update pessoa set categ_id = 11 where mod(id,20)=10;
update pessoa set categ_id = 12 where mod(id,20)=11;
update pessoa set categ_id = 13 where mod(id,20)=12;
update pessoa set categ_id = 14 where mod(id,20)=13;
update pessoa set categ_id = 15 where mod(id,20)=14;
update pessoa set categ_id = 16 where mod(id,20)=15;
update pessoa set categ_id = 17 where mod(id,20)=16;
update pessoa set categ_id = 18 where mod(id,20)=17;
update pessoa set categ_id = 19 where mod(id,20)=18;
update pessoa set categ_id = 20 where mod(id,20)=19;
commit;
dbms_output.put_line('Script executado com sucesso');
end;


-- index

select count(*) from pessoa;
select count(*) from categoria;

select * from pessoa;
select * from PESSOA where nome = 'Joao 062000';
create index PESSOA_nome_ix on pessoa(nome);

select * from pessoa where sexo = 'M';
create index PESSOA_sexo_ix on PESSOA(sexo);
drop index PESSOA_sexo_ix;

select p.NOME, c.DESCRICAO from pessoa p join CATEGORIA c on c.CATEG_ID = p.CATEG_ID;
create index pessoa_categ_ix on PESSOA(CATEG_ID);
drop index pessoa_categ_ix;

select * from PESSOA where upper(nome) = 'JOAO 062000';
create index pessoa_nome_ix2 on pessoa(upper(nome));

select * from pessoa where CATEG_ID = 1 and nome like 'Joao 09%';
create index pessoa_cat_nome_ix on PESSOA(CATEG_ID, NOME);

select * from pessoa where CATEG_ID = 5;

select * from pessoa where COR_OLHOS = 'A';
create BITMAP index pessoa_olhos_BIX on PESSOA(COR_OLHOS);

select * from PESSOA where COR_OLHOS = 'A';

