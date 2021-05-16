-- Comando GABRIELJAYME:
-- Criação da Sequence do Projeto:
create sequence avaliacao_fisica_sequence increment by 1 start with 1 maxvalue 9999 nocycle nocache;
create sequence treino_sequence increment by 1 start with 1 maxvalue 9999 nocycle nocache;
create sequence exercicio_sequence increment by 1 start with 1 maxvalue 9999 nocycle nocache;

-- Criação das tabelas:
create table pessoa (
    cpf             varchar2(11) not null,
    nome            varchar2(50) not null,
    sexo            char(1),
    dt_nascimento   date,
    telefone        varchar2(11),
    constraint pessoa_pk primary key (cpf),
    constraint pessoa_sexo_check check (sexo in ('M','F','m','f'))
);

create table instrutor (
    cpf             varchar2(11) not null,
    salario         number(8,2) not null,
    cref            varchar2(11) not null,
    rua             varchar2(60) not null,
    numero          number(6) not null,
    cep             varchar2(8) not null,
    constraint instrutor_pk primary key(cpf),
    constraint instrutor_pessoa_cpf_fk foreign key (cpf) references pessoa(cpf)
);

create table aluno (
    cpf                     varchar2(11) not null,
    status_mensalidade      char(1) not null,
    vencimento_mensalidade  date not null,
    valor_mensalidade       number(8,2) not null,
    constraint aluno_pk primary key(cpf),
    constraint aluno_pessoa_cpf_fk foreign key (cpf) references pessoa(cpf),
    constraint status_mensalidade_check check ( status_mensalidade in ('P','N','p','n'))
);

create table avaliacao_fisica(
    id                      number(4) not null,
    cpf_aluno               varchar2(11) not null,
    peso                    number(5,2) not null,
    altura                  number(5,2) not null,
    porcentagem_gordura     number(4,2) not null,
    porcentagem_massa_magra number(4,2) not null,
    constraint avaliacao_pk primary key (id),
    constraint cpf_aluno_fk foreign key (cpf_aluno) references aluno(cpf)
);

create table treino(
    id              number(4) not null,
    cpf_instrutor   varchar2(11) not null,
    nome            varchar2(50) not null unique,
    tipo            char(13) not null,
    constraint treino_pk primary key (id),
    constraint cpf_instrutor_trieno foreign key (cpf_instrutor) references instrutor(cpf),
    constraint tipo_check check ( tipo in ('circuito','força','emagrecimento','agilidade','resistencia'))
);

create table exercicio(
    id              number(4) not null,
    grupo_muscular  varchar2(50) not null,
    nome            varchar2(50) not null unique,
    serie           number(2),
    repeticoes      number(2),
    tempo           number(2),
    constraint exercicio_pk primary key (id)
);

create table aluno_treino(
    cpf_aluno       varchar2(11) not null,
    id_treino       number(4) not null,
    constraint aluno_treino_cpf_aluno_fk foreign key (cpf_aluno) references aluno(cpf),
    constraint id_treino foreign key (id_treino) references treino(id),
    constraint aluno_treino_pk primary key (cpf_aluno, id_treino)
);

create table treino_exercicio(
    id_treino       number(4) not null,
    id_exercicio    number(4) not null,
    qtde_exercicio  number(10) not null,
    constraint treino_exercicio_id_treino_fk foreign key (id_treino) references treino(id),
    constraint id_exercicio_fk foreign key (id_exercicio) references exercicio(id),
    constraint treino_exercicio_pk primary key (id_treino, id_exercicio)
);

-- Insert das tabelas:
--Pessoa:
insert into pessoa(cpf, nome, sexo, dt_nascimento, telefone)
    values('11111111111', 'Gabriel Jayme', 'M', to_date('20/09/1991', 'dd/mm/yyyy'), '16994313951');
insert into pessoa(cpf, nome, sexo, dt_nascimento, telefone)
    values('22222222222', 'Leonardo Freitas', 'M', to_date('20/12/1997', 'dd/mm/yyyy'), '16814013920');
insert into pessoa(cpf, nome, sexo, dt_nascimento, telefone)
    values('33333333333', 'Charles Souza', 'M', to_date('31/10/1990', 'dd/mm/yyyy'), '16889131592');
insert into pessoa(cpf, nome, sexo, dt_nascimento, telefone)
    values('44444444444', 'Livia T', 'F', to_date('08/08/1992', 'dd/mm/yyyy'), '16894213823');
insert into pessoa(cpf, nome, sexo, dt_nascimento, telefone)
    values('55555555555', 'Laura Raura', 'F', to_date('15/02/1992', 'dd/mm/yyyy'), '16794323948');
insert into pessoa(cpf, nome, sexo, dt_nascimento, telefone)
    values('66666666666', 'Vinicius G', 'M', to_date('10/01/1989', 'dd/mm/yyyy'), '16926020940');
insert into pessoa(cpf, nome, sexo, dt_nascimento, telefone)
    values('77777777777', 'Vinicius M', 'M', to_date('18/11/1991', 'dd/mm/yyyy'), '16823121941');
