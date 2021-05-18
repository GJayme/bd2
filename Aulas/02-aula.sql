-- Script aula 2: DQL
desc atleta;
select * from atleta;
select * from clube;
select * from presidente;
select * from olimpico;
select * from paraolimpico;

select nome, sexo from atleta where nome like '%o';
select nome, salario from atleta where salario between 15000 and 25000;
select cpf, nome from atleta where id_clube is null order by nome;
select id, nome, salario from atleta where salario < 10000 order by salario desc;
select lower(nome), upper(nome), initcap(endereco) from atleta;

desc clube;
select concat(concat(nome, ', '), data_fundacao) as nome_fundacao from clube;
select nome || ', ' || data_fundacao as nome_fundacao from clube;
select substr(nome,1,5) from atleta;
select substr(nome, -3, 2) from atleta;
select substr(nome, -3) from atleta;
select length(nome) from atleta;
select salario, round(salario,1), trunc(salario,1) from atleta;

select replace(nome, 'e', 'i') from clube;
select replace(replace(replace(nome, 'a', 'o'), 'e', 'u'), 'i', 'y') from clube;
select translate(nome, 'aei', 'ouy') from clube;
select replace(nome, 'Lawry', 'A') from atleta;
select trim(nome) from atleta where trim(nome) = 'Fabio';
select coalesce(sexo, 'N/D') from atleta;
select nvl(sexo, 'N/D') from atleta;

select nome, salario,
  case when salario > 50000 then salario*0.3
       when salario > 25000 then salario*0.2
       when salario > 5000  then salario*0.1
       else 0
  end imposto
  from atleta;
  
select nome, sexo,
  case sexo 
       when 'M' then 'Masculino'
       when 'F' then 'Feminino'
       else 'N/D'
  end sexo
  from atleta;
  
select nome, decode(sexo, 'M', 'Masculino', 'F', 'Feminino', 'N/D') as sexo 
  from atleta;
  
select sysdate from dual;
select to_char(sysdate, 'dd/mm/yyyy hh:mi am') data_atual from dual;
select to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') data_atual from dual;
select to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss') data_atual from dual;
select to_char(sysdate, 'dd month yyyy hh24:mi:ss') data_atual from dual;
select to_char(sysdate, 'dd mon yyyy hh24:mi:ss') data_atual from dual;
select to_char(sysdate, 'dy dd mon yyyy hh24:mi:ss') data_atual from dual;
select to_char(sysdate, 'dy dd "de" month "de" yyyy hh24:mi:ss') data_atual from dual;

select to_char(salario, '999990.00')as salario from atleta;
select to_char(salario, '$999,990.00')as salario from atleta;

-- Funções de Agrupamento:
select max(salario), min(salario) from atleta;
select to_char(sum(salario), '9,999,990.00') folha_sal from atleta;
select avg(salario) from atleta;
select count(*) from atleta;
select count(id_clube) from atleta; -- a diferença desse para o count é que esse não considera valores nulos
select count(*) from atleta where id_clube = 1;

select id_clube, max(salario)
   from atleta
  group by id_clube
  order by id_clube;
  
select id_clube, sexo, round(max(salario),2)
   from atleta
  group by id_clube, sexo
  order by 1, 2;

select id_clube, round(avg(salario),2)
   from atleta
  group by id_clube
having avg(salario) > 5000
  order by 1;

-- 1. Liste o valor total de premiação distribuída no campeonato de id 19:
desc pratica;

select sum(valor_premiacao) total_premio
  from participa where id_campeonato = 19;
  
-- 2. Encontre a quantidade de atletas que pratica cada modalidade esportiva:
select id_modalidade, count(id_atleta) as qtd_atletas
   from pratica
  group by id_modalidade
  order by 1;
  
-- 3. Liste o id do campeonato e a quantitade de atletas que participam deles,
-- exibindo somento os campeonatos com mais de 3 participantes. Ordene os
-- resultados por quantidade de participantes decrescente:
desc participa;

select id_campeonato, count(*) as qtd_atletas
   from participa
  group by id_campeonato
 having count(*) > 3
  order by qtd_atletas desc;


-- Junções:
select atleta.nome, clube.nome 
   from atleta inner join clube
     on atleta.id_clube = clube.id;

select a.nome, c.nome 
   from atleta a join clube c
     on a.id_clube = c.id;

select a.nome, c.nome 
   from atleta a, clube c
     where a.id_clube = c.id;
     
desc olimpico;
desc paraolimpico;
desc atleta;

-- Listar o nome dos atletas olimpicos e se eles tem ou não incentivo do governo:
select a.nome, o.incentivo_governo
   from atleta a join olimpico o
    on a.id = o.id_atleta;
    
select a.nome, o.incentivo_governo
   from atleta a join olimpico o
    on a.id = o.id_atleta
        and a.id_clube in (24,29);

select a.id_clube ,a.nome, o.incentivo_governo
   from atleta a, olimpico o
  where a.id = o.id_atleta
   and a.id_clube in (24,29);
        
select c.nome ,a.nome, o.incentivo_governo
   from atleta a join olimpico o
     on o.id_atleta = a.id
   join clube c on a.id_clube = c.id
    and a.id_clube in (24,29);
    
-- Outer Join
-- left outer join considera os nulos da tabela da esquerda do join
select a.nome, c.nome 
   from atleta a left outer join clube c
     on a.id_clube = c.id;

-- outra forma de dar left outer join
select a.nome, c.nome 
   from atleta a join clube c
     on a.id_clube = c.id (+); 
     
-- rigth considera os nulos da tabela da direita
select a.nome, c.nome 
   from atleta a right outer join clube c
     on a.id_clube = c.id;
     
select a.nome, c.nome 
   from atleta a join clube c
     on a.id_clube (+) = c.id;
     
-- Full outer joint: traz as seleçoes tanto do left quanto do right
select a.nome, c.nome 
   from atleta a full outer join clube c
     on a.id_clube = c.id;
     
-- Liste os ids e descrições das modalidades e os nomes dos atletas que as praticam:
desc modalidade;
desc pratica;
desc atleta;

select m.id, m.descricao, a.nome
   from atleta a join pratica p
     on a.id = p.id_atleta
   join modalidade m on m.id = p.id_modalidade
   order by m.id;
   
-- Liste o nome, data de início e data de término dos campeonatos e o registro
-- de atletas que participaram dele, se houver (inlcuir na listagem campeonatos
-- que ninguém participou)

desc campeonato;
desc participa;

select c.nome, c.data_inicio, c.data_fim, p.registro_atleta
   from campeonato c left outer join participa p
     on c.id = p.id_campeonato
   where c.data_inicio is not null;