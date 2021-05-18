CREATE TABLE PRESIDENTE (
    id          NUMBER(4), 
    cpf         VARCHAR2(14) NOT NULL, 
    nome        VARCHAR2(50) NOT NULL, 
    email       VARCHAR2(80), 
    telefone    VARCHAR2(20),
    CONSTRAINT presidente_pk PRIMARY KEY (id),
    CONSTRAINT presidente_cpf_uk UNIQUE (nome)
);

CREATE TABLE clube (
    id 		        NUMBER(4) NOT NULL,
    nome 		    VARCHAR2(40) NOT NULL,
    data_fundacao	DATE,
    id_presidente 	NUMBER(4),
    CONSTRAINT clube_pk PRIMARY KEY (id),
    CONSTRAINT clube_nome_uk UNIQUE (nome),
    CONSTRAINT clube_presidente_fk FOREIGN KEY (id_presidente) REFERENCES presidente(id)
);

CREATE TABLE atleta (
    id 		    NUMBER(4) NOT NULL,
    cpf 		VARCHAR2(14) NOT NULL,
    nome 		VARCHAR2(60) NOT NULL,
    sexo 		CHAR(1),
    datanasc 	DATE,
    endereco 	VARCHAR2(50),
    salario 	NUMBER(8,2) NOT NULL,
    id_clube	NUMBER(4),
    CONSTRAINT atleta_pk PRIMARY KEY (id),
    CONSTRAINT atleta_uk UNIQUE (cpf),
    CONSTRAINT atleta_sexo_ck CHECK (sexo in ('M','F','m','f')),
    CONSTRAINT atleta_salario_ck CHECK (salario > 0),
    CONSTRAINT atleta_clube_fk FOREIGN KEY (id_clube) REFERENCES clube(id)
);

CREATE TABLE OLIMPICO (
    id_atleta           NUMBER(4), 
    incentivo_governo   CHAR(1),
	CONSTRAINT olimpico_pk PRIMARY KEY (id_atleta),
    CONSTRAINT olimpico_incentivo_ck CHECK(incentivo_governo IN ('S','s','N','n')),
    CONSTRAINT olimpico_atleta_fk FOREIGN KEY (id_atleta) REFERENCES atleta(id)
);

CREATE TABLE PARAOLIMPICO (
    id_atleta   NUMBER(4), 
    deficiencia VARCHAR2(30),
    nivel       NUMBER,
	CONSTRAINT paraolimpico_pk PRIMARY KEY (id_atleta),
    CONSTRAINT paraolimpico_nivel_ck CHECK(nivel BETWEEN 1 AND 5),
    CONSTRAINT paraolimpico_atleta_fk FOREIGN KEY (id_atleta) REFERENCES atleta(id)
);

CREATE TABLE MODALIDADE (
    id          NUMBER(3), 
    descricao   VARCHAR2(30), 
    olimpica    CHAR(1) DEFAULT 'N',
    CONSTRAINT modalidade_pk PRIMARY KEY (id),
    CONSTRAINT modalidade_olimpica_ck CHECK(olimpica IN ('S','s','N','n'))
);

CREATE TABLE CAMPEONATO (
    id          NUMBER(3), 
    nome        VARCHAR2(70) NOT NULL, 
    local       VARCHAR2(40), 
    data_inicio DATE, 
    data_fim    DATE,
    CONSTRAINT campeonato_pk PRIMARY KEY (id)
);

CREATE TABLE CENTRO_TREINAMENTO (
    id_clube    NUMBER(4), 
    id_centro   NUMBER(4), 
    fone        VARCHAR2(20), 
    rua         VARCHAR2(50), 
    nro         NUMBER, 
    bairro      VARCHAR2(50), 
    CEP         VARCHAR2(9), 
    cidade      VARCHAR2(50), 
    UF          CHAR(2),
    CONSTRAINT ct_pk PRIMARY KEY (id_clube, id_centro),
    CONSTRAINT ct_clube_fk FOREIGN KEY (id_clube) REFERENCES clube(id)
);

CREATE TABLE ATLETA_CONTATO (
    id_atleta   NUMBER(4), 
    contato     VARCHAR(20),
    CONSTRAINT atleta_contato_pk PRIMARY KEY (id_atleta, contato),
	CONSTRAINT atleta_contato_fk FOREIGN KEY(id_atleta) REFERENCES atleta(id)
);

CREATE TABLE PRATICA(
    id_atleta       NUMBER(4), 
    id_modalidade   NUMBER(3), 
    data_inicio     DATE, 
    experiencia     NUMBER,
    CONSTRAINT pratica_pk PRIMARY KEY (id_atleta, id_modalidade),
	CONSTRAINT pratica_atleta_fk FOREIGN KEY(id_atleta) REFERENCES atleta(id),
    CONSTRAINT pratica_modalidade_fk FOREIGN KEY(id_modalidade) REFERENCES modalidade(id)
);

CREATE TABLE ESPORTE (
    registro_atleta NUMBER(8), 
    id_atleta       NUMBER(4), 
    id_modalidade   NUMBER(3),
    CONSTRAINT esporte_pk PRIMARY KEY (registro_atleta),
	CONSTRAINT esporte_atleta_fk FOREIGN KEY(id_atleta) REFERENCES atleta(id),
    CONSTRAINT esporte_modalidade_fk FOREIGN KEY(id_modalidade) REFERENCES modalidade(id)
);

CREATE TABLE PARTICIPA (
    registro_atleta NUMBER(8), 
    id_campeonato   NUMBER(3), 
    colocacao       NUMBER(5), 
    valor_premiacao NUMBER(10,2) DEFAULT 0,
    CONSTRAINT participa_pk PRIMARY KEY (registro_atleta, id_campeonato),
	CONSTRAINT participa_registro_fk FOREIGN KEY(registro_atleta) REFERENCES esporte(registro_atleta),
    CONSTRAINT participa_campeonato_fk FOREIGN KEY(id_campeonato) REFERENCES campeonato(id)
);