insert into pessoa(cpf, nome, sexo, dt_nascimento, telefone)
    values('88888888888', 'Maria C Rodrigues', 'F', to_date('22/06/1985', 'dd/mm/yyyy'), '19923921237');
insert into pessoa(cpf, nome, sexo, dt_nascimento, telefone)
    values('99999999999', 'Pedro P', 'M', to_date('31/10/1980', 'dd/mm/yyyy'), '1988921231');

--Aluno:
insert into aluno(cpf, status_mensalidade, vencimento_mensalidade, valor_mensalidade)
    values ('11111111111', 'P', to_date('15/06/2021', 'dd/mm/yyyy'), 60);
insert into aluno(cpf, status_mensalidade, vencimento_mensalidade, valor_mensalidade)
    values ('22222222222', 'P', to_date('18/06/2021', 'dd/mm/yyyy'), 80);
insert into aluno(cpf, status_mensalidade, vencimento_mensalidade, valor_mensalidade)
    values ('33333333333', 'N', to_date('15/05/2021', 'dd/mm/yyyy'), 70);
insert into aluno(cpf, status_mensalidade, vencimento_mensalidade, valor_mensalidade)
    values ('66666666666', 'P', to_date('14/06/2021', 'dd/mm/yyyy'), 80);
insert into aluno(cpf, status_mensalidade, vencimento_mensalidade, valor_mensalidade)
    values ('77777777777', 'P', to_date('10/06/2021', 'dd/mm/yyyy'), 80);
insert into aluno(cpf, status_mensalidade, vencimento_mensalidade, valor_mensalidade)
    values ('88888888888', 'P', to_date('20/06/2021', 'dd/mm/yyyy'), 95);

--Instrutor:
insert into instrutor(cpf, salario, cref, rua, numero, cep)
    values ('44444444444', 2500, '142974-G/SP', 'Sem fim', 666, '14146029');
insert into instrutor(cpf, salario, cref, rua, numero, cep)
    values ('55555555555', 2300, '218051-F/SP', 'Rita Candida', 28, '18156122');
insert into instrutor(cpf, salario, cref, rua, numero, cep)
    values ('99999999999', 2200, '119090-H/SP', 'Rua Larga', 2020, '12126899');

--Avaliação Física:
insert into avaliacao_fisica(id, cpf_aluno, peso, altura, porcentagem_gordura, porcentagem_massa_magra)
    values (avaliacao_fisica_sequence.nextval, '11111111111', 64, 174.5, 15, 60);
insert into avaliacao_fisica(id, cpf_aluno, peso, altura, porcentagem_gordura, porcentagem_massa_magra)
    values (avaliacao_fisica_sequence.nextval, '22222222222', 70, 167.0, 20, 60);
insert into avaliacao_fisica(id, cpf_aluno, peso, altura, porcentagem_gordura, porcentagem_massa_magra)
    values (avaliacao_fisica_sequence.nextval, '33333333333', 90, 165.0, 40, 55);
insert into avaliacao_fisica(id, cpf_aluno, peso, altura, porcentagem_gordura, porcentagem_massa_magra)
    values (avaliacao_fisica_sequence.nextval, '66666666666', 105, 173.5, 50, 45);
insert into avaliacao_fisica(id, cpf_aluno, peso, altura, porcentagem_gordura, porcentagem_massa_magra)
    values (avaliacao_fisica_sequence.nextval, '77777777777', 55, 175.5, 10, 50);
insert into avaliacao_fisica(id, cpf_aluno, peso, altura, porcentagem_gordura, porcentagem_massa_magra)
    values (avaliacao_fisica_sequence.nextval, '88888888888', 75, 175.5, 20, 55);

-- Treino:
insert into treino(id, cpf_instrutor, nome, tipo)
    values (treino_sequence.nextval, '44444444444', 'Adaptação V1', 'resistencia');
insert into treino(id, cpf_instrutor, nome, tipo)
    values (treino_sequence.nextval, '55555555555', 'Força iniciante V1', 'força');
insert into treino(id, cpf_instrutor, nome, tipo)
    values (treino_sequence.nextval, '44444444444', 'Agilidade iniciante V1', 'agilidade');
insert into treino(id, cpf_instrutor, nome, tipo)
    values (treino_sequence.nextval, '55555555555', 'Emagrecimento intermediário V3', 'emagrecimento');
insert into treino(id, cpf_instrutor, nome, tipo)
    values (treino_sequence.nextval, '44444444444', 'Emagrecimento iniciante V2', 'emagrecimento');
insert into treino(id, cpf_instrutor, nome, tipo)
    values (treino_sequence.nextval, '44444444444', 'Resistencia V2', 'resistencia');

