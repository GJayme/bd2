-- Exercicios:
-- 3. Abra uma nova sessão como Gabriel e faça um Desc na tabela EMP_TEMP do usuário HR.
-- O usuário Gabriel já enxerga a tabela EMP_TEMP? Por que?
desc HR.EMP_TEMP;
    -- Sim o usuário Gabriel já enxerga a tabela, pois o comando de create table já executa um commit quando ele é executado.

-- 5. Como Gabriel, você já enxerga os 2 registros inseridos? Por que?
select * from HR.EMP_TEMP;
    -- Não, pois os insert não foram commitados ainda no usuário HR.

-- 6. Como HR, efetive permanentemente as inserções realizadas e depois,
-- como José, consulte novamente os registros EMP_TEMP.
select * from HR.EMP_TEMP;

-- 8. Como Gabriel, você enxerga os 2 registros inseridos? Por que?
select * from HR.EMP_TEMP;
    -- Não, pois os insert não foram commitados ainda no usuário HR.

-- 10. Como Gabriel, faça um SELECT na EMP_TEMP. Quantos registros aparecem? Por que?
select * from HR.EMP_TEMP;
    -- 4 Registros, pois ocorreu um create table dentro da sessão do HR e com isso um commit foi dado.

-- -- 11. Como HR, faça um UPDATE em algum dos empregados dobrando o seu salário.
-- -- Depois, como Gabriel, faça um SELECT consultando as informações do empregado alterado.
-- -- Qual salário Gabriel enxerga? Por que?
select * from HR.EMP_TEMP;
    -- Exerga os salários antigos, pois os Update não foram commitados ainda no usuário HR.

-- 12. Como HR, desfaça a alteração que dobrava o salário do empregado e consulte os dados do empregado.
-- Então, como Gabriel, consulte também os dados desse empregado.
select * from HR.EMP_TEMP where NOME = 'Caverinha';
select * from HR.EMP_TEMP where NOME = 'Maluquinho';

-- 13. Como Gabriel, marque um SAVEPOINT chamado SP1. Apague 1 registro da tabela HR.EMP_TEMP.
-- Marque agora um novo SAVEPOINT chamado SP2. Apague outro registro qualquer da tabela EMP_TEMP.
-- Consulte a tabela EMP_TEMP como Gabriel e como HR. Quantos registros aparecem para cada um?
savepoint SP1;
delete from HR.EMP_TEMP where nome = 'Caverinha';
savepoint SP2;
delete from HR.EMP_TEMP where nome = 'Maluquinho';

select * from HR.EMP_TEMP;
    -- No Gabriel aparecem 2 registros.

-- 14. Como Gabriel, execute o comando ROLLBACK. O que aconteceu? Por que?
rollback;
select * from HR.EMP_TEMP;
    -- Voltou o resultado antes dos dois Delete.

-- 15. Execute novamente as intruções do item 13.
savepoint SP1;
delete from HR.EMP_TEMP where nome = 'Caverinha';
savepoint SP2;
delete from HR.EMP_TEMP where nome = 'Maluquinho';

-- 16. Como Gabriel, desfaça agora somente o ultimo DELETE realizado. Consulte a tabela EMP_TEMP como HR
-- e como GABRIEL e veja quantos registros aparecem para cada um.
rollback to SP2;
select * from HR.EMP_TEMP;
    -- No Gabriel aparecem 3 registros.

-- 17. Como Gabriel, efetive todas as alterações pendentes. Consulte a tabela EMP_TEMP como HR e como Gabriel
-- e veja quantos registros aparecem para cada um agora.
commit;
select * from HR.EMP_TEMP;

-- 18. Como HR, faça um UPDATE no salário de algum dos registros da EMP_TEMP. Como Gabriel, faça um UPDATE no MESMO registro,
-- modificando o salario para outro valor. O que acontecue em cada uma das sessões? Por que?

update HR.EMP_TEMP set SAL = 5000 where NOME = 'Maluquinho';
    --Quando for fazer o segundo Update o sgbd vai travar e aguardar o primeiro update ser commitado.