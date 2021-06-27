-- Comandos SYSTEM:
alter session set "_ORACLE_SCRIPT"=true;
create user gabrieljayme identified by gabrieljayme;
create role desenvolvedor;
grant
    create session,
    create any table,
    insert any table,
    select any table,
    update any table,
    create any sequence,
    create any materialized view,
    create any view,
    create any procedure,
    create any trigger,
    create any index to desenvolvedor;
grant desenvolvedor to gabrieljayme;
alter user gabrieljayme quota unlimited on users;

-- Segundo usuário:
create user usuario identified by usuario;
grant create session to usuario;
grant select on GABRIELJAYME.PESSOA to usuario;
grant select on gabrieljayme.ALUNO to usuario;
grant select on gabrieljayme.INSTRUTOR to usuario;
grant select on gabrieljayme.AVALIACAO_FISICA to usuario;
grant select on gabrieljayme.TREINO to usuario;
grant select on gabrieljayme.EXERCICIO to usuario;
grant select on gabrieljayme.ALUNO_TREINO to usuario;
grant select on gabrieljayme.TREINO_EXERCICIO to usuario;
grant insert, update, delete on gabrieljayme.EXERCICIO to usuario;
grant insert, update, delete on gabrieljayme.PESSOA to usuario;
grant select, alter on gabrieljayme.EXERCICIO_SEQUENCE to usuario;
grant select on gabrieljayme.V_TODOS_ALUNOS to usuario;
grant select on gabrieljayme.V_TODOS_INSTRUTORES to usuario;
grant select on gabrieljayme.V_TODOS_TREINOS_EXERCICIOS to usuario;
revoke delete on gabrieljayme.EXERCICIO from usuario;
revoke delete on gabrieljayme.PESSOA from usuario;