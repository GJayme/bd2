-- Comando Usuário:
--Inserir ao menos uma linha em cada tabela que pode dar insert:
insert into GABRIELJAYME.pessoa(cpf, nome, sexo, dt_nascimento, telefone)
    values('19191919191', 'Lara J', 'F', to_date('20/10/1999', 'dd/mm/yyyy'), '1686621626');

insert into exercicio(id, grupo_muscular, nome, serie, repeticoes)
    values (GABRIELJAYME.EXERCICIO_SEQUENCE.nextval, 'Biceps', 'Rosca Martelo', 5, 10);

-- Consulta de dados:

select * from GABRIELJAYME.V_TODOS_TREINOS_EXERCICIOS;
select * from GABRIELJAYME.EXERCICIO;
select * from GABRIELJAYME.PESSOA;