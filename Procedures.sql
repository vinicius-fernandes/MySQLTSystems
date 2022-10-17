
drop procedure if exists checkNome;
drop procedure if exists checkExisteEmail;
drop procedure if exists checkIdade;
drop procedure if exists addCliente;
drop procedure if exists addPais;
drop procedure if exists addTipoAssinatura;
drop procedure if exists checkExistePais;
drop procedure if exists checkExisteTipoAssinaturas;
drop procedure if exists alterCliente;
drop procedure if exists checkTamanhoEmail;
drop procedure if exists alterPais;
drop procedure if exists alterTipoAssinatura;
drop procedure if exists removePais;
drop procedure if exists removeTipoAssinatura;
drop procedure if exists removeCliente;

DELIMITER $$
create procedure checkTamanhoEmail(IN email varchar(50),OUT valido boolean)
begin
	set valido = true;
	if LENGTH(email)<10 then
		set valido = false;
	end if;
end $$
DELIMITER ;

DELIMITER $$
create procedure checkNome(IN nome varchar(30),OUT valido boolean)
begin
	set valido = true;
	if LENGTH(nome)<3 then
		set valido = false;
	end if;
end $$
DELIMITER ;

DELIMITER $$
create procedure checkExisteEmail(IN emailParaChecar varchar(50), OUT existe bool)
begin 
    declare countEmails int default 0;
	set existe = false;
    select count(*) into countEmails from clientes where email = emailParaChecar;
    if countEmails > 0 then
		set existe = true; 
    end if;
end $$
DELIMITER ;

DELIMITER $$
create procedure checkExistePais(IN nomeParaChecar varchar(50), OUT existe bool)
begin 
    declare countPaises int default 0;
	set existe = false;
    select count(*) into countPaises from paises where nome = nomeParaChecar;
    if countPaises > 0 then
		set existe = true; 
    end if;
end $$
DELIMITER ;

DELIMITER $$
create procedure checkExisteTipoAssinaturas(IN nomeParaChecar varchar(50), OUT existe bool)
begin 
    declare checkExisteTipoAssinaturas int default 0;
	set existe = false;
    select count(*) into checkExisteTipoAssinaturas from tipos_assinaturas where descricao = nomeParaChecar;
    if checkExisteTipoAssinaturas > 0 then
		set existe = true; 
    end if;
end $$
DELIMITER ;


DELIMITER $$
create procedure checkIdade(IN dataParaChecar DateTime, OUT valido bool)
begin 
    declare idade int default 0;
	set valido = false;
    select timestampdiff(year,dataParaChecar,curdate()) into idade;
    if idade >= 14 then
		set valido = true; 
    end if;
end $$
DELIMITER ;


##Cadastro de tipo de assinatura
DELIMITER $$
create procedure addTipoAssinatura(In nome varchar(45))
procAddTipoAssinatura:begin 
	call checkExisteTipoAssinaturas(nome,@existeTipoAssinaturas);
    if @existeTipoAssinaturas then
		select "O tipo de assinatura já está cadastrado no sistema";
		leave procAddTipoAssinatura;
	end if;
    insert into tipos_assinaturas (descricao)
    values (nome);
    select "Tipo de assinatura cadastrad com sucesso";
end $$
DELIMITER;


##Cadastro de pais
DELIMITER $$
create procedure addPais(In nome varchar(45))
procAddPais:begin
	call checkNome(nome,@nomeValido);
    if not @nomeValido then
		select "O nome inserido deve ser maior que 3 caracteres";
        leave procAddPais;
    end if;  
	call checkExistePais(nome,@existePais);
    if @existePais then
		select "O pais já está cadastrado no sistema";
		leave procAddPais;
	end if;
    insert into paises (nome)
    values (nome);
    select "Pais cadastrado com sucesso";
end $$
DELIMITER;



