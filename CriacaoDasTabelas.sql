
-- -----------------------------------------------------
-- Tipos assinaturas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipos_assinaturas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Paises
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paises` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Clientes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(25) NOT NULL,
  `nascimento` DATETIME NOT NULL,
  `ultimo_pagamento` DATETIME NOT NULL,
  `tipos_assinaturas_id` INT NOT NULL,
  `pago` boolean NOT NULL,
  `paises_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clientes_tipos_assinaturas_idx` (`tipos_assinaturas_id` ASC) VISIBLE,
  INDEX `fk_clientes_paises1_idx` (`paises_id` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_tipos_assinaturas`
    FOREIGN KEY (`tipos_assinaturas_id`)
    REFERENCES `tipos_assinaturas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_paises1`
    FOREIGN KEY (`paises_id`)
    REFERENCES `paises` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Tipos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));



-- -----------------------------------------------------
-- Conteudo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `conteudo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `tipos_conteudo_id` INT NOT NULL,
  `idade_minima` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_conteudo_tipos_conteudo1_idx` (`tipos_conteudo_id` ASC) VISIBLE,
  CONSTRAINT `fk_conteudo_tipos_conteudo1`
    FOREIGN KEY (`tipos_conteudo_id`)
    REFERENCES `tipos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Categorias
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Categorias_Conteudo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categorias_conteudo` (
  `conteudo_id` INT NOT NULL,
  `categorias_id` INT NOT NULL,
  PRIMARY KEY (`conteudo_id`, `categorias_id`),
  INDEX `fk_conteudo_has_categorias_conteudo_categorias_conteudo1_idx` (`categorias_id` ASC) VISIBLE,
  INDEX `fk_conteudo_has_categorias_conteudo_conteudo1_idx` (`conteudo_id` ASC) VISIBLE,
  CONSTRAINT `fk_conteudo_has_categorias_conteudo_conteudo1`
    FOREIGN KEY (`conteudo_id`)
    REFERENCES `conteudo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conteudo_has_categorias_conteudo_categorias_conteudo1`
    FOREIGN KEY (`categorias_id`)
    REFERENCES `categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Atores
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `atores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `nascimento` DATETIME NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `mydb`.`atores_conteudo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `atores_conteudo` (
  `atores_id` INT NOT NULL,
  `conteudo_id` INT NOT NULL,
  PRIMARY KEY (`atores_id`, `conteudo_id`),
  INDEX `fk_Atores_has_conteudo_conteudo1_idx` (`conteudo_id` ASC) VISIBLE,
  INDEX `fk_Atores_has_conteudo_Atores1_idx` (`atores_id` ASC) VISIBLE,
  CONSTRAINT `fk_Atores_has_conteudo_Atores1`
    FOREIGN KEY (`atores_id`)
    REFERENCES `atores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Atores_has_conteudo_conteudo1`
    FOREIGN KEY (`conteudo_id`)
    REFERENCES `conteudo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Conteudo_Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `conteudo_cliente` (
  `clientes_id` INT NOT NULL,
  `conteudo_id` INT NOT NULL,
  `percentual_assistido` INT NULL,
  `nota` INT NULL,
  PRIMARY KEY (`clientes_id`, `conteudo_id`),
  INDEX `fk_clientes_has_conteudo_conteudo1_idx` (`conteudo_id` ASC) VISIBLE,
  INDEX `fk_clientes_has_conteudo_clientes1_idx` (`clientes_id` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_has_conteudo_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_has_conteudo_conteudo1`
    FOREIGN KEY (`conteudo_id`)
    REFERENCES `conteudo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Logs_clientes_conteudos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logs_clientes_conteudos` (
  `data` DATETIME NOT NULL,
  `descricao` VARCHAR(255) NULL,
  `clientes_id` INT NOT NULL,
  `conteudo_id` INT NOT NULL,
  INDEX `fk_logs_clientes_conteudos_clientes1_idx` (`clientes_id` ASC) VISIBLE,
  INDEX `fk_logs_clientes_conteudos_conteudo1_idx` (`conteudo_id` ASC) VISIBLE,
  CONSTRAINT `fk_logs_clientes_conteudos_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_logs_clientes_conteudos_conteudo1`
    FOREIGN KEY (`conteudo_id`)
    REFERENCES `conteudo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

