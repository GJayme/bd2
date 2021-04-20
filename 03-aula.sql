-- 4. Liste o registro do atleta, seu nome, a descrição da modalidade que 
-- disputa e a melhor colocação dele em um campeonato;

DESC atleta;
DESC participa;
DESC modalidade;
DESC esporte;

select e.registro_atleta, a.nome, m.descricao, min(p.colocacao) 
   from esporte e join atleta a on e.id_atleta = a.id
   join modalidade m on e.id_modalidade = m.id
   join participa p on p.registro_atleta = e.registro_atleta
  group by e.registro_atleta, a.nome, m.descricao
  order by 1, 4;
  
-- Listar cpf, nome e salário dos atletlas que ganham mais que "Hoyt Hawker"
select cpf, nome, salario
   from atleta
  where salario > (select salario from atleta where nome = 'Hoyt Hawker');
  
-- Listar cpf, nome e salário dos atletlas que ganham mais que "Pernell Boorer" e "Yale Buttle"
-- ALL ele deve cumprir a comparação do sub select
-- ANY ele retornar se pelo menos uma das comparações forem cumpridas do sub select
select cpf, nome, salario
   from atleta
  where salario > ALL (select salario from atleta 
                       where nome in ('Pernell Boorer', 'Yale Buttle'));
                       
-- Lista nome e endereço dos atletas que trabalham aos clubes "Tresom Club" ou
-- "Zamit Team"
select nome, endereco from atleta
   where id_clube IN (select id from clube where nome in ('Tresom Club', 'Zamit Team'));
   
-- Listar o nome dos presidentes que NÃO pertencem a Alpha Team, Temp Club ou Monster Team
-- nvl ele substitui algum valor que seria nullo pra algum valor
select nome from presidente
   where id not in (select nvl(id_presidente, -99) from clube
                     where nome in ('Alpha Team', 'Temp Club', 'Monster Team'));
                     
select nome from presidente
   where id not in (select id_presidente from clube
                     where nome in ('Alpha Team', 'Temp Club', 'Monster Team')
                       and id_presidente is not null);
                       
-- Exists / Not exists
-- Listar nome dos atletas que praticam alguma modalidade esportiva
select nome from atleta
   where id in (select id_atleta from pratica);
                       
select nome from atleta a
   where exists (select 1 from pratica p where p.id_atleta = a.id);
   
select nome from atleta
   where id not in (select id_atleta from pratica where id_atleta is not null);
   
select nome from atleta a
   where not exists (select 1 from pratica p where p.id_atleta = a.id);
   
-- UNION: ele não mostra as repetições, UNION ALL: ele traz tudo, inclusive as repetições.
select id_atleta from olimpico
UNION
select id_atleta from paraolimpico;

-- INTERSECT: traz o que encontrar tanto do primeiro select quanto do segundo.
select registro_atleta from esporte
INTERSECT
select registro_atleta from participa;

-- MINUS: ele pega os resultados do primeiro select menos os resultados do segundo select
select registro_atleta from esporte
MINUS
select registro_atleta from participa;

-- 7. Mostre o nome, salário e data de nascimento dos atletas que pertencem ao clube "Tamplight Club"
select nome, salario, datanasc from atleta 
   where id_clube = (select id from clube where nome = 'Tamplight Club');

-- 8. Liste o id, o nome, o total de atletas e a média salaria dos clubes presiditos por 
-- "Diana Leamon", "Billie Dargavel" ou "Shantee Jouhning";
select c.id, c.nome, count(*), round(avg(a.salario),2) Media_sal
   from clube c join atleta a on c.id = a.id_clube
  where c.id_presidente in (select id from presidente
                              where nome in ('Diana Leamon', 'Billie Dargavel', 'Shantee Jouhning'))
                              group by c.id, c.nome;
-- 9. Liste o id o nome das modalidades esportivas que possuem mais de 2 atletas que a praticam;
select m.id, m.descricao, count(*)
   from modalidade m join pratica p on p.id_modalidade = m.id
  group by m.id, m.descricao
  having count(*) > 2;

-- 10. Liste o nome e salário dos atletas de "Soccer" que ganham mais do que os atletas de "Volleyball" e de "Basketball".
select a.nome, a.salario
   from atleta a join pratica p on p.id_atleta = a.id
   join modalidade m on p.id_modalidade = m.id
    and m.descricao = 'Socce'
  where a.salario > ALL (select a.salario
                           from atleta a join pratica p on p.id_atleta = a.id
                           join modalidade m on p.id_modalidade = m.id
                            and m.descricao in ('Volleyball', 'Basketball'));

-- 11. Liste o nome dos atletas que já receberam algum valor de premiação em qualquer campeonato;
select a.nome
   from atleta a
  where exists (select 1 from esporte e
                 where e.id_atleta = a.id
                   and exists (select 1 from participa p
                                where p.registro_atleta = e.registro_atleta
                                  and p.valor_premiacao is not null));

-- 12. Liste a descrição da modalidade, o nome do atleta e a data de nascimento do atleta mais velho que
-- pratica a modalidade.
select m.descricao, a.nome, a.datanasc
   from atleta a, pratica p, modalidade m
  where a.id = p.id_atleta
    and m.id = p.id_modalidade
    and a.datanasc = (select min(datanasc)
                        from atleta a1, pratica p1, modalidade m1
                       where a1.id = p1.id_atleta
                         and m1.id = p1.id_modalidade
                         and m1.id = m.id);