##Cadastro de clientes
DELIMITER $$
create procedure addCliente(IN nome varchar(45), IN email varchar(45), IN telefone varchar(45), IN nascimento DateTime, IN tipo_assinatura INT, IN pais int, IN pago bool)
procAddCliente:begin
	call checkNome(nome,@nomeValido);
    if not @nomeValido then
		select "O nome inserido deve ser maior que 3 caracteres";
        leave procAddCliente;
    end if;    
    call checkIdade(nascimento,@nascimentoValido);
	if not @nascimentoValido then
		select "O cliente deve ser maior de 18 anos";
        leave procAddCliente;
    end if;    
	call checkTamanhoEmail(email,@emailTamanhoValido);
    if not @emailTamanhoValido then
		select "O email deve possuir no mínimo 10 caracteres";
		leave procAddCliente;
	end if;
	call checkExisteEmail(email,@existeEmail);
    if @existeEmail then
		select "O email já está cadastrado no sistema";
		leave procAddCliente;
	end if;

	insert into clientes (nome,email,telefone,nascimento,tipos_assinaturas_id,pago,paises_id,ultimo_pagamento)
    values(nome,email,telefone,nascimento,tipo_assinatura,pago,pais,curdate());
    select "Cliente cadastrado com sucesso";
end $$;
DELIMITER ;

DELIMITER $$
create procedure alterCliente(IN emailAntigo varchar(45),IN emailNovo varchar(45),IN nomeNovo varchar(45),IN novoNascimento Datetime,IN novoPago boolean)
procEditCliente: begin
	declare codigoCliente int;
    select id into codigoCliente from clientes where email = emailAntigo;
    
    if codigoCliente is null then
		select "Não foi possível identificar nenhum cliente com esse email";
        leave procEditCliente;
	end if;
    	call checkNome(nomeNovo,@nomeValido);
    if not @nomeValido then
		select "O nome inserido deve ser maior que 3 caracteres";
        leave procEditCliente;
    end if;    
    call checkIdade(novoNascimento,@nascimentoValido);
	if not @nascimentoValido then
		select "O cliente deve ser maior de 18 anos";
        leave procEditCliente;
    end if;  
	call checkTamanhoEmail(emailNovo,@emailTamanhoValido);
    if not @emailTamanhoValido then
		select "O email deve possuir no mínimo 10 caracteres";
		leave procEditCliente;
	end if;
	call checkExisteEmail(emailNovo,@existeEmail);
    if @existeEmail then
		if (select count(*) from clientes where id != codigoCliente and email = emailNovo)>0 then
			select "O email já está cadastrado no sistema";
			leave procEditCliente;
		end if;
	end if;
    
	update clientes set nome = nomeNovo, email=emailNovo,nascimento = novoNascimento,pago=novoPago where id = codigoCliente;
    select "Cliente atualizado com sucesso";
end $$
DELIMITER ;

DELIMITER $$
create procedure alterPais(IN paisAntigo varchar(45),IN paisNovo varchar(45))
procAlterPais:begin
	declare codigoPais int;
    select id into codigoPais from paises where nome = paisAntigo;
    if codigoPais is null then
		select "Não foi possível identificar nenhum pais com esse nome";
        leave procAlterPais;
	end if;
	call checkExistePais(paisNovo,@existePais);
    if @existePais then
		if (select count(*) from paises where id != codigoPais and nome = paisNovo)>0 then
			select "O pais já está cadastrado no sistema";
			leave procAlterPais;
		end if;
	end if;
    update paises set nome = paisNovo where id = codigoPais;
    select "Pais atualizado com sucesso";
end $$
DELIMITER ;