-- Inser��o dos presidentes
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (1, '785-45-5286', 'Tamera Bravington', 'tbravington0@studiopress.com', '367-956-3178');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (2, '289-05-0419', 'Billie Dargavel', 'bdargavel1@clickbank.net', '995-722-9098');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (3, '261-92-1249', 'Murdock Evesque', 'mevesque2@merriam-webster.com', '320-493-9072');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (4, '167-95-8399', 'Sharai Jahncke', 'sjahncke3@wordpress.org', '907-590-0532');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (5, '150-79-1794', 'Uta Guillond', 'uguillond4@odnoklassniki.ru', '426-617-7731');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (6, '727-49-8657', 'Casi Bilborough', 'cbilborough5@youku.com', '445-135-1562');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (7, '296-08-8396', 'Delila Inkpen', 'dinkpen6@creativecommons.org', '780-365-0148');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (8, '161-20-9079', 'Diana Leamon', 'dleamon7@360.cn', '229-312-6061');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (9, '672-60-6443', 'Conrado Dumbare', 'cdumbare8@nsw.gov.au', '615-551-0726');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (10, '706-68-9424', 'Hilary Manilow', 'hmanilow9@nymag.com', '992-959-5363');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (11, '749-67-5859', 'Coop Coslett', 'ccosletta@jimdo.com', '298-186-9432');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (12, '869-37-7117', 'Ursola Brownhill', 'ubrownhillb@whitehouse.gov', '311-276-9951');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (13, '600-92-1234', 'Loise Farrand', 'lfarrandc@fastcompany.com', '407-452-7376');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (14, '738-74-2426', 'Cash Dubock', 'cdubockd@w3.org', '833-696-6152');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (15, '800-64-7952', 'Ermanno Tremblett', 'etremblette@hatena.ne.jp', '182-481-9114');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (16, '417-01-9088', 'Sherlock Laxtonne', 'slaxtonnef@google.es', '533-285-4276');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (17, '875-11-9904', 'Elvira Gerry', 'egerryg@webmd.com', '761-323-5782');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (18, '286-95-6512', 'Chelsey Swatland', 'cswatlandh@flavors.me', '636-503-9898');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (19, '211-93-3474', 'Ainsley Choppin', 'achoppini@jiathis.com', '493-555-8065');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (20, '488-96-9333', 'Moreen Abdee', 'mabdeej@loc.gov', '502-474-3238');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (21, '641-03-9023', 'Carlin Hamper', 'champerk@tinypic.com', '530-138-7253');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (22, '612-83-3180', 'Shantee Jouhning', 'sjouhningl@topsy.com', '889-807-8646');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (23, '454-70-4908', 'Dionysus Fazzioli', 'dfazziolim@netlog.com', '545-870-5186');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (24, '821-98-6400', 'Kristyn Ormesher', 'kormeshern@oaic.gov.au', '111-146-0515');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (25, '786-87-1352', 'Analiese Parsand', 'aparsando@biglobe.ne.jp', '865-996-7431');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (26, '404-63-8997', 'Prissie Cunningham', 'pcunninghamp@g.co', '662-906-6610');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (27, '219-35-2949', 'Sancho Belford', 'sbelfordq@unesco.org', '748-551-7883');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (28, '570-56-9819', 'Newton Iacomi', 'niacomir@ftc.gov', '510-573-3936');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (29, '331-09-4646', 'Frances Carslaw', 'fcarslaws@soup.io', '547-390-0108');
insert into PRESIDENTE (id, cpf, nome, email, telefone) values (30, '617-42-7162', 'Nina Budden', 'nbuddent@state.gov', '108-605-5951');

-- Inser��o dos clubes
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (1, 'Bigtax Team', to_date('24/06/1930','dd/mm/yyyy'), 3);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (2, 'Prodder Club', to_date('28/02/1977','dd/mm/yyyy'), 1);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (3, 'Itil Club', null, 5);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (4, 'Trippledex Club', to_date('16/09/1987','dd/mm/yyyy'), 11);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (5, 'Jabbing Club', null, 16);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (6, 'Bamity Team', to_date('04/01/1949','dd/mm/yyyy'), 15);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (7, 'Solarbreeze Club', null, 26);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (8, 'Duobam Team', to_date('18/08/1990','dd/mm/yyyy'), 6);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (9, 'Flowdesk Team', to_date('10/11/1934','dd/mm/yyyy'), 17);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (10, 'Veribet Club', to_date('07/07/1994','dd/mm/yyyy'), 25);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (11, 'Fixflex Club', to_date('25/04/1998','dd/mm/yyyy'), 18);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (12, 'Powerful Team', null, 27);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (13, 'Solowarm Team', to_date('20/03/1939','dd/mm/yyyy'), 2);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (14, 'Tresom Club', to_date('15/04/1955','dd/mm/yyyy'), 20);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (15, 'Sonsing Club', to_date('17/11/1967','dd/mm/yyyy'), 7);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (16, 'Dragon Team', to_date('29/08/1982','dd/mm/yyyy'), 19);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (17, 'Zamit Team', null, 28);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (18, 'Tregold Club', to_date('01/09/1996','dd/mm/yyyy'), 24);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (19, 'Flexidy Team', to_date('04/11/1999','dd/mm/yyyy'), 4);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (20, 'Toughjoy Club', to_date('20/12/1945','dd/mm/yyyy'), 12);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (21, 'Stronghold Team', to_date('16/07/1983','dd/mm/yyyy'), 29);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (22, 'Redhold Team', to_date('23/09/1965','dd/mm/yyyy'), 8);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (23, 'Alpha Team', to_date('16/10/1951','dd/mm/yyyy'), null);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (24, 'Temp Club', to_date('25/07/1989','dd/mm/yyyy'), 22);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (25, 'Kanlam Team', to_date('08/12/1996','dd/mm/yyyy'), 9);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (26, 'Tamplight Club', to_date('21/04/1946','dd/mm/yyyy'), 10);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (27, 'Holdlamis Club', to_date('04/11/1961','dd/mm/yyyy'), 23);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (28, 'Ventosanzap Team', to_date('14/02/1972','dd/mm/yyyy'), 13);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (29, 'Monster Team', to_date('12/01/1933','dd/mm/yyyy'), 21);
insert into CLUBE (id, nome, data_fundacao, id_presidente) values (30, 'Voyatouch Club', to_date('15/03/1952','dd/mm/yyyy'), 14);

