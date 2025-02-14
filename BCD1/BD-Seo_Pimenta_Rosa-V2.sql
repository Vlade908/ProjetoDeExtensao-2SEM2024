-- MySQL Script generated by MySQL Workbench
-- Fri Aug  2 19:56:59 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema seopimenta
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema seopimenta
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `seopimenta` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `seopimenta` ;

-- -----------------------------------------------------
-- Table `seopimenta`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`endereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(255) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(50) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`telefone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `numero` (`numero` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`cargo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_fim` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome` (`nome` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`funcionario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(100) NOT NULL,
  `id_endereco` INT NOT NULL,
  `id_telefone` INT NOT NULL,
  `id_cargo` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `id_endereco` (`id_endereco` ASC) VISIBLE,
  INDEX `id_telefone` (`id_telefone` ASC) VISIBLE,
  INDEX `id_cargo` (`id_cargo` ASC) VISIBLE,
  CONSTRAINT `funcionario_ibfk_1`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `seopimenta`.`endereco` (`id`),
  CONSTRAINT `funcionario_ibfk_2`
    FOREIGN KEY (`id_telefone`)
    REFERENCES `seopimenta`.`telefone` (`id`),
  CONSTRAINT `funcionario_ibfk_3`
    FOREIGN KEY (`id_cargo`)
    REFERENCES `seopimenta`.`cargo` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(100) NOT NULL,
  `id_funcionario` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `id_funcionario` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `usuario_ibfk_1`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `seopimenta`.`funcionario` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`acesso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`acesso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_hora_login` DATETIME NOT NULL,
  `endereco_ip` VARCHAR(45) NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `acesso_ibfk_1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `seopimenta`.`usuario` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome` (`nome` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`fornecedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_fantasia` VARCHAR(100) NOT NULL,
  `razao_social` VARCHAR(100) NOT NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  `id_endereco` INT NOT NULL,
  `id_telefone` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `razao_social` (`razao_social` ASC) VISIBLE,
  UNIQUE INDEX `cnpj` (`cnpj` ASC) VISIBLE,
  INDEX `id_endereco` (`id_endereco` ASC) VISIBLE,
  INDEX `id_telefone` (`id_telefone` ASC) VISIBLE,
  CONSTRAINT `fornecedor_ibfk_1`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `seopimenta`.`endereco` (`id`),
  CONSTRAINT `fornecedor_ibfk_2`
    FOREIGN KEY (`id_telefone`)
    REFERENCES `seopimenta`.`telefone` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`compra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_` DATETIME NOT NULL,
  `nfiscal` INT NULL DEFAULT NULL,
  `total` DECIMAL(10,2) NULL DEFAULT NULL,
  `parcelas` INT NULL DEFAULT NULL,
  `status_` VARCHAR(100) NULL DEFAULT NULL,
  `id_fornecedor` INT NULL DEFAULT NULL,
  `id_tipo_pagamento` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_fornecedor` (`id_fornecedor` ASC) VISIBLE,
  CONSTRAINT `compra_ibfk_1`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `seopimenta`.`fornecedor` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`undmedida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`undmedida` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome` (`nome` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`produto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `imagem` VARCHAR(255) NULL DEFAULT NULL,
  `valor_compra` DECIMAL(10,2) NULL DEFAULT NULL,
  `valor_venda` DECIMAL(10,2) NULL DEFAULT NULL,
  `id_unidade_medida` INT NULL DEFAULT NULL,
  `id_categoria` INT NULL DEFAULT NULL,
  `id_subcategoria` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_unidade_medida` (`id_unidade_medida` ASC) VISIBLE,
  INDEX `id_categoria` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `produto_ibfk_1`
    FOREIGN KEY (`id_unidade_medida`)
    REFERENCES `seopimenta`.`undmedida` (`id`),
  CONSTRAINT `produto_ibfk_2`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `seopimenta`.`categoria` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`consumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`consumo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_` DATETIME NOT NULL,
  `nfiscal` INT NULL DEFAULT NULL,
  `total` DECIMAL(10,2) NULL DEFAULT NULL,
  `parcelas` INT NULL DEFAULT NULL,
  `avista` INT NULL DEFAULT NULL,
  `status_` VARCHAR(100) NULL DEFAULT NULL,
  `id_compra` INT NULL DEFAULT NULL,
  `id_produto` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_compra` (`id_compra` ASC) VISIBLE,
  INDEX `id_produto` (`id_produto` ASC) VISIBLE,
  CONSTRAINT `consumo_ibfk_1`
    FOREIGN KEY (`id_compra`)
    REFERENCES `seopimenta`.`compra` (`id`),
  CONSTRAINT `consumo_ibfk_2`
    FOREIGN KEY (`id_produto`)
    REFERENCES `seopimenta`.`produto` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`estoque` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantidade` INT NOT NULL,
  `id_produto` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_produto` (`id_produto` ASC) VISIBLE,
  CONSTRAINT `estoque_ibfk_1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `seopimenta`.`produto` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`historico_precos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`historico_precos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `preco` DECIMAL(10,2) NOT NULL,
  `data_criacao` DATE NOT NULL,
  `id_produto` INT NOT NULL,
  `id_fornecedor` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_produto` (`id_produto` ASC) VISIBLE,
  INDEX `id_fornecedor` (`id_fornecedor` ASC) VISIBLE,
  CONSTRAINT `historico_precos_ibfk_1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `seopimenta`.`produto` (`id`),
  CONSTRAINT `historico_precos_ibfk_2`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `seopimenta`.`fornecedor` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`itenscompra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`itenscompra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantidade` FLOAT NOT NULL,
  `valor` DECIMAL(10,2) NULL DEFAULT NULL,
  `id_compra` INT NULL DEFAULT NULL,
  `id_produto` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_compra` (`id_compra` ASC) VISIBLE,
  INDEX `id_produto` (`id_produto` ASC) VISIBLE,
  CONSTRAINT `itenscompra_ibfk_1`
    FOREIGN KEY (`id_compra`)
    REFERENCES `seopimenta`.`compra` (`id`),
  CONSTRAINT `itenscompra_ibfk_2`
    FOREIGN KEY (`id_produto`)
    REFERENCES `seopimenta`.`produto` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`itensconsumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`itensconsumo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantidade` FLOAT NOT NULL,
  `valor` DECIMAL(10,2) NULL DEFAULT NULL,
  `id_consumo` INT NOT NULL,
  `id_produto` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_consumo` (`id_consumo` ASC) VISIBLE,
  INDEX `id_produto` (`id_produto` ASC) VISIBLE,
  CONSTRAINT `itensconsumo_ibfk_1`
    FOREIGN KEY (`id_consumo`)
    REFERENCES `seopimenta`.`consumo` (`id`),
  CONSTRAINT `itensconsumo_ibfk_2`
    FOREIGN KEY (`id_produto`)
    REFERENCES `seopimenta`.`produto` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `seopimenta`.`salario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seopimenta`.`salario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `salario` DECIMAL(10,2) NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_fim` DATE NULL DEFAULT NULL,
  `id_funcionario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_funcionario` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `salario_ibfk_1`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `seopimenta`.`funcionario` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
