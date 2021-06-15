-- 1. Conseidere as seguintes tabelas de um banco de dados relacional:
--  Cliente(cod, nome, qtde_locacoes)
--  Aluguel(nro, cod_cli, cod_filme, data_hora_emp, data_hora_dev)
--  Filme(cod, titulo, classificacao, qtde_locacoes)
-- I - Crie as tabelas acima, definido tipo e constrains adequadas. Coloque o valor default 0 para qdte_locacoes nas
-- tabelas e sysdate para data_hora_emp na tabela Aluguel.
-- II - Os atributos qtde_locacoes sao atributos derivados e devem ser atualizados por meio de triggers.
-- III - O valor do atrabuto data_hora_dev deve ser atualizado conforme a classificacao do filme - Lançamento (1dia)
-- ou Normal (2 dias). Desenvolva um gatilho para gerar corretamente este valor.
-- IV - Teste os gatilhos por meio de inserções de dados na tabela Aluguel. Consulte todas as tabelas para saber se
-- funcionou.

CREATE TABLE cliente (
    cod number(3),
    nome varchar2(30),
    qtde_locacoes number(5) default 0,
    CONSTRAINT cliente_pk PRIMARY KEY(cod)
);

CREATE TABLE FILME (
    cod number(3),
    titulo varchar2(30),
    classificacao varchar2(20),
    qtde_locacoes number(5) default 0,
    CONSTRAINT filme_pk PRIMARY KEY(cod)
);

CREATE TABLE ALUGUEL (
    nro number(6),
    cod_cli number(3),
    cod_filme number(3),
    data_hora_emp timestamp default sysdate,
    data_hora_dev timestamp,
    CONSTRAINT aluguel_pk PRIMARY KEY(nro),
    CONSTRAINT aluguel_cli_fk FOREIGN KEY(cod_cli) REFERENCES cliente(cod),
    CONSTRAINT aluguel_filme_fk FOREIGN KEY(cod_filme) REFERENCES filme(cod)
);

INSERT INTO cliente(cod, nome) VALUES (1, 'Maria');
INSERT INTO cliente(cod, nome) VALUES (2, 'Joao');
INSERT INTO filme(cod, titulo, classificacao) VALUES (10, 'X-Men', 'Normal');
INSERT INTO filme(cod, titulo, classificacao) Values (20, 'Capitao America', 'Lançamento');

create or replace trigger tr_aluguel
    before insert on aluguel
    for each row
declare
    v_class filme.classificacao%type;
begin
    select classificacao into v_class
        from filme where cod = :new.cod_filme;

    update cliente set qtde_locacoes = qtde_locacoes + 1
        where cod = :new.cod_cli;

    update filme set qtde_locacoes = qtde_locacoes + 1
        where cod = :new.cod_filme;

    if v_class = 'Lançamento' then
        :new.data_hora_dev := :new.data_hora_emp + 1;
    else
        :new.data_hora_dev := :new.data_hora_emp + 2;
    end if;
end tr_aluguel;

insert into ALUGUEL(nro, cod_cli, cod_filme) values (1,1,10);
select * from cliente;
select * from filme;
select * from ALUGUEL;