-- Inser��o dos atletas
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (1, '505-75-9669', 'Lawry Peterken', 'M', to_date('23/01/1984','dd/mm/yyyy'), '82920 Kedzie Trail', 5767.3, 14);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (2, '259-09-1273', 'Frederic Bernardoux', 'M', to_date('01/11/1994','dd/mm/yyyy'), '822 Valley Edge Hill', 85648.36, 27);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (3, '332-26-7082', 'Agatha Renard', 'F', to_date('29/06/1990','dd/mm/yyyy'), '874 Hermina Alley', 82419.55, 6);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (4, '291-05-4193', 'Humfrid Iacovino', 'M', to_date('05/11/1994','dd/mm/yyyy'), '0379 Hoard Way', 58567.74, 19);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (5, '330-36-7223', 'Foster Rushmere', 'M', to_date('01/03/2002','dd/mm/yyyy'), '3546 Eastlawn Point', 86158.05, 24);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (6, '878-04-7790', 'Ranice Sherbourne', 'F', to_date('24/08/2004','dd/mm/yyyy'), '991 Almo Pass', 65187.24, 26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (7, '246-93-5580', 'Ringo Vidgeon', 'M', to_date('11/10/1996','dd/mm/yyyy'), '07 Jenifer Drive', 83651.2, 27);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (8, '360-11-1351', 'Shurwood Soan', 'M', to_date('02/08/2003','dd/mm/yyyy'), '831 Farmco Junction', 75644.7, 29);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (9, '620-48-2618', 'Pernell Boorer', 'M', to_date('01/12/1984','dd/mm/yyyy'), '47817 Marquette Hill', 81478.62, 11);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (10, '266-64-4666', 'Gannie Pidgeley', 'M', to_date('01/08/1990','dd/mm/yyyy'), '44 Columbus Pass', 31384.28, 15);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (11, '831-23-8244', 'Franzen Clawe', 'M', to_date('17/06/1988','dd/mm/yyyy'), '9 Dayton Parkway', 27425.2, 24);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (12, '628-15-0557', 'Sophie Teodorski', 'F', to_date('16/07/1985','dd/mm/yyyy'), '50703 Monica Court', 33139.7, 26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (13, '435-84-4340', 'Ike Hakonsson', 'M', to_date('02/04/1999','dd/mm/yyyy'), '7 Lakeland Center', 99488.3, 19);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (14, '664-74-5725', 'Leandra Piner', 'F', to_date('08/12/2002','dd/mm/yyyy'), '04 Corben Parkway', 18400.73, 4);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (15, '655-85-9107', 'Blanche Lillico', 'F', to_date('12/09/1986','dd/mm/yyyy'), '04 Nelson Lane', 16602.8, 25);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (16, '682-27-0643', 'Yulma Robatham', 'M', to_date('05/11/1992','dd/mm/yyyy'), '8604 Gulseth Park', 37310.43, 21);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (17, '355-49-7452', 'Donavon Grason', 'M', to_date('20/05/1984','dd/mm/yyyy'), '3 Independence Trail', 71435.4, 29);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (18, '128-31-4916', 'Madella Musgrove', 'F', to_date('22/11/1985','dd/mm/yyyy'), null, 81106.95, 26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (19, '517-09-3553', 'Filip Dodamead', 'M', to_date('24/02/1995','dd/mm/yyyy'), null, 80580.89, 28);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (20, '569-15-6773', 'Allie Tessier', 'F', to_date('18/02/2000','dd/mm/yyyy'), '2 Merchant Place', 51752.76, 20);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (21, '353-94-5414', 'Lambert Taffs', 'M', to_date('12/11/1985','dd/mm/yyyy'), null, 8726.67, 13);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (22, '130-39-3125', 'Stanleigh Ruddock', 'M', to_date('11/12/1988','dd/mm/yyyy'), '9 Warner Pass', 95669.88, 25);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (23, '168-50-2229', 'Almire Beddard', 'F', to_date('27/07/1997','dd/mm/yyyy'), '88331 Canary Avenue', 29395.38, 7);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (24, '712-34-8456', 'Dominick Ivankin', null, to_date('18/09/1998','dd/mm/yyyy'), null, 87476.5, null);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (25, '675-71-4440', 'Ulises Damrel', 'M', to_date('31/12/1998','dd/mm/yyyy'), '76459 Mccormick Terrace', 23071.69, 8);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (26, '220-07-5418', 'Averill Drogan', 'M', to_date('30/01/1994','dd/mm/yyyy'), '50 Fordem Plaza', 89908.05, 9);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (27, '340-97-8450', 'Lancelot Apdell', 'M', to_date('09/07/1993','dd/mm/yyyy'), null, 74344.23, 23);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (28, '787-79-7183', 'Grace Pleavin', null, to_date('28/01/2002','dd/mm/yyyy'), '8 Bunting Trail', 28456.48, null);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (29, '724-38-1676', 'Yale Buttle', 'M', to_date('18/03/1996','dd/mm/yyyy'), '9 Brown Street', 71999.78, 2);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (30, '102-98-8071', 'Heinrick Samter', 'M', to_date('19/07/1995','dd/mm/yyyy'), null, 6483.21, 24);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (31, '588-35-6857', 'Addi Pryell', 'F', to_date('06/01/1982','dd/mm/yyyy'), '452 Sommers Parkway', 68771.69, 17);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (32, '686-72-1859', 'Johna Belf', null, to_date('02/07/1988','dd/mm/yyyy'), '1056 Birchwood Center', 84061.29, null);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (33, '469-83-6887', 'Hoyt Hawker', 'M', to_date('31/07/1995','dd/mm/yyyy'), '9 Dorton Terrace', 91900.05, 11);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (34, '471-78-5539', 'Isadora Renny', 'F', to_date('07/11/1983','dd/mm/yyyy'), '357 Mayer Point', 26402.05, 9);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (35, '714-45-3007', 'Paula Wotton', 'F', to_date('29/12/1998','dd/mm/yyyy'), '2 Nevada Junction', 93320.55, 26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (36, '694-18-8019', 'Matthaeus Ferran', 'M', to_date('16/02/1984','dd/mm/yyyy'), '2004 New Castle Drive', 93107.43, 24);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (37, '407-36-6488', 'Caspar Perago', 'M', to_date('15/01/2003','dd/mm/yyyy'), '366 Mesta Center', 60880.46, 8);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (38, '163-16-3947', 'Colleen Tunnacliffe', null, to_date('09/09/2004','dd/mm/yyyy'), '62028 Little Fleur Junction', 92680.28, null);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (39, '637-11-6317', 'Hazel Rheubottom', 'F', to_date('14/01/2002','dd/mm/yyyy'), '7838 Scoville Plaza', 32834.63, 26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (40, '735-67-1419', 'Doloritas Torald', 'F', to_date('15/10/2001','dd/mm/yyyy'), '30286 Westport Center', 65209.14, 2);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (41, '247-52-2228', 'Merwyn Sivills', 'M', to_date('03/07/2000','dd/mm/yyyy'), '072 Kensington Crossing', 4461.3, 10);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (42, '542-62-1084', 'Herc Pococke', 'M', to_date('03/01/1995','dd/mm/yyyy'), '35538 Briar Crest Plaza', 27190.48, 10);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (43, '135-46-2106', 'Galven Duckett', 'M', to_date('25/09/1993','dd/mm/yyyy'), '316 Banding Street', 54741.98, 10);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (44, '798-27-7620', 'Miquela Malloy', 'F', to_date('09/04/1983','dd/mm/yyyy'), '21 Cottonwood Street', 6998.47, 9);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (45, '435-02-4281', 'Mickie Kille', 'F', to_date('19/11/1999','dd/mm/yyyy'), '44277 6th Court', 60622.94, 18);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (46, '835-52-6663', 'Oren Peers', 'M', to_date('22/01/2002','dd/mm/yyyy'), null, 34656.84, 1);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (47, '599-51-1118', 'Josephine Chelam', 'F', to_date('23/05/2002','dd/mm/yyyy'), '758 Cordelia Way', 68826.28, 16);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (48, '763-03-7123', 'Tessi Eyckel', 'F', to_date('24/01/1997','dd/mm/yyyy'), '02130 Graceland Road', 63682.13, 7);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (49, '567-41-3531', 'Buddy Riddell', 'M', to_date('20/12/1999','dd/mm/yyyy'), '16 Clemons Alley', 72662.65, 3);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (50, '690-41-7944', 'Ianthe MacRory', 'F', to_date('25/11/1998','dd/mm/yyyy'), '558 6th Pass', 56328.64, 28);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (51, '876-07-0897', 'Tootsie Filochov', 'F', to_date('05/10/1986','dd/mm/yyyy'), '0 Oxford Terrace', 61866.27, 23);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (52, '104-47-6827', 'Lou Lovie', 'M', to_date('26/11/2004','dd/mm/yyyy'), '6 Marcy Lane', 11438.04, 10);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (53, '889-40-5983', 'Toddy McCormick', 'M', to_date('17/05/1983','dd/mm/yyyy'), '074 Village Street', 41665.36, 17);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (54, '315-51-0136', 'Marshall McSporrin', 'M', to_date('21/07/1990','dd/mm/yyyy'), '677 Claremont Center', 58388.74, 7);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (55, '668-46-5053', 'Cyndi Gianulli', 'F', to_date('14/03/2003','dd/mm/yyyy'), '6 Clemons Avenue', 24114.04, 2);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (56, '148-54-7626', 'Estele Stapele', 'F', to_date('07/12/2002','dd/mm/yyyy'), null, 39272.93, 13);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (57, '710-41-8143', 'Laurie Castellino', 'M', to_date('14/02/1990','dd/mm/yyyy'), '9 Forster Drive', 83247.63, 1);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (58, '645-82-3678', 'Alisun Skelly', 'F', to_date('16/09/2003','dd/mm/yyyy'), null, 44655.4, 14);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (59, '164-99-8076', 'Rube Jossum', 'M', to_date('17/10/1986','dd/mm/yyyy'), '42 Coleman Street', 19398.26, 21);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (60, '469-69-8829', 'Nappy Flory', 'M', to_date('21/12/1997','dd/mm/yyyy'), null, 70949.4, 8);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (61, '446-79-9387', 'Bendix Alti', 'M', to_date('30/03/2002','dd/mm/yyyy'), null, 17586.7, 1);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (62, '480-71-4866', 'Eyde Juschke', 'F', to_date('08/09/1993','dd/mm/yyyy'), '83 Hanover Parkway', 67042.57, 18);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (63, '881-45-4652', 'Wilhelmina Iggulden', 'F', to_date('16/01/1994','dd/mm/yyyy'), '116 8th Terrace', 27070.16, 29);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (64, '424-08-9564', 'Matteo Sidaway', 'M', to_date('02/01/1986','dd/mm/yyyy'), null, 80626.06, 28);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (65, '639-69-7692', 'Hurleigh Bradnick', null, to_date('01/02/1986','dd/mm/yyyy'), '9010 Sheridan Drive', 43988.82, null);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (66, '472-14-4192', 'Ketti Huerta', 'F', to_date('05/05/2003','dd/mm/yyyy'), '3933 Clemons Way', 40242.36, 29);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (67, '522-30-5384', 'Neel Rootham', 'M', to_date('27/03/1983','dd/mm/yyyy'), '3 Milwaukee Point', 61059.0, 26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (68, '222-27-8381', 'Richard Burcombe', 'M', to_date('14/04/1994','dd/mm/yyyy'), null, 35821.87, 16);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (69, '808-28-5674', 'Niko Ripsher', 'M', to_date('04/05/1989','dd/mm/yyyy'), '019 Loeprich Place', 58856.83, 28);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (70, '301-96-5323', 'Sonia Guinnane', 'F', to_date('16/03/1995','dd/mm/yyyy'), '07 Truax Point', 76937.27, 2);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (71, '787-68-4041', 'Eberhard Pusill', 'M', to_date('17/12/1990','dd/mm/yyyy'), '72 Beilfuss Street', 44553.49, 22);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (72, '325-66-8575', 'Debby Emmines', 'F', to_date('15/07/1991','dd/mm/yyyy'), '9814 Continental Alley', 47790.93, 18);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (73, '323-24-3904', 'Lewes Labroue', 'M', to_date('02/10/2001','dd/mm/yyyy'), '1 Miller Center', 26166.84, 29);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (74, '711-95-2411', 'Olwen Dellenbrok', 'F', to_date('29/06/1986','dd/mm/yyyy'), '22362 Summit Road', 12481.42, 26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (75, '191-09-9408', 'Tina Iacovides', 'F', to_date('26/12/1989','dd/mm/yyyy'), '3 Straubel Circle', 23094.61, 2);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (76, '845-78-6212', 'Ingunna Caseborne', 'F', to_date('24/05/1985','dd/mm/yyyy'), '55 Golf View Place', 72146.38, 30);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (77, '490-71-0232', 'Carmita Filipponi', 'F', to_date('08/07/1994','dd/mm/yyyy'), null, 79400.65, 18);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (78, '296-14-1783', 'Karlene Raff', 'F', to_date('24/06/1989','dd/mm/yyyy'), null, 9283.43, 25);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (79, '383-85-3985', 'Janene Edelheid', 'F', to_date('08/07/2002','dd/mm/yyyy'), '22356 Michigan Place', 36309.65, 6);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (80, '184-50-2282', 'Nial Crockett', 'M', to_date('12/04/1990','dd/mm/yyyy'), '2008 Union Trail', 34466.84, 17);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (81, '321-24-7713', 'Charlene Aisthorpe', 'F', to_date('22/11/1983','dd/mm/yyyy'), '2 Morrow Road', 4849.42, 9);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (82, '373-19-2338', 'Britt Balnaves', 'F', to_date('14/03/1990','dd/mm/yyyy'), '71720 Melby Point', 65351.02, 21);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (83, '718-76-9515', 'Anet Wanderschek', 'F', to_date('14/01/1998','dd/mm/yyyy'), '21 Sherman Avenue', 39513.26, 15);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (84, '758-73-6597', 'Timotheus Cudiff', 'M', to_date('13/05/2003','dd/mm/yyyy'), '35 Schurz Trail', 72189.55, 23);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (85, '519-10-0270', 'Karlene Freckelton', 'F', to_date('16/11/1993','dd/mm/yyyy'), null, 68886.78, 1);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (86, '208-82-4304', 'Engelbert Brawson', 'M', to_date('28/07/1994','dd/mm/yyyy'), '46995 Loomis Junction', 78588.68, 29);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (87, '782-62-0990', 'Lu McOrkil', 'F', to_date('26/10/1989','dd/mm/yyyy'), '68 Farwell Parkway', 35230.62, 12);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (88, '842-68-9833', 'Gustaf Tilbury', 'M', to_date('25/08/1985','dd/mm/yyyy'), '1 Westport Crossing', 28960.24, 22);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (89, '403-40-0578', 'Elyn Hubbucke', 'F', to_date('23/12/1988','dd/mm/yyyy'), '9 Harper Junction', 69247.67, 22);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (90, '156-48-3523', 'Beryle Standall', 'F', to_date('05/05/1988','dd/mm/yyyy'), '3040 Lien Lane', 7516.45, 10);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (91, '593-56-5435', 'Royal Sallter', 'M', to_date('30/03/2004','dd/mm/yyyy'), '4261 Jackson Hill', 12685.38, 20);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (92, '462-05-6321', 'Lincoln Kingman', 'M', to_date('04/10/1999','dd/mm/yyyy'), '9 Sommers Hill', 36671.07, 17);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (93, '863-17-0494', 'Wesley Dregan', 'M', to_date('26/02/1984','dd/mm/yyyy'), '374 Macpherson Park', 4369.48, 5);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (94, '485-71-7411', 'Tracey Lineham', 'F', to_date('21/09/1986','dd/mm/yyyy'), '845 Hermina Hill', 67609.64, 15);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (95, '205-52-2681', 'Pincus Prangle', 'M', to_date('12/09/1997','dd/mm/yyyy'), '2761 La Follette Alley', 68900.2, 2);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (96, '255-76-8860', 'Delinda Crowth', 'F', to_date('19/09/1983','dd/mm/yyyy'), '94312 Darwin Alley', 19997.72, 16);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (97, '526-92-9368', 'Wendeline Braunds', 'F', to_date('25/04/1994','dd/mm/yyyy'), null, 1696.42, 18);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (98, '656-79-4815', 'Byrle Liepins', 'M', to_date('18/07/2004','dd/mm/yyyy'), '37 Bay Alley', 74400.91, 9);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (99, '372-76-5429', 'Jesselyn Minall', 'F', to_date('06/11/1985','dd/mm/yyyy'), '3 Grover Trail', 73084.88, 13);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube) values (100, '449-34-3717', 'Zachariah Eddowis', 'M', to_date('06/09/1989','dd/mm/yyyy'), null, 36736.02, 8);

-- Inser��es dos contatos dos atletas
insert into ATLETA_CONTATO (id_atleta, contato) values (3, '(601) 7382910');
insert into ATLETA_CONTATO (id_atleta, contato) values (35, '(424) 1277153');
insert into ATLETA_CONTATO (id_atleta, contato) values (8, '(853) 4939806');
insert into ATLETA_CONTATO (id_atleta, contato) values (10, '(537) 7676929');
insert into ATLETA_CONTATO (id_atleta, contato) values (5, '(930) 3424502');
insert into ATLETA_CONTATO (id_atleta, contato) values (24, '(805) 8850394');
insert into ATLETA_CONTATO (id_atleta, contato) values (21, '(961) 4319690');
insert into ATLETA_CONTATO (id_atleta, contato) values (39, '(582) 5786007');
insert into ATLETA_CONTATO (id_atleta, contato) values (19, '(327) 4362855');
insert into ATLETA_CONTATO (id_atleta, contato) values (25, '(334) 6464131');
insert into ATLETA_CONTATO (id_atleta, contato) values (36, '(220) 5874448');
insert into ATLETA_CONTATO (id_atleta, contato) values (14, '(245) 6444676');
insert into ATLETA_CONTATO (id_atleta, contato) values (3, '(204) 7075984');
insert into ATLETA_CONTATO (id_atleta, contato) values (29, '(831) 6814772');
insert into ATLETA_CONTATO (id_atleta, contato) values (8, '(823) 9114157');
insert into ATLETA_CONTATO (id_atleta, contato) values (1, '(172) 4988196');
insert into ATLETA_CONTATO (id_atleta, contato) values (40, '(528) 3226452');
insert into ATLETA_CONTATO (id_atleta, contato) values (3, '(304) 7327208');
insert into ATLETA_CONTATO (id_atleta, contato) values (31, '(167) 8232204');
insert into ATLETA_CONTATO (id_atleta, contato) values (36, '(903) 1863360');
insert into ATLETA_CONTATO (id_atleta, contato) values (17, '(803) 1615017');
insert into ATLETA_CONTATO (id_atleta, contato) values (1, '(663) 8443211');
insert into ATLETA_CONTATO (id_atleta, contato) values (14, '(931) 5897442');
insert into ATLETA_CONTATO (id_atleta, contato) values (20, '(859) 8551564');
insert into ATLETA_CONTATO (id_atleta, contato) values (12, '(973) 3484414');
insert into ATLETA_CONTATO (id_atleta, contato) values (24, '(620) 1429068');
insert into ATLETA_CONTATO (id_atleta, contato) values (15, '(418) 3535451');
insert into ATLETA_CONTATO (id_atleta, contato) values (25, '(464) 6517647');
insert into ATLETA_CONTATO (id_atleta, contato) values (15, '(376) 3345143');
insert into ATLETA_CONTATO (id_atleta, contato) values (29, '(750) 2970402');
insert into ATLETA_CONTATO (id_atleta, contato) values (22, '(402) 2094554');
insert into ATLETA_CONTATO (id_atleta, contato) values (5, '(934) 8184141');
insert into ATLETA_CONTATO (id_atleta, contato) values (19, '(508) 1233810');
insert into ATLETA_CONTATO (id_atleta, contato) values (15, '(524) 9040828');
insert into ATLETA_CONTATO (id_atleta, contato) values (10, '(949) 7263269');
insert into ATLETA_CONTATO (id_atleta, contato) values (6, '(827) 9983340');
insert into ATLETA_CONTATO (id_atleta, contato) values (27, '(634) 9608119');
insert into ATLETA_CONTATO (id_atleta, contato) values (17, '(353) 1617571');
insert into ATLETA_CONTATO (id_atleta, contato) values (27, '(930) 3096037');
insert into ATLETA_CONTATO (id_atleta, contato) values (21, '(705) 3022456');
insert into ATLETA_CONTATO (id_atleta, contato) values (36, '(901) 2881330');
insert into ATLETA_CONTATO (id_atleta, contato) values (2, '(190) 1524601');
insert into ATLETA_CONTATO (id_atleta, contato) values (15, '(665) 6201461');
insert into ATLETA_CONTATO (id_atleta, contato) values (16, '(685) 9381272');
insert into ATLETA_CONTATO (id_atleta, contato) values (32, '(344) 4370898');
insert into ATLETA_CONTATO (id_atleta, contato) values (16, '(974) 2598779');
insert into ATLETA_CONTATO (id_atleta, contato) values (3, '(208) 5945890');
insert into ATLETA_CONTATO (id_atleta, contato) values (31, '(874) 3764618');
insert into ATLETA_CONTATO (id_atleta, contato) values (19, '(335) 4648941');
insert into ATLETA_CONTATO (id_atleta, contato) values (7, '(645) 3624445');
insert into ATLETA_CONTATO (id_atleta, contato) values (16, '(146) 1553210');
insert into ATLETA_CONTATO (id_atleta, contato) values (8, '(920) 5577754');
insert into ATLETA_CONTATO (id_atleta, contato) values (5, '(535) 7174885');
insert into ATLETA_CONTATO (id_atleta, contato) values (10, '(519) 9464991');
insert into ATLETA_CONTATO (id_atleta, contato) values (39, '(493) 5374018');
insert into ATLETA_CONTATO (id_atleta, contato) values (19, '(634) 4159429');
insert into ATLETA_CONTATO (id_atleta, contato) values (24, '(950) 5932172');
insert into ATLETA_CONTATO (id_atleta, contato) values (23, '(599) 3251876');
insert into ATLETA_CONTATO (id_atleta, contato) values (31, '(584) 3107077');
insert into ATLETA_CONTATO (id_atleta, contato) values (1, '(566) 9226280');

-- Inser��es dos atletas ol�mpicos
insert into OLIMPICO (id_atleta, incentivo_governo) values (1, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo) values (2, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo) values (5, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo) values (7, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo) values (8, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo) values (10, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo) values (12, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo) values (13, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo) values (15, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo) values (16, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo) values (17, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo) values (19, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo) values (20, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo) values (21, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo) values (25, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo) values (28, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo) values (30, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo) values (31, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo) values (32, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo) values (35, 'N');

-- Inser��es dos atletas paraol�mpicos
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel) values (4, 'Motora', 5);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel) values (9, 'Visual', 3);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel) values (11, 'Auditiva', 2);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel) values (14, 'Motora', 2);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel) values (18, 'Motora', 4);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel) values (24, 'Motora', 1);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel) values (29, 'Visual', 4);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel) values (33, 'Motora', 2);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel) values (36, 'Auditiva', 2);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel) values (39, 'Motora', 1);

