-- Comandos SYSTEM:
alter session set "_ORACLE_SCRIPT"=true;
create user gabrieljayme identified by gabrieljayme;
create role desenvolvedor;
grant
    create any table,
    insert any table,
    select any table,
    update any table,
    create any sequence,
    create any view to desenvolvedor;
grant desenvolvedor to gabrieljayme;
alter user gabrieljayme quota unlimited on users;