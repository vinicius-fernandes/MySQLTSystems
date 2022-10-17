
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
group by c.descricao;

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


