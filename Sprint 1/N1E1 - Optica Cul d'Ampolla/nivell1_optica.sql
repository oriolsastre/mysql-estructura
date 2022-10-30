DROP DATABASE IF EXISTS `optica`;
CREATE DATABASE `optica`;

CREATE TABLE IF NOT EXISTS `optica`.`adreca` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `carrer` VARCHAR(25) NOT NULL,
    `numero` SMALLINT UNSIGNED NOT NULL,
    `pis` TINYINT UNSIGNED,
    `porta` TINYINT UNSIGNED, /*pot ser porta A, B? Alguna cosa així?*/
    `ciutat` VARCHAR(50) NOT NULL,
    `codipostal` VARCHAR(10), /*codis postals estrangers?*/
    `pais` VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS `optica`.`client` (
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

CREATE TABLE IF NOT EXISTS `optica`.`proveidor` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nom` VARCHAR(50),
    `adreca` INT,
    `telefon` VARCHAR(20),
    `fax` VARCHAR(20) DEFAULT NULL,
    `NIF` VARCHAR(15),
    CONSTRAINT `FK_Adreca_Proveidor` FOREIGN KEY (`adreca`) REFERENCES `adreca` (`id`)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS `optica`.`marca` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nom` VARCHAR(25) NOT NULL,
    `proveidor` INT NOT NULL,
    CONSTRAINT `FK_Proveidor_Marca` FOREIGN KEY (`proveidor`) REFERENCES `proveidor` (`id`)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS `optica`.`ulleres` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `marca` INT NOT NULL,
    `graduacio_d` DOUBLE(4,2) NOT NULL,
    `graduacio_e` DOUBLE(4,2) NOT NULL,
    `vidre_d` VARCHAR(20),
    `vidre_e` VARCHAR(20),
    `color_e` VARCHAR(20) DEFAULT NULL,
    `color_d` VARCHAR(20) DEFAULT NULL,
    `muntura` ENUM('flotant', 'pasta', 'metallica') NOT NULL,
    `color_muntura` VARCHAR(20),
    `preu` DOUBLE(6,2) NOT NULL,
    CONSTRAINT `FK_Marca_Ulleres` FOREIGN KEY (`marca`) REFERENCES `marca` (`id`)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS `optica`.`empleat` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `nom` VARCHAR(25) NOT NULL,
    `cognoms` VARCHAR(50),
    `data_naixement` DATE,
    `data_inici` DATE NOT NULL,
    `data_final` DATE DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `optica`.`venda` (
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

/*Inserts per testejar*/
INSERT INTO `optica`.`adreca` (id, carrer, numero, pis, porta, ciutat, codipostal, pais) VALUES
    (1,'Gran Via',54,3,4,'Barcelona','08040','Catalunya'),
    (2,'Passeig de Gràcia',13,NULL,NULL,'Barcelona','08041','Catalunya'),
    (3,'Carrer Major',2,1,2,'Granollers','08548','Catalunya'),
    (4,'Bremerstraße',13,4,3,'Kiel','14865','Alemanya'),
    (5,'Wall Street',41,NULL,NULL,'Nova York','NY-4567', 'Estats Units');

INSERT INTO `optica`.`client` (id, nom, cognoms, adreca, telefon,email,data_registre,recomanat) VALUES
    (1, 'Natàlia', 'Miralpeix',2,'934567898','natalia.miralpeix@gmail.com','2022-10-25',NULL),
    (2, 'Judit', 'Fléchier',3,'934128635','jflechier@terra.fr', '2022-10-28',1);

INSERT INTO `optica`.`proveidor` (id, nom ,adreca, telefon, fax, NIF) VALUES
    (1, 'Glasses-US', 5, '00541675142536', NULL, 'X-457898-Y'),
    (2, 'Brille und Mehr', 4, '+495678952', '+495678953', 'DE-46578-SH');

INSERT INTO `optica`.`marca` (id, nom, proveidor) VALUES
    (1, 'RayBan', 1),
    (2, 'H&F', 1),
    (3, 'Bogard', 2),
    (4, 'D&G', 1),
    (5, 'MDistrict5', 1),
    (6, 'Sehen&Sehnen', 2),
    (7, 'LoMaiVist', 2);

INSERT INTO `optica`.`ulleres` (id, marca, graduacio_d, graduacio_e, vidre_d, vidre_e, color_e, color_d, muntura, color_muntura, preu) VALUES
    (1, 1, 1.25, 3.75, 'reflectant', 'reflectant', NULL, NULL, 'pasta', 'gris', 49.99),
    (2, 6, -0.25, -0.25, 'self-clean', 'self-clean', 'groc', 'morat', 'metallica', 'verd', 125.00),
    (3, 3, -4.25, -4.25, 'color-change', 'color-change', NULL, 'verd', 'flotant', NULL, 75.49);

INSERT INTO `optica`.`empleat` (id, nom, cognoms, data_naixement, data_inici, data_final) VALUES
    (1, 'Òscar', 'Dalmau Olivé', '1975-01-19', '1993-06-29', '1993-07-07'),
    (2, 'Pere', 'de la Cullera', '1986-11-04', '2018-09-01', NULL);

INSERT INTO `optica`.`venda` (id, ulleres, empleat, client, data) VALUES
    (1, 2, 2, 1, '2022-10-20'),
    (2, 1, 1, 2, '1993-07-01'),
    (3, 3, 2, 1, '2020-09-12');