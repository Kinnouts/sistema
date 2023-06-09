-- MySQL Script generated by MySQL Workbench
-- Tue Jun 13 18:09:36 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dbsistemas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbsistemas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbsistemas` DEFAULT CHARACTER SET utf8 ;
USE `dbsistemas` ;

-- -----------------------------------------------------
-- Table `dbsistemas`.`articulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbsistemas`.`articulo` ;

CREATE TABLE IF NOT EXISTS `dbsistemas`.`articulo` (
  `idarticulo` INT(11) NOT NULL AUTO_INCREMENT,
  `idcategoria` INT(11) NOT NULL,
  `codigo` VARCHAR(50) NULL DEFAULT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `stock` INT(11) NOT NULL,
  `descripcion` VARCHAR(256) NULL DEFAULT NULL,
  `imagen` VARCHAR(50) NULL DEFAULT NULL,
  `condicion` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idarticulo`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC),
  INDEX `fk_articulo_categoria_idx` (`idcategoria` ASC),
  CONSTRAINT `fk_articulo_categoria`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `dbsistemas`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsistemas`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbsistemas`.`categoria` ;

CREATE TABLE IF NOT EXISTS `dbsistemas`.`categoria` (
  `idcategoria` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(256) NULL DEFAULT NULL,
  `condicion` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idcategoria`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsistemas`.`detalle_ingreso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbsistemas`.`detalle_ingreso` ;

CREATE TABLE IF NOT EXISTS `dbsistemas`.`detalle_ingreso` (
  `iddetalle_ingreso` INT(11) NOT NULL AUTO_INCREMENT,
  `idingreso` INT(11) NOT NULL,
  `idarticulo` INT(11) NOT NULL,
  `cantidad` INT(11) NOT NULL,
  `precio_compra` DECIMAL(11,2) NOT NULL,
  `precio_venta` DECIMAL(11,2) NOT NULL,
  PRIMARY KEY (`iddetalle_ingreso`),
  INDEX `fk_detalle_ingreso_ingreso_idx` (`idingreso` ASC),
  INDEX `fk_detalle_ingreso_articulo_idx` (`idarticulo` ASC),
  CONSTRAINT `fk_detalle_ingreso_articulo`
    FOREIGN KEY (`idarticulo`)
    REFERENCES `dbsistemas`.`articulo` (`idarticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_ingreso_ingreso`
    FOREIGN KEY (`idingreso`)
    REFERENCES `dbsistemas`.`ingreso` (`idingreso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsistemas`.`detalle_venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbsistemas`.`detalle_venta` ;

CREATE TABLE IF NOT EXISTS `dbsistemas`.`detalle_venta` (
  `iddetalle_venta` INT(11) NOT NULL AUTO_INCREMENT,
  `idventa` INT(11) NOT NULL,
  `idarticulo` INT(11) NOT NULL,
  `cantidad` INT(11) NOT NULL,
  `precio_venta` DECIMAL(11,2) NOT NULL,
  `descuento` DECIMAL(11,2) NOT NULL,
  PRIMARY KEY (`iddetalle_venta`),
  INDEX `fk_detalle_venta_venta_idx` (`idventa` ASC),
  INDEX `fk_detalle_venta_articulo_idx` (`idarticulo` ASC),
  CONSTRAINT `fk_detalle_venta_articulo`
    FOREIGN KEY (`idarticulo`)
    REFERENCES `dbsistemas`.`articulo` (`idarticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_venta`
    FOREIGN KEY (`idventa`)
    REFERENCES `dbsistemas`.`venta` (`idventa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsistemas`.`ingreso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbsistemas`.`ingreso` ;

CREATE TABLE IF NOT EXISTS `dbsistemas`.`ingreso` (
  `idingreso` INT(11) NOT NULL AUTO_INCREMENT,
  `idproveedor` INT(11) NOT NULL,
  `idusuario` INT(11) NOT NULL,
  `tipo_comprobante` VARCHAR(20) NOT NULL,
  `serie_comprobante` VARCHAR(7) NULL DEFAULT NULL,
  `num_comprobante` VARCHAR(10) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `impuesto` DECIMAL(4,2) NOT NULL,
  `total_compra` DECIMAL(11,2) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idingreso`),
  INDEX `fk_ingreso_persona_idx` (`idproveedor` ASC),
  INDEX `fk_ingreso_usuario_idx` (`idusuario` ASC),
  CONSTRAINT `fk_ingreso_persona`
    FOREIGN KEY (`idproveedor`)
    REFERENCES `dbsistemas`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingreso_usuario`
    FOREIGN KEY (`idusuario`)
    REFERENCES `dbsistemas`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsistemas`.`permiso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbsistemas`.`permiso` ;

CREATE TABLE IF NOT EXISTS `dbsistemas`.`permiso` (
  `idpermiso` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idpermiso`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsistemas`.`persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbsistemas`.`persona` ;

CREATE TABLE IF NOT EXISTS `dbsistemas`.`persona` (
  `idpersona` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo_persona` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `tipo_documento` VARCHAR(20) NULL DEFAULT NULL,
  `num_documento` VARCHAR(20) NULL DEFAULT NULL,
  `direccion` VARCHAR(70) NULL DEFAULT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`idpersona`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsistemas`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbsistemas`.`usuario` ;

CREATE TABLE IF NOT EXISTS `dbsistemas`.`usuario` (
  `idusuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `tipo_documento` VARCHAR(20) NOT NULL,
  `num_documento` VARCHAR(20) NOT NULL,
  `direccion` VARCHAR(70) NULL DEFAULT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `cargo` VARCHAR(20) NULL DEFAULT NULL,
  `login` VARCHAR(20) NOT NULL,
  `clave` VARCHAR(64) NOT NULL,
  `imagen` VARCHAR(50) NOT NULL,
  `condicion` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsistemas`.`usuario_permiso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbsistemas`.`usuario_permiso` ;

CREATE TABLE IF NOT EXISTS `dbsistemas`.`usuario_permiso` (
  `idusuario_permiso` INT(11) NOT NULL AUTO_INCREMENT,
  `idusuario` INT(11) NOT NULL,
  `idpermiso` INT(11) NOT NULL,
  PRIMARY KEY (`idusuario_permiso`),
  INDEX `fk_usuario_permiso_permiso_idx` (`idpermiso` ASC),
  INDEX `fk_usuario_permiso_usuario_idx` (`idusuario` ASC),
  CONSTRAINT `fk_usuario_permiso_permiso`
    FOREIGN KEY (`idpermiso`)
    REFERENCES `dbsistemas`.`permiso` (`idpermiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_permiso_usuario`
    FOREIGN KEY (`idusuario`)
    REFERENCES `dbsistemas`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 91
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsistemas`.`venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbsistemas`.`venta` ;

CREATE TABLE IF NOT EXISTS `dbsistemas`.`venta` (
  `idventa` INT(11) NOT NULL AUTO_INCREMENT,
  `idcliente` INT(11) NOT NULL,
  `idusuario` INT(11) NOT NULL,
  `tipo_comprobante` VARCHAR(20) NOT NULL,
  `serie_comprobante` VARCHAR(7) NULL DEFAULT NULL,
  `num_comprobante` VARCHAR(10) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `impuesto` DECIMAL(4,2) NOT NULL,
  `total_venta` DECIMAL(11,2) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idventa`),
  INDEX `fk_venta_persona_idx` (`idcliente` ASC),
  INDEX `fk_venta_usuario_idx` (`idusuario` ASC),
  CONSTRAINT `fk_venta_persona`
    FOREIGN KEY (`idcliente`)
    REFERENCES `dbsistemas`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_usuario`
    FOREIGN KEY (`idusuario`)
    REFERENCES `dbsistemas`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8;

USE `dbsistemas`;

DELIMITER $$

USE `dbsistemas`$$
DROP TRIGGER IF EXISTS `dbsistemas`.`tr_updStockIngreso` $$
USE `dbsistemas`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `dbsistemas`.`tr_updStockIngreso`
AFTER INSERT ON `dbsistemas`.`detalle_ingreso`
FOR EACH ROW
BEGIN
 UPDATE articulo SET stock = stock + NEW.cantidad 
 WHERE articulo.idarticulo = NEW.idarticulo;
END$$


USE `dbsistemas`$$
DROP TRIGGER IF EXISTS `dbsistemas`.`tr_updStockVenta` $$
USE `dbsistemas`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `dbsistemas`.`tr_updStockVenta`
AFTER INSERT ON `dbsistemas`.`detalle_venta`
FOR EACH ROW
BEGIN
 UPDATE articulo SET stock = stock - NEW.cantidad 
 WHERE articulo.idarticulo = NEW.idarticulo;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
