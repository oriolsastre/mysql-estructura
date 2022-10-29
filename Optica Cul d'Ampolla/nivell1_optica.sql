CREATE DATABASE `optica`;

CREATE TABLE IF NOT EXISTS `adreca` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `carrer` VARCHAR(25) NOT NULL,
    `numero` SMALLINT UNSIGNED NOT NULL,
    `pis` TINYINT UNSIGNED,
    `porta` TINYINT UNSIGNED, /*pot ser porta A, B? Alguna cosa així?*/
    `ciutat` VARCHAR(50) NOT NULL,
    `codipostal` VARCHAR(10), /*codis postals estrangers?*/
    `pais` VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS `client` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nom` VARCHAR(25) NOT NULL,
    `cognoms` VARCHAR(50),
    `adreca` INT,
    `telefon` VARCHAR(20), /* per tema prefixos, +00 i numeros estrangers llargs */
    `email` VARCHAR(50) NULL,
    `data_registre` DATE,
    `recomanat` INT DEFAULT NULL,
    CONSTRAINT `FK_Adreca_Client` FOREIGN KEY (`adreca`) REFERENCES `adreca` (`id`)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT `FK_Recomanat_Client` FOREIGN KEY (`recomanat`) REFERENCES `client` (`id`)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS `proveidor` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nom` VARCHAR(50),
    `adreca` INT,
    `telefon` VARCHAR(20),
    `fax` VARCHAR(20) DEFAULT NULL,
    `NIF` VARCHAR(15),
    CONSTRAINT `FK_Adreca_Proveidor` FOREIGN KEY (`adreca`) REFERENCES `adreca` (`id`)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS `marca` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nom` VARCHAR(25) NOT NULL,
    `proveidor` INT NOT NULL,
    CONSTRAINT `FK_Proveidor_Marca` FOREIGN KEY (`proveidor`) REFERENCES `proveidor` (`id`)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS `ulleres` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `marca` INT NOT NULL,
    `graduacio_d` DOUBLE(4,2) NOT NULL,
    `graduacio_e` DOUBLE(4,2) NOT NULL,
    `vidre_d` VARCHAR(20),
    `vidre_e` VARCHAR(20),
    `color_e` VARCHAR(20) DEFAULT NULL,
    `color_d` VARCHAR(20) DEFAULT NULL,
    `muntura` ENUM(`flotant`, `pasta`, `metallica`) NOT NULL,
    `color_muntura` VARCHAR(20),
    `preu` DOUBLE(6,2) NOT NULL,

    CONSTRAINT `FK_Marca_Ulleres` FOREIGN KEY (`marca`) REFERENCES `marca` (`id`)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS `empleat` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `nom` VARCHAR(25) NOT NULL,
    `cognoms` VARCHAR(50),
    `data_naixement` DATE,
    `data_inici` DATE NOT NULL,
    `data_final` DATE DEFAULT NULL

);

CREATE TABLE IF NOT EXISTS `venda` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `ulleres` INT NOT NULL,
    `empleat` INT NOT NULL,
    `client` INT,
    `data` DATE NOT NULL,
    CONSTRAINT `FK_Ulleres_Venda` FOREIGN KEY (`ulleres`) REFERENCES `ulleres` (`id`)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `FK_Empleat_Venda` FOREIGN KEY (`empleat`) REFERENCES `empleat` (`id`)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `FK_Client_Venda` FOREIGN KEY (`client`) REFERENCES `client` (`id`)
        ON UPDATE CASCADE ON DELETE SET NULL
);