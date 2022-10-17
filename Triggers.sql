drop trigger if exists Tgr_ClienteConteudo_Insert;
DELIMITER $
CREATE TRIGGER Tgr_ClienteConteudo_Insert BEFORE INSERT
ON conteudo_cliente
FOR EACH ROW
BEGIN
		insert into logs_clientes_conteudos(data,descricao,clientes_id,conteudo_id)
		values
		(curdate(),CONCAT("Associação de conteúdo e cliente percentual assistido: ",NEW.percentual_assistido," nota: ",NEW.nota),NEW.clientes_id,NEW.conteudo_id);
END$
DELIMITER ; 


drop trigger if exists Tgr_ClienteConteudo_Update;
DELIMITER $
CREATE TRIGGER Tgr_ClienteConteudo_Update BEFORE Update
ON conteudo_cliente
FOR EACH ROW
BEGIN
		insert into logs_clientes_conteudos(data,descricao,clientes_id,conteudo_id)
		values
		(curdate(),CONCAT("Atualização de associação de conteudo e cliente novo percentual assistido: ",NEW.percentual_assistido," nova nota: ", NEW.nota),NEW.clientes_id,NEW.conteudo_id);
END$
DELIMITER ; 