DELIMITER $$
create procedure alterTipoAssinatura(IN descricaoAntiga varchar(45),IN descricaoNova varchar(45))
procAlterTipoAssinatura:begin
	declare codigoTipoAssinatura int;
    select id into codigoTipoAssinatura from tipos_assinaturas where descricao = descricaoAntiga;
    if codigoTipoAssinatura is null then
		select "Não foi possível identificar nenhum tipo de assinatura com esse nome";
        leave procAlterTipoAssinatura;
	end if;
	call checkExisteTipoAssinaturas(descricaoNova,@existeTipoAssinatura);
    if @existeTipoAssinatura then
		if (select count(*) from tipos_assinaturas where id != codigoTipoAssinatura and descricao = descricaoNova)>0 then
			select "O tipo de assinatura já está cadastrado no sistema";
			leave procAlterTipoAssinatura;
		end if;
	end if;
    update tipos_assinaturas set descricao = descricaoNova where id = codigoTipoAssinatura;
    select "Tipo de assinatura atualizada com sucesso!";
end $$
DELIMITER ;


DELIMITER $$
create procedure removeCliente(IN emailParaRemover varchar(45))
procRemoveCliente:begin
	declare conteudoClienteCount int;
	select count(*) into conteudoClienteCount from conteudo_cliente ccl
    inner join clientes cl on ccl.clientes_id = cl.id
    where cl.email = emailParaRemover;
    if conteudoClienteCount >0 then
		select "Não é possível remover o cliente com o email especificado por ele está associado com conteudos";
		leave procRemoveCliente;
    end if;
    	call checkExisteEmail(emailParaRemover,@existeEmail);
    if not @existeEmail then
		select "O email não foi encontrado no sistema";
		leave procRemoveCliente;
	end if;
    
    delete from clientes where email = emailParaRemover;
    select "Cliente removido com sucesso";
end $$
DELIMITER ;

DELIMITER $$
create procedure removePais(IN nomePais varchar(45))
procRemovePais:begin
	declare paisClienteCount int;
	select count(*) into paisClienteCount from clientes cl
    inner join paises p on cl.paises_id = p.id
    where p.nome = nomePais;
	if paisClienteCount >0 then
		select "Não é possível remover o pais com o nome especificado por ele está associado com clientes";
		leave procRemovePais;
    end if;
	call checkExistePais(nomePais,@existePais);
    if not @existePais then
		select "Não foi possível encontrar o pais que se deseja remover";
		leave procRemovePais;
	end if;
    delete from paises where nome = nomePais;
    select "Pais deletado com sucesso";
end $$
DELIMITER ;


DELIMITER $$
create procedure removeTipoAssinatura(IN nomeTipoAssinatura varchar(45))
procRemovePais:begin
	declare TipoAssinaturaClienteCount int;
	select count(*) into TipoAssinaturaClienteCount from clientes cl
    inner join tipos_assinaturas t on cl.tipos_assinaturas_id = t.id
    where t.descricao = nomeTipoAssinatura;
	if TipoAssinaturaClienteCount >0 then
		select "Não é possível remover o tipo de assinatura com o nome especificado por ele está associado com clientes";
		leave procRemovePais;
    end if;
	call checkExisteTipoAssinaturas(nomeTipoAssinatura,@TipoAssinatura);
    if not @TipoAssinatura then
		select "Não foi possível encontrar o tipo de assinatura que se deseja remover";
		leave procRemovePais;
	end if;
    delete from tipos_assinaturas where descricao = nomeTipoAssinatura;
    select "Tipo de assinautra deletada com sucesso";
end $$
DELIMITER ;

call addCliente("Vini","vin2@hotmail.com","17991750690","1998-02-02",1,1,true);

call addPais("EUA");

call addTipoAssinatura("Cartão de débito");

call alterCliente("vin3@hotmail.com","vin12@hotmail.com","Vinici","2006-02-02",false);

call alterPais("Brasil","Brazil");

call alterTipoAssinatura("Boleto mensal","Cartão débito mensal");

call removeCliente("vin3231@hotmail.com");

call removePais("EUA");

call removeTipoAssinatura("Cartão débito mensal");


insert into 
