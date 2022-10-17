insert into atores (nome,nascimento)
values 
("Ana","1998-02-13"),
("Carlos","1991-03-13"),
("Pedro","1950-03-14"),
("Maria","1951-11-16"),
("Eduarda","2000-12-23"),
("Isabella","1996-11-11"),
("Flávia","1986-07-11"),
("Pietra","1978-07-15"),
("Beatriz","2001-07-18"),
("Roberta","1979-07-16");

insert into tipos (descricao)
values
("Filme"),
("Série"),
("Documentário"),
("Mini-Série"),
("Novela"),
("Videoclipe"),
("Curta"),
("Teatro"),
("Animação"),
("Outros");

insert into categorias (descricao)
values
("Ação"),
("Drama"),
("Terror"),
("Comédia"),
("Suspense"),
("Aventura"),
("Esporte"),
("Fatos reais"),
("Ficção científica"),
("Romance");

insert into conteudo (descricao,tipos_conteudo_id,idade_minima)
values
("O Chamado",1,18),
("Forest Gump",1,10),
("Dexter",2,18),
("Game of thrones",2,18),
("Simpsons",9,10),
("Garfield",9,10),
("Interstellar",1,10),
("Carros",1,10),
("Veloses e furiosos",1,12),
("Corra",1,18),
("Champions League",10,0);

insert into atores_conteudo (Atores_id,conteudo_id)
values
(1,1),
(1,2),
(2,3),
(2,4),
(3,5),
(3,6),
(4,7),
(4,8),
(5,8),
(5,9),
(6,9),
(6,10),
(7,1),
(7,2),
(8,3),
(8,4),
(9,5),
(9,6),
(1,11);


insert into categorias_conteudo (conteudo_id,categorias_id)
values
(1,1),
(1,2),
(2,3),
(2,4),
(3,5),
(3,6),
(4,7),
(4,8),
(5,8),
(5,9),
(6,9),
(6,10),
(7,1),
(7,2),
(8,3),
(8,4),
(9,5),
(9,6),
(10,7),
(10,8),
(11,7);



insert into tipos_assinaturas (descricao)
values
("Cartao Credito Mensal"),
("Cartao Credito Trimestral"),
("Cartao Credito Semestral"),
("Cartao Credito Anual"),
("Boleto Mensal"),
("Boleto Trimestral"),
("Boleto Semestral"),
("Boleto Anual"),
("Gift Card"),
("Débito automático");


insert into paises (nome)
values
("Brasil"),
("India"),
("Alemanha"),
("Portugal"),
("Estados Unidos"),
("Polonia"),
("Russia"),
("Africa do Sul"),
("Argentina"),
("Bolivia"),
("Chile");


insert into clientes (nome,email,telefone,nascimento,tipos_assinaturas_id,pago,paises_id,ultimo_pagamento)
values
("Joao","jao@gmail.com","11991440876","1998-02-13",1,true,1,CURDATE()),
("Ana","ana@gmail.com","11981443876","1991-03-13",1,true,2,CURDATE()),
("Eduarda","duda@gmail.com","11911443876","2000-10-13",4,true,2,CURDATE()),
("Isabella","isa@gmail.com","12911443876","1996-03-17",2,true,1,CURDATE()),
("Maria","maria@gmail.com","17921443876","1991-08-15",7,true,2,CURDATE()),
("Beatriz","bia@gmail.com","17911446876","1998-03-16",2,true,6,CURDATE()),
("Fernanda","nanda@gmail.com","12911643876","2002-03-17",2,true,8,CURDATE()),
("Carla","carla@gmail.com","12921643876","2007-05-17",2,true,9,CURDATE()),
("Julia","julia@gmail.com","17929643876","1997-05-17",10,true,10,CURDATE()),
("Vinicius","vini@gmail.com","17929624876","1998-11-19",10,true,10,CURDATE());


insert into conteudo_cliente (clientes_id,conteudo_id,percentual_assistido,nota)
values
(1,1,50,null),
(1,2,70,null),
(1,3,100,8),
(2,1,50,null),
(2,2,100,2),
(3,3,100,6),
(4,3,80,null),
(4,4,100,10),
(5,4,100,8),
(6,5,100,9),
(7,6,50,null),
(7,7,100,10),
(8,8,100,5),
(8,9,100,10),
(9,9,100,10),
(9,10,50,null),
(10,10,100,7),
(10,1,50,null);



