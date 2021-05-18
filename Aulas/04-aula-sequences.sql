-- SEQUENCES
create sequence teste_seq increment by 10 start with 1 maxvalue 9999 cycle nocache;
create sequence teste2_seq increment by 25 start with 100 nocycle cache 10;
create sequence teste3_seq start with 1 increment by 1 nocache;

create table tabela_teste (
   id number,
   nome varchar2(20)
);

insert into tabela_teste values(teste_seq.nextval, 'Gabriel');
select * from tabela_teste;

-- só consegue pegar o valor atual da sequence depois que ter dado um nextval
-- OBS: usamos dual quando queremos consultar algo que não tem como acessar.
select teste_seq.currval from dual;
select teste2_seq.currval from dual;

alter sequence teste_seq nomaxvalue nocycle;

-- unica coisa que não conseguimos alterar no Sequence é o start with
alter sequence teste_seq start with 5;

drop sequence teste3_seq;

-- Crie a tabela teste com duas colunas: 
-- Numero - number(3) - primary key
-- descricao -varchar2(10)

create table teste (
    numero number(3) primary key,
    descricao varchar2(10)
);

-- Crie uma sequence que será usada como pk da tabela teste.
-- A sequence deve começar com o valor 100 e ter um valor máximo
-- 999. O incremento a cada valor deve ser 23. Não utilize valor de cache. Chame
-- a sequence Teste_nro_seq.

create sequence teste_nro_seq increment by 23 start with 100 maxvalue 999 nocache;

-- insira 3 registros na tabela teste, utilizando a sequence criada nos comandos insert.

insert into teste values (teste_nro_seq.nextval, 'a');
insert into teste values (teste_nro_seq.nextval, 'b');
insert into teste values (teste_nro_seq.nextval, 'c');

select * from teste;
-- altere o valor de incremento da sequence para 12.

alter sequence teste_nro_seq increment by 12;

-- insira mais 2 registros na tabela teste, utilizando a sequence criada nos comandos inserts.
insert into teste values (teste_nro_seq.nextval, 'd');
insert into teste values (teste_nro_seq.nextval, 'e');

select * from teste;

-- como trocar a sequence de todos os elementos que já estão na tabela?
drop sequence teste_nro_seq;
create sequence teste_nro_seq start with 1 increment by 23 maxvalue 999 nocache;