-- Inser��es das modalidades esportivas
insert into MODALIDADE (id, descricao, olimpica) values (1, 'Soccer', 'S');
insert into MODALIDADE (id, descricao, olimpica) values (2, 'Volleyball', 'S');
insert into MODALIDADE (id, descricao, olimpica) values (3, 'Basketball', 'S');
insert into MODALIDADE (id, descricao, olimpica) values (4, 'Fight', 'S');
insert into MODALIDADE (id, descricao, olimpica) values (5, 'Hockey', 'S');
insert into MODALIDADE (id, descricao, olimpica) values (6, 'Swimming', 'S');
insert into MODALIDADE (id, descricao, olimpica) values (7, 'Cycling', 'S');
insert into MODALIDADE (id, descricao, olimpica) values (8, 'Fencing', 'S');
insert into MODALIDADE (id, descricao, olimpica) values (9, 'Running', 'S');
insert into MODALIDADE (id, descricao, olimpica) values (10, 'Gymnastics', 'S');
insert into MODALIDADE (id, descricao, olimpica) values (11, 'Cards', 'N');
insert into MODALIDADE (id, descricao, olimpica) values (12, 'Videogame', 'N');

-- Inser��es das pr�ticas
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (29, 5, to_date('23/03/2002','dd/mm/yyyy'), 18.6);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (22, 1, to_date('30/09/1991','dd/mm/yyyy'), 29.0);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (27, 11, to_date('04/05/1993','dd/mm/yyyy'), 27.4);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (31, 10, to_date('18/03/1991','dd/mm/yyyy'), 29.6);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (25, 10, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (30, 8, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (9, 9, to_date('28/07/2016','dd/mm/yyyy'), 4.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (34, 7, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (30, 2, to_date('11/08/1993','dd/mm/yyyy'), 27.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (20, 1, to_date('11/05/2008','dd/mm/yyyy'), 12.4);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (2, 4, to_date('13/02/1995','dd/mm/yyyy'), 25.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (35, 5, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (4, 12, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (25, 11, to_date('18/08/1995','dd/mm/yyyy'), 25.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (18, 9, to_date('27/07/2000','dd/mm/yyyy'), 20.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (37, 7, to_date('19/02/1993','dd/mm/yyyy'), 27.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (38, 4, to_date('27/12/2012','dd/mm/yyyy'), 7.8);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (4, 9, to_date('19/04/1991','dd/mm/yyyy'), 29.5);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (1, 9, to_date('30/03/1997','dd/mm/yyyy'), 23.5);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (17, 8, to_date('10/03/2002','dd/mm/yyyy'), 18.6);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (14, 4, to_date('18/03/1998','dd/mm/yyyy'), 22.6);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (26, 6, to_date('27/01/2007','dd/mm/yyyy'), 13.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (32, 9, to_date('06/10/2016','dd/mm/yyyy'), 4.0);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (1, 8, to_date('22/08/2002','dd/mm/yyyy'), 18.1);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (21, 11, to_date('23/12/1994','dd/mm/yyyy'), 25.8);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (11, 7, to_date('16/08/2003','dd/mm/yyyy'), 17.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (10, 10, to_date('05/06/1990','dd/mm/yyyy'), 30.4);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (21, 5, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (25, 9, to_date('25/11/1995','dd/mm/yyyy'), 24.9);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (4, 8, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (17, 4, to_date('05/09/2003','dd/mm/yyyy'), 17.1);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (14, 12, to_date('04/02/2006','dd/mm/yyyy'), 14.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (22, 9, to_date('12/07/1995','dd/mm/yyyy'), 25.3);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (37, 9, to_date('25/10/2017','dd/mm/yyyy'), 3.0);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (17, 7, to_date('03/04/2000','dd/mm/yyyy'), 20.5);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (8, 3, to_date('12/01/1998','dd/mm/yyyy'), 22.8);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (27, 6, to_date('13/08/2001','dd/mm/yyyy'), 19.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (17, 10, to_date('02/12/1997','dd/mm/yyyy'), 22.9);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (30, 12, to_date('28/04/2004','dd/mm/yyyy'), 16.5);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (8, 6, to_date('11/04/1993','dd/mm/yyyy'), 27.5);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (36, 4, to_date('01/12/1996','dd/mm/yyyy'), 23.9);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (16, 7, to_date('09/02/1991','dd/mm/yyyy'), 29.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (23, 3, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (17, 2, to_date('19/08/2001','dd/mm/yyyy'), 19.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (37, 5, to_date('13/09/1993','dd/mm/yyyy'), 27.1);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (26, 9, to_date('29/01/2000','dd/mm/yyyy'), 20.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (8, 1, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (7, 6, to_date('08/03/1990','dd/mm/yyyy'), 30.6);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (35, 8, to_date('11/03/2012','dd/mm/yyyy'), 8.6);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (10, 12, to_date('19/02/1995','dd/mm/yyyy'), 25.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (16, 4, to_date('20/06/2018','dd/mm/yyyy'), 2.3);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (7, 2, to_date('30/12/2009','dd/mm/yyyy'), 10.8);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (14, 6, to_date('05/06/1993','dd/mm/yyyy'), 27.4);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (30, 5, to_date('28/08/1994','dd/mm/yyyy'), 26.1);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (9, 2, to_date('16/11/2007','dd/mm/yyyy'), 12.9);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (10, 9, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (38, 1, to_date('22/11/2016','dd/mm/yyyy'), 3.9);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (35, 1, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (39, 4, to_date('22/07/2010','dd/mm/yyyy'), 10.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia) values (24, 4, to_date('14/05/1997','dd/mm/yyyy'), 23.4);

-- Inser��es dos campeonatos
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (1, 'Vipe Cup', 'Huolongping', to_date('09/10/2016','dd/mm/yyyy'), to_date('31/10/2016','dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (2, 'Vitz Championship', 'Kapotnya', to_date('12/02/2019','dd/mm/yyyy'), to_date('30/11/2019','dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (3, 'Youfeed Championship', 'Zeljezno Polje', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (4, 'Mynte Cup', 'Langxi', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (5, 'Skimia Cup', 'San Miguel', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (6, 'Npath Championship', 'Taibao', to_date('19/09/2015','dd/mm/yyyy'), to_date('26/09/2015','dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (7, 'Mydo Championship', 'Nova Lima', to_date('07/02/2015','dd/mm/yyyy'), to_date('07/03/2015','dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (8, 'Thoughtworks Tournament', 'Lengkongsari', to_date('09/05/2018','dd/mm/yyyy'), to_date('31/07/2018','dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (9, 'Lazzy Cup', 'Shanghudi', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (10, 'BlogXS Championship', 'Shinan', to_date('19/11/2013','dd/mm/yyyy'), to_date('21/11/2013','dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (11, 'Skipstorm Tournament', 'Sindou', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (12, 'Trilith Cup', 'Sebu', to_date('16/06/2020','dd/mm/yyyy'), to_date('20/06/2020','dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (13, 'Topicstorm Championship', 'Rawasan', to_date('17/03/2011','dd/mm/yyyy'), to_date('24/03/2011','dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (14, 'Quinu Cup', 'Zlotniki Kujawskie', to_date('03/09/2017','dd/mm/yyyy'), to_date('15/09/2017','dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (15, 'Youspan Tournament', 'Pahonjean', to_date('07/11/2017','dd/mm/yyyy'), to_date('20/12/2017','dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (16, 'Camido Championship', 'Masipi West', to_date('19/06/2017','dd/mm/yyyy'), to_date('24/06/2017','dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (17, 'Nlounge Cup', 'Sanying', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (18, 'Yombu Cup', 'Menara', to_date('28/03/2014','dd/mm/yyyy'), to_date('03/05/2014','dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (19, 'Skiptube Championship', 'Gaoping', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim) values (20, 'Browsecat Tournament', 'Tomakivka', to_date('13/05/2019','dd/mm/yyyy'), to_date('15/06/2019','dd/mm/yyyy'));

-- Inser��es dos esportes
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (87715634, 29, 5);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (33416420, 22, 1);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (86986384, 27, 11);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (11547175, 31, 10);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (95166144, 9, 9);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (62048185, 30, 2);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (98353043, 20, 1);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (28626679, 2, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (59911312, 37, 7);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (96196461, 38, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (56608784, 4, 9);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (53241057, 17, 8);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (37285072, 14, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (68327832, 1, 8);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (44528889, 21, 11);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (47362586, 25, 9);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (96395079, 10, 10);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (24731406, 17, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (17671679, 11, 7);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (57253633, 26, 6);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (78031632, 32, 9);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (63644507, 1, 8);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (91373515, 21, 11);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (75844070, 11, 7);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (88442722, 17, 2);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (26063016, 17, 7);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (91645641, 8, 3);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (28339718, 27, 6);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (45811774, 35, 8);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (48981675, 10, 12);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (69592247, 16, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (68685407, 14, 6);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (78173025, 10, 9);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (79043780, 38, 1);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (61056193, 35, 1);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (81655809, 39, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (25609911, 24, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (47090406, 9, 2);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (18546292, 35, 5);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade) values (95531262, 4, 12);

-- Inser��es das participa��es em campeonatos
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (87715634, 13, 6, 4407.8);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (33416420, 4, 16, 270.07);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (86986384, 11, 18, 350.31);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (11547175, 1, 15, 39618.25);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (95166144, 18, 25, 98.99);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (62048185, 6, 16, 2005.09);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (98353043, 2, 15, 170.56);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (28626679, 19, 22, 314.14);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (59911312, 4, 29, 14.87);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (96196461, 11, 5, 2506.61);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (56608784, 13, 10, 15511.94);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (87715634, 12, 20, 109.86);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (53241057, 13, 22, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (37285072, 17, 13, 270.44);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (33416420, 12, 19, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (68327832, 9, 30, 191.64);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (44528889, 12, 9, 465.57);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (47362586, 13, 7, 906.08);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (96395079, 13, 11, 86.92);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (62048185, 7, 21, 107.6);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (24731406, 7, 22, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (17671679, 5, 30, 37.57);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (57253633, 4, 2, 2331.09);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (78031632, 5, 24, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (63644507, 8, 1, 70224.88);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (98353043, 18, 16, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (91373515, 2, 2, 10261.26);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (28626679, 11, 3, 16243.92);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (75844070, 9, 1, 29506.26);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (86986384, 6, 24, 76.42);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (88442722, 6, 29, 8.14);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (96196461, 3, 22, 239.66);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (62048185, 19, 1, 35869.31);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (95166144, 11, 5, 4085.82);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (26063016, 19, 2, 18760.85);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (96395079, 9, 8, 1629.99);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (91645641, 10, 19, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (86986384, 8, 13, 167.56);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (53241057, 18, 21, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (37285072, 5, 16, 262.87);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (57253633, 3, 5, 2165.82);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (28339718, 10, 7, 1474.87);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (45811774, 10, 15, 227.4);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (48981675, 14, 1, 74397.52);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (69592247, 11, 23, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (68685407, 9, 2, 30752.48);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (44528889, 17, 20, 81.41);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (78173025, 19, 10, 692.19);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (79043780, 10, 2, 6065.36);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (95166144, 16, 19, 620.1);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (61056193, 2, 14, 272.75);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (81655809, 10, 1, 14597.76);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (25609911, 18, 5, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (61056193, 20, 3, 6428.57);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (37285072, 12, 17, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (78173025, 17, 20, 926.2);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (62048185, 4, 20, 727.44);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (48981675, 19, 3, 22099.41);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (91373515, 14, 28, 143.31);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao) values (57253633, 5, 6, 1736.93);

-- Inser��es dos centros de treinamento
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (17, 1, '(203) 8852807', 'Forest Run', '360', 'Center', '06726', 'Waterbury', 'CT');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (25, 2, '(518) 1705042', 'Elmside', '843', 'Plaza', '12242', 'Albany', 'NY');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (17, 3, '(713) 7019153', 'Kings', '4', 'Circle', '77045', 'Houston', 'TX');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (24, 4, '(203) 1509611', 'International', '106', 'Avenue', '06816', 'Danbury', 'CT');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (29, 5, '(786) 8411691', 'Dexter', '092', 'Park', '33134', 'Miami', 'FL');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (21, 6, '(434) 3343181', 'Debra', '20896', 'Terrace', '27705', 'Durham', 'NC');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (29, 7, '(412) 2100712', 'Graceland', '0093', 'Avenue', '15215', 'Pittsburgh', 'PA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (4, 8, '(808) 3236645', 'Hayes', '870', 'Hill', '96815', 'Honolulu', 'HI');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (15, 9, '(917) 1765373', 'Knutson', '1', 'Lane', '10280', 'New York City', 'NY');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (18, 10, '(412) 7739903', 'Waywood', '223', 'Circle', '15250', 'Pittsburgh', 'PA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (7, 11, '(406) 1340148', 'Arizona', '1773', 'Road', '59806', 'Missoula', 'MT');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (11, 12, '(937) 1593587', 'Lillian', '6', 'Hill', '45414', 'Dayton', 'OH');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (15, 13, '(469) 5734653', 'Westerfield', '07111', 'Parkway', '75342', 'Dallas', 'TX');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (6, 14, '(404) 5859229', 'Brentwood', '917', 'Court', '30336', 'Atlanta', 'GA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (10, 15, '(414) 7746157', 'Hoepker', '04', 'Drive', '53205', 'Milwaukee', 'WI');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (8, 16, '(213) 9957974', 'Bluejay', '5', 'Crossing', '90025', 'Los Angeles', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (1, 17, '(303) 5974224', 'Alpine', '580', 'Hill', '80127', 'Littleton', 'CO');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (12, 18, '(626) 5855274', 'Jenna', '4', 'Circle', '91199', 'Pasadena', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (21, 19, '(571) 3492863', 'Stephen', '45344', 'Street', '22093', 'Ashburn', 'VA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (16, 20, '(713) 7112184', 'Columbus', '675', 'Drive', '77035', 'Houston', 'TX');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (19, 21, '(410) 3538543', 'Calypso', '6132', 'Pass', '21216', 'Baltimore', 'MD');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (26, 22, '(714) 7586665', 'Jana', '18739', 'Court', '92812', 'Anaheim', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (12, 23, '(253) 1156055', 'Moulton', '0976', 'Hill', '98166', 'Seattle', 'WA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (10, 24, '(832) 3039011', 'Boyd', '12352', 'Terrace', '77201', 'Houston', 'TX');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (29, 25, '(951) 5257547', 'Sommers', '94', 'Hill', '92878', 'Corona', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (3, 26, '(754) 7559434', 'Hagan', '39245', 'Junction', '33336', 'Fort Lauderdale', 'FL');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (9, 27, '(205) 1247664', 'Mayer', '02', 'Hill', '35487', 'Tuscaloosa', 'AL');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (12, 28, '(334) 8729842', 'Rutledge', '52082', 'Drive', '36134', 'Montgomery', 'AL');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (25, 29, '(803) 7932508', 'Johnson', '02961', 'Parkway', '29225', 'Columbia', 'SC');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (24, 30, '(510) 7973790', 'Dixon', '7', 'Crossing', '94622', 'Oakland', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (7, 31, '(775) 9934404', 'Buena Vista', '261', 'Street', '89595', 'Reno', 'NV');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (12, 32, '(212) 1827738', 'Cardinal', '4447', 'Pass', '11254', 'Brooklyn', 'NY');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (12, 33, '(310) 3485729', 'Sunbrook', '0567', 'Point', '90805', 'Long Beach', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (13, 34, '(434) 8733507', 'Spohn', '161', 'Center', '22111', 'Manassas', 'VA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (16, 35, '(402) 3060768', 'Blaine', '39', 'Place', '68124', 'Omaha', 'NE');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (23, 36, '(314) 7800399', 'Sunfield', '0890', 'Circle', '63167', 'Saint Louis', 'MO');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (30, 37, '(774) 6028432', 'Drewry', '55', 'Drive', '01610', 'Worcester', 'MA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (27, 38, '(225) 7049300', 'Jay', '2311', 'Circle', '70820', 'Baton Rouge', 'LA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (23, 39, '(212) 5469699', 'Dapin', '075', 'Junction', '10131', 'New York City', 'NY');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (11, 40, '(504) 9639309', 'Ryan', '61518', 'Road', '70142', 'New Orleans', 'LA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (24, 41, '(617) 7482347', 'Lawn', '00825', 'Crossing', '02208', 'Boston', 'MA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (2, 42, '(701) 1337802', 'Arizona', '15586', 'Center', '58122', 'Fargo', 'ND');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (18, 43, '(202) 3571515', 'Badeau', '76', 'Circle', '20088', 'Washington', 'DC');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (19, 44, '(602) 7233920', 'Express', '6507', 'Alley', '85010', 'Phoenix', 'AZ');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (6, 45, '(215) 2518875', 'Farmco', '9964', 'Point', '19172', 'Philadelphia', 'PA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (19, 46, '(417) 2791827', 'Marcy', '1', 'Lane', '65810', 'Springfield', 'MO');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (13, 47, '(619) 9955921', 'Rutledge', '39', 'Trail', '92153', 'San Diego', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (11, 48, '(763) 7567922', 'Bluestem', '212', 'Place', '55598', 'Loretto', 'MN');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (4, 49, '(907) 4629296', 'Northfield', '86725', 'Crossing', '99512', 'Anchorage', 'AK');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (27, 50, '(325) 4359571', 'Texas', '97946', 'Center', '79699', 'Abilene', 'TX');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (20, 51, '(502) 1917772', 'Vidon', '18626', 'Road', '40618', 'Frankfort', 'KY');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (7, 52, '(408) 6747243', 'Hoffman', '6', 'Center', '95123', 'San Jose', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (1, 53, '(208) 2292372', 'Blue Bill Park', '8', 'Drive', '83716', 'Boise', 'ID');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (14, 54, '(903) 6070958', 'Spaight', '54', 'Drive', '75705', 'Tyler', 'TX');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (29, 55, '(714) 6899483', 'Fieldstone', '460', 'Center', '92725', 'Santa Ana', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (10, 56, '(559) 9332511', 'Oxford', '19', 'Circle', '93740', 'Fresno', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (30, 57, '(412) 9936053', 'Porter', '7', 'Point', '15134', 'Mc Keesport', 'PA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (12, 58, '(706) 6696603', 'Rowland', '1', 'Trail', '30919', 'Augusta', 'GA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (5, 59, '(404) 9864853', 'Petterle', '3', 'Point', '30343', 'Atlanta', 'GA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF) values (13, 60, '(469) 7153460', 'Onsgard', '3', 'Lane', '75342', 'Dallas', 'TX');

/*************************************************
*** Elimina��o das tabelas (quando necess�rio) ***
*************************************************/
/*
drop table centro_treinamento;
drop table pratica;
drop table participa;
drop table campeonato;
drop table esporte;
drop table modalidade;
drop table olimpico;
drop table paraolimpico;
drop table atleta_contato;
drop table atleta;
drop table clube;
drop table presidente; 
*/