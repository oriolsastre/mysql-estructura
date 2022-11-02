DROP DATABASE IF EXISTS `pizzeria`;
CREATE DATABASE `pizzeria`;

CREATE TABLE `pizzeria`.`client` (
    `clientID` INT PRIMARY KEY AUTO_INCREMENT,
    `nom` VARCHAR(25) NOT NULL,
    `cognoms` VARCHAR(75),
    `adreca` VARCHAR(100),
    `codi_postal` VARCHAR(10),
    `municipi` VARCHAR(50),
    `provincia` VARCHAR(50),
    `telefon` VARCHAR(20)
);

CREATE TABLE `pizzeria`.`botiga` (
    `botigaID` INT PRIMARY KEY AUTO_INCREMENT,
    `adreca` VARCHAR(100),
    `codi_postal` VARCHAR(10),
    `municipi` VARCHAR(50),
    `provincia` VARCHAR(50)
);

CREATE TABLE `pizzeria`.`empleat` (
    `empleatID` INT PRIMARY KEY AUTO_INCREMENT,
    `nom` VARCHAR(25) NOT NULL,
    `cognoms` VARCHAR(75),
    `NIF` VARCHAR(15),
    `telefon` VARCHAR(20),
    `posicio` ENUM('cuiner', 'repartidor'),
    `botiga` INT,
    CONSTRAINT `FK_Botiga_Empleat` FOREIGN KEY (`botiga`) REFERENCES `botiga` (`botigaID`)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE `pizzeria`.`categoria` (
    `categoriaID` INT PRIMARY KEY AUTO_INCREMENT,
    `nom` VARCHAR(50)
);

CREATE TABLE `pizzeria`.`producte` (
    `producteID` INT PRIMARY KEY AUTO_INCREMENT,
    `nom` VARCHAR(100) NOT NULL,
    `tipus` ENUM('pizza', 'hamburguesa', 'beguda'),
    `descripcio` TEXT,
    `categoria` INT DEFAULT NULL,
    `imatge` BLOB,
    `preu` DOUBLE(6,2),
    CONSTRAINT `FK_Categoria_Producte` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`categoriaID`)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE `pizzeria`.`comanda` (
    `comandaID` INT PRIMARY KEY AUTO_INCREMENT,
    `client` INT,
    `datahora` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `domicili` BOOLEAN NOT NULL DEFAULT 0,
    `repartidor` INT DEFAULT NULL,
    `preu` DOUBLE(6,2),
    `botiga` INT,
    CONSTRAINT `FK_Client_Comanda` FOREIGN KEY (`client`) REFERENCES `client` (`clientID`)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT `FK_Repartidor_Comanda` FOREIGN KEY (`repartidor`) REFERENCES `empleat` (`empleatID`)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT `FK_Botiga_Comanda` FOREIGN KEY (`botiga`) REFERENCES `botiga` (`botigaID`)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE `pizzeria`.`comanda_producte` (
    `comanda` INT,
    `producte` INT,
    `quantitat` TINYINT,
    PRIMARY KEY (`comanda`, `producte`),
    CONSTRAINT `FK_Comanda_ComPrd` FOREIGN KEY (`comanda`) REFERENCES `comanda` (`comandaID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Producte_ComPrd` FOREIGN KEY (`producte`) REFERENCES `producte` (`producteID`)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

/*Inserts per testejar*/
INSERT INTO `pizzeria`.`client` (clientID, nom, cognoms, adreca, codi_postal, municipi, provincia, telefon) VALUES
    (1, 'Oriol', 'Sastre Rienitz', 'Plaça Catalunya 1 1er 3a', '08040', 'Barcelona', 'Barcelona', '930010101'),
    (2, 'Pere', 'de la Cullera', 'Plaça Sant Jaume 2, 3er 4a', '08041', 'Barcelona', 'Barcelona', '930010102'),
    (3, 'Laura', 'Roig i Creus', 'Carrer del Gorg Negre 7', '08956', 'Gaulba', 'Barcelona', '93456789');
INSERT INTO `pizzeria`.`botiga` (botigaID, adreca, codi_postal, municipi, provincia) VALUES
    (1, 'Carrer de General Prim 2', '08955', 'Sant Celoni', 'Barcelona'),
    (2, 'Carrer de Melcior de Palau 161', '08040', 'Barcelona', 'Barcelona');

INSERT INTO `pizzeria`.`empleat` (empleatID, nom, cognoms, NIF, telefon, posicio, botiga) VALUES
    (1, 'Carles', 'de la Fuente Cambray', '58745211O', '009563210102', 'cuiner', 1),
    (2, 'Anna', 'Alfageme Alcalà', '12378956P', '934521699', 'repartidor', 1),
    (3, 'Rosa', 'Calabona Pom', 'X-9652111-I', NULL, 'cuiner', 2),
    (4, 'Maike', 'Schroeder', '1299874-DE', '+49015751436859', 'repartidor', 2);

INSERT INTO `pizzeria`.`categoria` (categoriaID, nom) VALUES
    (1, 'Clàssics'),
    (2, 'New Age');
INSERT INTO `pizzeria`.`producte` (producteID, nom, tipus, descripcio, imatge, categoria, preu) VALUES
    (1, 'BeefHQ', 'hamburguesa', 'La recepta tradicional del Far West, portada directament a casa teva, amb totes les aromes. \n Sigues el primer en descobrir-la!', NULL, NULL, 5.99),
    (2, 'GasTrina llimona 0.75L', 'beguda', 'Beguda refrescant amb gust a llimona.', NULL, NULL, 1.25),
    (3, 'GasTrina mango 0.75L', 'beguda', 'Beguda refrescant amb gust a mango.', NULL, NULL, 1.25),
    (4, 'Quatre Estacions', 'pizza', 'La Pizza per excel·lència que va inspirar Vivaldi. Amb la recepta toscana de tota la vida, amb la millor massa i en forn de fusta d\'olivera.', NULL, 1, 7.99),
    (5, 'Quatre Formatges', 'pizza', 'Pels més gourmets de la casa. Feta amb mozzarella, gouda, feta, rocafort, emmental i babibel, la pizza 4 formatges és la favorita dels italians.', NULL, 1, 7.99),
    (6, 'Hawaiana', 'pizza', 'La Pizza més polèmica. Pinya sí? Pinya no? Sigues tu mateix el jutge! Atreveix-t\'hi!', NULL, 2, 7.99);

INSERT INTO `pizzeria`.`comanda` (comandaID, client, domicili, repartidor, preu, botiga) VALUES
    (1, 3, 0, NULL, 9.24, 1),
    (2, 1, 1, 4, 16.48, 2),
    (3, 3, 1, 2, 15.98, 1),
    (4, 2, 0, NULL, 5.99, 2);

INSERT INTO `pizzeria`.`comanda_producte` (comanda, producte, quantitat) VALUES
    (1,6,1),
    (1,3,1),
    (2,5,1),
    (2,1,1),
    (2,2,2),
    (3,4,2),
    (4,1,1);