-- aula trigger
alter table HR.ATLETA
    add data_ult_alt date;
alter table HR.ATLETA
    add user_ult_alt varchar2(20);
commit;

-- Permissao
grant create any trigger to HR;
commit;

-- trigger
create or replace trigger tr_registra_alteracao
    before insert or update
    on HR.ATLETA
    for each row
begin
    :new.data_ult_alt := sysdate;
    :new.user_ult_alt := user;
end tr_registra_alteracao;

-- teste trigger
update HR.ATLETA
set ENDERECO = 'alguma rua nova'
where ID = 15;
select *
from HR.ATLETA
where id = 15;

-- Audit table
CREATE TABLE audit_atleta_sal
(
    id_atleta  NUMBER(4),
    sal_antigo NUMBER(8, 2),
    sal_novo   NUMBER(8, 2),
    usuario    VARCHAR2(20),
    data_alt   TIMESTAMP,
    CONSTRAINT AUDIT_ATL_SAL_PK PRIMARY KEY (id_atleta, data_alt),
    CONSTRAINT AUDIT_ATL_SAL_ID_FK FOREIGN KEY (id_atleta)
        REFERENCES atleta (id)
);

create or replace trigger tr_audit_atleta_saL
    BEFORE update of SALARIO
    on HR.ATLETA
    for each row
    when ( new.SALARIO <> old.SALARIO )
begin
    DBMS_OUTPUT.PUT_LINE('Salario antigo ' || :old.SALARIO);
    DBMS_OUTPUT.PUT_LINE('Salario novo ' || :new.SALARIO);
    insert into audit_atleta_sal values (:new.id, :old.salario, :new.salario, user, sysdate);
end;

update HR.ATLETA
set SALARIO = 9000
where ID = 4;
select *
from audit_atleta_sal;

-- update tabela
alter table HR.CLUBE
    add qtde_altetas number default 0;
commit;
update HR.CLUBE c
set c.qtde_altetas = (select count(*) from HR.ATLETA a where a.ID_CLUBE = c.ID);
select *
from HR.CLUBE;

-- trigger
create or replace trigger tr_set_qtde_atletas_clube
    before insert or delete
    on HR.ATLETA
    for each row
begin
    if inserting then
        update HR.CLUBE set qtde_altetas = qtde_altetas + 1 where ID = :new.id_clube;
    elsif deleting then
        update HR.CLUBE set qtde_altetas = qtde_altetas - 1 where ID = :old.id_clube;
    end if;
end tr_set_qtde_atletas_clube;

INSERT INTO ATLETA(ID, NOME, CPF, SALARIO, DATANASC, ID_CLUBE)
VALUES (1002, 'Fernanda Venturini', '123-99-3672', 20000, to_date('22-09-1981', 'dd-mm-yyyy'), 21);

--
CREATE TABLE MODALIDADE_LOG
(
    usuario  VARCHAR2(20),
    data_alt TIMESTAMP,
    operacao VARCHAR2(30),
    CONSTRAINT MODALIDADE_LOG_PK PRIMARY KEY (usuario, data_alt)
);

create or replace trigger tr_modalidade_log_op
    after insert or delete or update
    on HR.MODALIDADE
declare
    v_oper MODALIDADE_LOG.operacao%type;
begin
    if inserting then
        v_oper := 'insercao realizada';
    elsif updating then
        v_oper := 'atualizacao realizada';
    elsif deleting then
        v_oper := 'remocao realizada';
    end if;
    insert into MODALIDADE_LOG values (user, sysdate, v_oper);
end tr_modalidade_log_op;

select *
from MODALIDADE_LOG;
insert into HR.MODALIDADE(id, descricao, OLIMPICA)
VALUES (35, 'l', 's');
update HR.MODALIDADE
set DESCRICAO = 'lala'
where ID = 35;
delete HR.MODALIDADE
where ID = 35;


CREATE OR REPLACE VIEW V_ATLETA_CLUBE AS
SELECT c.nome nome_clube, a.id, a.nome nome_atleta, a.salario * 12 sal_anual
FROM clube c
         JOIN atleta a ON c.id = a.id_clube
ORDER BY c.nome, a.nome;

UPDATE v_atleta_clube
SET sal_anual = 72000
WHERE id = 21;

create or replace trigger tr_cube_atleta_sal
    instead of update
    on V_ATLETA_CLUBE
    for each row
begin
    if :new.sal_anual <> :old.sal_anual then
        update HR.ATLETA
        set SALARIO = :new.sal_anual / 12
        where id = :new.id;
    end if;
end;

alter trigger tr_cube_atleta_sal disable;
alter trigger tr_cube_atleta_sal enable;

alter table HR.ATLETA
    disable all triggers;
alter table HR.ATLETA
    enable all triggers;

drop trigger tr_cube_atleta_sal;

-- EX Aula
CREATE TABLE cliente
(
    cod           number(3),
    nome          varchar2(30),
    qtde_locacoes number(5) default 0,
    CONSTRAINT cliente_pk PRIMARY KEY (cod)
);

CREATE TABLE FILME
(
    cod           number(3),
    titulo        varchar2(30),
    classificacao varchar2(20),
    qtde_locacoes number(5) default 0,
    CONSTRAINT filme_pk PRIMARY KEY (cod)
);


CREATE TABLE ALUGUEL
(
    nro           number(6),
    cod_cli       number(3),
    cod_filme     number(3),
    data_hora_emp timestamp default sysdate,
    data_hora_dev timestamp,
    CONSTRAINT aluguel_pk PRIMARY KEY (nro),
    CONSTRAINT aluguel_cli_fk FOREIGN KEY (cod_cli) REFERENCES cliente (cod),
    CONSTRAINT aluguel_filme_fk FOREIGN KEY (cod_filme) REFERENCES filme (cod)
);


INSERT INTO cliente(cod, nome)
VALUES (1, 'Maria');
INSERT INTO cliente(cod, nome)
VALUES (2, 'Joao');
INSERT INTO filme(cod, titulo, classificacao)
VALUES (10, 'X-Men', 'Normal');
INSERT INTO filme(cod, titulo, classificacao)
Values (20, 'Capitao America', 'Lançamento');
insert into ALUGUEL(nro, cod_cli, cod_filme)
VALUES (1, 1, 10);