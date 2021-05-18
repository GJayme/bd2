CREATE TABLE CLUBE (
    id NUMBER(4) NOT NULL,
    nome VARCHAR2(40) NOT NULL,
    data_fundacao DATE,
    id_presidente NUMBER(4),
    CONSTRAINT clube_pk PRIMARY KEY (id),
    CONSTRAINT clube_nome_uk UNIQUE (nome)
);

CREATE TABLE ATLETA (
    id NUMBER(4) NOT NULL,
    cpf VARCHAR2(14) NOT NULL,
    nome VARCHAR2(60) NOT NULL,
    sexo CHAR(1),
    datanasc DATE,
    endereco VARCHAR2(50),
    salario NUMBER(8,2) NOT NULL,
    id_clube NUMBER(4),
    CONSTRAINT atleta_pk PRIMARY KEY (id),
    CONSTRAINT atleta_uk UNIQUE (cpf),
    CONSTRAINT atleta_sexo_ck CHECK (sexo in ('M','F','m','f')),
    CONSTRAINT atleta_salario_ck CHECK (salario > 0),
    CONSTRAINT atleta_clube_fk FOREIGN KEY (id_clube) REFERENCES clube(id)
);

CREATE TABLE MODALIDADE(
    id NUMBER(3),
    descricao VARCHAR2(30),
    olimpica CHAR(1) DEFAULT 'N',
    CONSTRAINT modalidade_pk PRIMARY KEY (id),
    CONSTRAINT modalidade_olimpica_pk CHECK(olimpica IN ('S', 's', 'N', 'n')) 
    
);

CREATE TABLE PRESIDENTE (
    id NUMBER(4),
    cpf VARCHAR2(14) NOT NULL,
    nome VARCHAR2(50) NOT NULL,
    email VARCHAR2(80),
    telefone VARCHAR2(20),
    CONSTRAINT presidente_pk PRIMARY KEY (id),
    CONSTRAINT presidente_cpf_uk UNIQUE (cpf)
);

DESC MODALIDADE;

ALTER TABLE atleta ADD idade DATE;

ALTER TABLE atleta MODIFY idade NUMBER(3);

ALTER TABLE atleta DROP COLUMN idade;

SELECT TO_CHAR(sysdate, 'YYYY-MM-DD') as hoje FROM dual;

ALTER TABLE clube ADD CONSTRAINT clube_press_fk 
    FOREIGN KEY(id_presidente) REFERENCES presidente(id);
    
INSERT INTO presidente (id, nome, cpf, email, telefone) VALUES (1, 'Godofredo Silva', '195.819.621-70', 'gsilva@gmail.com', '(16) 3411-9878');
INSERT INTO presidente (id, nome, cpf, email, telefone) VALUES (2, 'Maria Sincera', '876.987.345-66', 'marias@globo.com', '(19) 99876-8764');
INSERT INTO presidente (id, nome, cpf, email, telefone) VALUES (3, 'Patrício Dias', '100.200.300-44', 'padias@outlook.com', '(11) 91254-8756');

INSERT INTO clube (id, nome, data_fundacao, id_presidente) VALUES (10, 'Pinheiros', to_date('11/04/1965', 'DD/MM/YYYY'), 1);
INSERT INTO clube (id, nome, data_fundacao, id_presidente) VALUES (20, 'Flamengo', to_date('21/07/2010', 'DD/MM/YYYY'), 3);
INSERT INTO clube (id, nome, data_fundacao, id_presidente) VALUES (30, 'Clube da Luta', to_date('03/08/1977', 'DD/MM/YYYY'), 2);
INSERT INTO clube (id, nome, data_fundacao, id_presidente) VALUES (40, 'Santos', to_date('04/09/1921', 'DD/MM/YYYY'), null);

INSERT INTO atleta (id, nome, cpf, sexo, datanasc, endereco, salario, id_clube) VALUES (1, 'Jade Barbosa', '112.356.757-34', 'F', to_date('27/10/1990', 'DD/MM/YYYY'), 'Rua das Artes, 132', 10500, null);
INSERT INTO atleta (id, nome, cpf, sexo, datanasc, endereco, salario, id_clube) VALUES (2, 'Gustavo Borges', '231.423.547-11', 'M', to_date('10/05/1985', 'DD/MM/YYYY'), 'Rua das Águas, 365', 48300.55, null);
INSERT INTO atleta (id, nome, cpf, sexo, datanasc, endereco, salario, id_clube) VALUES (3, 'Anderson Silva', '358.967.111-21', 'M', to_date('1982-02-15','YYYY-MM-DD'), 'Av. Spider, 12', 7200.50, 30);
INSERT INTO atleta (id, nome, cpf, sexo, datanasc, endereco, salario, id_clube) VALUES (4, 'Marta', '987.654.321-00', 'F', to_date('1988-07-07','YYYY-MM-DD'), 'Rua da Bola, 1437', 125000, 40);

DESC atleta;

SELECT * FROM presidente;
select * from clube;
select * from atleta;

UPDATE atleta SET id_clube = 10 where id = 1;
UPDATE atleta SET id_clube = 20 where id = 2;

UPDATE atleta SET salario = salario * 1.1 where sexo = 'F';

DELETE FROM presidente WHERE id = 1;

-- NO ACTION/RESTRICT
-- CASCADE
-- SET NULL 

ALTER TABLE clube DROP CONSTRAINT clube_pres_fk;