--Exercicio:
insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (exercicio_sequence.nextval, 'Peitoral', 'Supino reto', 5, 10);
insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (exercicio_sequence.nextval, 'Peitoral', 'Supino Inclinado', 5, 10);
insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (exercicio_sequence.nextval, 'Peitoral', 'Crucifixo', 5, 10);
insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (exercicio_sequence.nextval, 'Triceps', 'Rosca Invertida', 5, 10);
insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (exercicio_sequence.nextval, 'Triceps', 'Corda', 5, 10);
insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (exercicio_sequence.nextval, 'Triceps', 'Corda Testa', 5, 10);
insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (exercicio_sequence.nextval, 'Perna', 'Leg Press', 5, 10);
insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (exercicio_sequence.nextval, 'Perna', 'Panturrilha', 5, 10);
insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (exercicio_sequence.nextval, 'Perna', 'Extensor', 5, 10);
insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (exercicio_sequence.nextval, 'Biceps', 'Rosca direta', 5, 10);
insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (exercicio_sequence.nextval, 'Biceps', 'Rosca Anternada', 5, 10);
insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (exercicio_sequence.nextval, 'Biceps', 'Antebraço', 5, 10);
insert into exercicio(id, grupo_muscular, nome, tempo)
    values (exercicio_sequence.nextval, 'Cardio', 'Esteira', 60);
insert into exercicio(id, grupo_muscular, nome, tempo)
    values (exercicio_sequence.nextval, 'Cardio', 'Bike', 60);

--Aluno_treino:
insert into aluno_treino(cpf_aluno, id_treino)
    values ('11111111111', 1);
insert into aluno_treino(cpf_aluno, id_treino)
    values ('22222222222', 2);
insert into aluno_treino(cpf_aluno, id_treino)
    values ('33333333333', 3);
insert into aluno_treino(cpf_aluno, id_treino)
    values ('66666666666', 4);
insert into aluno_treino(cpf_aluno, id_treino)
    values ('77777777777', 5);
insert into aluno_treino(cpf_aluno, id_treino)
    values ('88888888888', 6);

--Treino_exercicio:
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (1, 1, 6);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (1, 2, 6);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (1, 3, 6);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (1, 4, 6);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (1, 5, 6);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (1, 6, 6);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (2, 7, 5);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (2, 8, 5);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (2, 9, 5);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (2, 13, 5);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (2, 10, 5);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (3, 13, 4);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (3, 7, 4);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (3, 9, 4);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (3, 5, 4);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (4, 13, 2);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (4, 14, 4);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (5, 13, 1);
insert into treino_exercicio(id_treino, id_exercicio, qtde_exercicio)
    values (6, 14, 1);

-- Visões:
--View para listar todos os Alunos:
create view v_todos_alunos(aluno) as
    select p.nome from aluno
        join pessoa p on aluno.cpf = p.cpf;

--View para listar todos os Instrutores:
create view v_todos_instrutores(instrutor) as
    select p.nome from instrutor
        join pessoa p on instrutor.cpf = p.cpf;

--View para listar todos os Treinos com seus Exercícios:
create view v_todos_treinos_exercicios(id_treino, nome_treino, nome_exercicio) as
    select t.id, t.nome, e.nome from treino_exercicio te, treino t, exercicio e
    where te.id_treino = t.id and te.id_exercicio = e.id
    order by id_treino;

--View Materializada:
create materialized view mensalidade_total_alunos_mes_06_2021
    build deferred
    refresh complete
    on demand
    as select sum(valor_mensalidade) total_mensalidade from aluno
        where vencimento_mensalidade >= to_date('01/06/2021', 'dd/mm/yyyy')
                  and vencimento_mensalidade <= to_date('30/06/2021', 'dd/mm/yyyy');

-- 8 SELECT:
-- 1. Listar todos os exercicios do treino do aluno Gabriel Jayme:
select e.nome from aluno_treino at
    join treino t on at.id_treino = t.id
    join treino_exercicio te on t.id = te.id_treino
    join exercicio e on te.id_exercicio = e.id
    join pessoa p on at.cpf_aluno = p.cpf
    where p.NOME = 'Gabriel Jayme';

-- 2. Listar os exercícios do treino Emagrecimento intermediário V3:
select e.nome from treino t
    join treino_exercicio te on t.id = te.id_treino
    join exercicio e on e.id = te.id_exercicio
    where t.NOME = 'Emagrecimento intermediário V3';

-- 3. Listar o nome das mulheres que frequentam o estudio e são instrutoras:
select p.nome from instrutor i, pessoa p
    where i.cpf = p.cpf and p.SEXO = 'F';

-- 4. Listar todos os nomes dos alunos que apresentam 40 ou mais porcentagem de gordura:
select p.nome from aluno a
    join avaliacao_fisica af on af.cpf_aluno = a.cpf
    join pessoa p on a.cpf = p.cpf
    where af.porcentagem_gordura >= 40;

-- 5. Qual média da mensalidade cobrada no Estudio:
select round(avg(valor_mensalidade)) media_mensalidade from aluno;

-- 6. Quantos alunos do sexo masculino e do sexo feminino frequentam o estudio:
select p.sexo, count(*) from aluno
    join pessoa p on aluno.cpf = p.cpf
    group by p.SEXO;

-- 7. Qual a média salarial dos Instrutores do Estudio separado por sexo:
select p.sexo, round(avg(salario)) media_salaria from instrutor
    join pessoa p on instrutor.cpf = p.cpf
    group by p.sexo;

-- 8. Listar todos os exercícios cadastrados ordenados pelo grupo muscular:
select grupo_muscular, nome from exercicio order by exercicio.grupo_muscular;