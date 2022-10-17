drop trigger if exists Tgr_ClienteConteudo_Insert;
DELIMITER $
CREATE TRIGGER Tgr_ClienteConteudo_Insert BEFORE INSERT
ON conteudo_cliente
FOR EACH ROW
BEGIN
		declare textoLog varchar(255);
        if NEW.nota is not null then
			set textoLog = CONCAT("Associação de conteúdo e cliente percentual assistido: ",NEW.percentual_assistido," nota: ",NEW.nota);
		else
			set textoLog = CONCAT("Associação de conteúdo e cliente percentual assistido: ",NEW.percentual_assistido);
		end if;
		insert into logs_clientes_conteudos(data,descricao,clientes_id,conteudo_id)
		values
		(curdate(),textoLog,NEW.clientes_id,NEW.conteudo_id);
END$
DELIMITER ; 


drop trigger if exists Tgr_ClienteConteudo_Update;
DELIMITER $
CREATE TRIGGER Tgr_ClienteConteudo_Update BEFORE Update
ON conteudo_cliente
FOR EACH ROW
BEGIN
		declare textoLog varchar(255);
        if NEW.nota is not null then
			set textoLog = CONCAT("Atualização de associação de conteudo e cliente novo percentual assistido: ",NEW.percentual_assistido," nota: ",NEW.nota);
		else
			set textoLog = CONCAT("Atualização de associação de conteudo e cliente novo percentual assistido: ",NEW.percentual_assistido);
		end if;
		insert into logs_clientes_conteudos(data,descricao,clientes_id,conteudo_id)
		values
		(curdate(),textoLog,NEW.clientes_id,NEW.conteudo_id);
END$
DELIMITER ; 