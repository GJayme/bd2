-- 07/06

create or replace procedure pr_testex(
    p1 in number,
    p2 in date default sysdate
) is
    v_salario atleta.salario%type;
begin
    select salario into v_salario from ATLETA where id = p1;
    DBMS_OUTPUT.PUT_LINE(v_salario);
exception
    when no_data_found then
        DBMS_OUTPUT.PUT_LINE('');
    when too_many_rows then
        DBMS_OUTPUT.PUT_LINE('');
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlerrm);
end pr_testex;

call pr_testex(1);

-- function
create or replace function fr_textex(
    p1 in number,
    p2 in date default sysdate
) return number is
    v_salario atleta.salario%type;
begin
    select salario into v_salario from ATLETA where id = p1;
    return v_salario;
end fr_textex;

select id, FR_TEXTEX(id) from ATLETA;