-- Funções: toda função tem que retornar algo.
-- é possível utilizar o create or replace
create function fu_area_circulo(
    p_raio in number
) return number is
    v_pi number := 3.1415926;
    v_area number;
begin
    v_area := v_pi * (p_raio*p_raio);
    return v_area;
end fu_area_circulo;

select fu_area_circulo(4.5) from DUAL;

create function fu_media_sal_clube(
    p_clube atleta.id_clube%type
) return number as
    v_media number;
begin
    select avg(salario) into v_media from atleta where ID_CLUBE = p_clube;
    return v_media;
end fu_media_sal_clube;

select id, nome, round(fu_media_sal_clube(id),2) as media_sal_atletas from CLUBE where id = 5;
select id, nome, round(fu_media_sal_clube(id),2) as media_sal_atletas from CLUBE;