
##
# Inner Joins
##

#Duas tabelas

#Exibe o conteudo e seu tipo
create or replace view view_tiposConteudos as
select con.descricao as conteudo, tip.descricao as tipo from conteudo con
inner join tipos tip on con.tipos_conteudo_id = tip.id;

select * from view_tiposConteudos;

#Exibe o cliente e o tipo de assinatura
create or replace view view_clienteTipoAssinatura as
select cl.nome as cliente, tip.descricao as tipo from clientes cl
inner join tipos_assinaturas tip on cl.tipos_assinaturas_id = tip.id;

select * from view_clienteTipoAssinatura;


#Três tabelas

# View que lista todos os atores de todos os conteudos
create or replace view view_atores_conteudos  as
select c.descricao as nomeConteudo, a.nome as nomeAtor from atores_conteudo ac
inner join conteudo c on ac.conteudo_id = c.id
inner join atores a on ac.atores_id = a.id;

select * from view_atores_conteudos;

#View que lista a idade media dos atores de cada conteudo
create or replace view view_IdadeMediaAtores_conteudos  as
select c.descricao as nomeConteudo, round(avg(timestampdiff(year,a.nascimento,CURDATE()))) as idadeMedia from atores_conteudo ac
inner join conteudo c on ac.conteudo_id = c.id
inner join atores a on ac.atores_id = a.id
group by c.descricao order by idadeMedia;

select * from view_IdadeMediaAtores_conteudos;



#Cinco tabelas

#Media de notas por tipo e pais
create or replace view view_NotasPorTipoEPais as
select tip.descricao as tipo,pa.nome as pais,avg(ccl.nota) as mediaNota from conteudo_cliente ccl
inner join conteudo con on ccl.conteudo_id = con.id
inner join clientes cl on ccl.clientes_id = cl.id
inner join paises pa on cl.paises_id = pa.id
inner join tipos tip on con.tipos_conteudo_id=tip.id
group by tip.descricao,pa.nome;

select * from view_NotasPorTipoEPais;


##
# LEFT JOIN
##


create or replace view view_ConteudosTipos as
select c.descricao as conteudo, tip.descricao as tipo from conteudo c
left join tipos tip on c.tipos_conteudo_id = tip.id;

select * from view_ConteudosTipos;


###
# RIGHT JOIN
###

create or replace view view_TiposConteudos as
select c.descricao as conteudo, tip.descricao as tipo from conteudo c
right join tipos tip on c.tipos_conteudo_id = tip.id;

select * from view_TiposConteudos;


###
# DQLs
###

# Max e subquery
create or replace view clientesMaisVelhos as
select nome, timestampdiff(year,nascimento,CURDATE()) as idade from clientes where
timestampdiff(year,nascimento,CURDATE()) = (select max(timestampdiff(year,nascimento,CURDATE())) from clientes);

select * from clientesMaisVelhos;

# Min, subquery e now
create or replace view clientesMaisNovos as
select nome, timestampdiff(year,nascimento,NOW()) as idade from clientes where
timestampdiff(year,nascimento,NOW()) = (select min(timestampdiff(year,nascimento,NOW())) from clientes);

select * from clientesMaisNovos;

# Like
create or replace view logsDeAtualizacao as
select * from logs_clientes_conteudos
where descricao like '%Atualização de associação de conteudo e cliente novo percentual assistido:%';

select * from logsDeAtualizacao;

# Clientes jovens
create or replace view clientesJovens as
select nome, timestampdiff(year,nascimento,CURDATE()) as idade from clientes where
timestampdiff(year,nascimento,CURDATE()) between 18 and 25;

select * from clientesJovens;

# Meses de nascimento dos clientes 
create or replace view semestreNascimentoClientes as
select nome,
CASE 
	WHEN DATE_FORMAT(nascimento,'%c') > 6 then 'Segundo Semestre'
    ELSE 'Primeiro semestre'
    END AS SemestreNascimento
from clientes;

select * from semestreNascimentoClientes;


# Clientes que assistiram nos quais a média das notas é a cima de 7 para os conteudos
create or replace view clientesQueDaoNotasBoas as 
select n.nome as cliente, round(avg(ccl.nota),2) as mediaNotas from conteudo_cliente as ccl
inner join clientes n on ccl.clientes_id = n.id
group by n.nome
having avg(ccl.nota)>7;

select * from clientesQueDaoNotasBoas;

#IF
# Selecionar se o cliente é maior ou menor de idade
create or replace view clientesMaiorOuMenorIdade as
SELECT nome, IF(timestampdiff(year,nascimento,CURDATE())<18,"Menor de idade","Maior de idade") from clientes;

select * from clientesMaiorOuMenorIdade;


#OR
create or replace view clientesBrasileirosOuArgentinos as
select c.nome as cliente ,p.nome as pais from clientes c
inner join paises p on c.paises_id = p.id
where p.nome = 'Brasil' or p.nome='Brazil' or p.nome='Argentina';

select * from clientesBrasileirosOuArgentinos;
