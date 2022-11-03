DROP DATABASE IF EXISTS `youtube`;
CREATE DATABASE `youtube`;
USE `youtube`;

CREATE TABLE `youtube`.`pais` (
    paisID INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE `youtube`.`usuari` (
    usuariID INT PRIMARY KEY AUTO_INCREMENT,
    nom_usuari VARCHAR(10) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE,
    contrasenya CHAR(255) NOT NULL,
    data_naixement DATE,
    sexe TINYINT DEFAULT NULL,
    pais INT DEFAULT NULL,
    codi_posta VARCHAR(10) DEFAULT NULL,
    CONSTRAINT `FK_Pais_Usuari` FOREIGN KEY (`pais`) REFERENCES `pais` (`paisID`)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE `youtube`.`canal` (
    canalID INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    descripcio TEXT,
    data_creacio DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuari INT,
    CONSTRAINT `FK_Usuari_Canal` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `youtube`.`etiqueta` (
    etiquetaID INT PRIMARY KEY AUTO_INCREMENT,
    etiqueta VARCHAR(50) NOT NULL
);

CREATE TABLE `youtube`.`video` (
    videoID INT PRIMARY KEY AUTO_INCREMENT,
    titol VARCHAR(50) NOT NULL,
    descripcio TEXT,
    mida INT UNSIGNED NOT NULL COMMENT 'En bytes',
    nom_arxiu CHAR(255) NOT NULL COMMENT 'Nom generat per nosaltres amb algun hash o similar',
    durada_video MEDIUMINT UNSIGNED NOT NULL COMMENT 'En segons',
    thumbnail BLOB NOT NULL,
    reproduccions INT UNSIGNED NOT NULL DEFAULT 0,
    estat TINYINT(1) UNSIGNED DEFAULT 0 NOT NULL COMMENT '0 Públic, 1 Privat, 2 Ocult',
    usuari INT NOT NULL,
    canal INT NOT NULL,
    data_publicacio DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT `FK_Usuari_Video` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Canal_Video` FOREIGN KEY (`canal`) REFERENCES `canal` (`canalID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `youtube`.`video_etiqueta` (
    video INT,
    etiqueta INT,
    PRIMARY KEY (`video`,`etiqueta`),
    CONSTRAINT `FK_Video_VideoTag` FOREIGN KEY (`video`) REFERENCES `video` (`videoID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Etiqueta_VideoTag` FOREIGN KEY (`etiqueta`) REFERENCES `etiqueta` (`etiquetaID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `youtube`.`subscripcio` (
    usuari INT,
    canal INT,
    data_subscripcio DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (`usuari`, `canal`),
    CONSTRAINT `FK_Usuari_Sub` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Canal_Sub` FOREIGN KEY (`canal`) REFERENCES `canal` (`canalID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `youtube`.`llista` (
    llistaID INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    usuari INT,
    data_crecio DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    estat TINYINT UNSIGNED DEFAULT 0 NOT NULL COMMENT '0 Públic, 1 Privat, 2 Ocult',
    CONSTRAINT `FK_Usuari_Llista` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `youtube`.`llista_video` (
    llista INT,
    video INT,
    posicio SMALLINT UNSIGNED,
    PRIMARY KEY (`llista`, `video`),
    CONSTRAINT `FK_Llista_LlistaVideo` FOREIGN KEY (`llista`) REFERENCES `llista` (`llistaID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Video_LlistaVideo` FOREIGN KEY (`video`) REFERENCES `video` (`videoID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `youtube`.`comentari` (
    comentariID INT PRIMARY KEY AUTO_INCREMENT,
    usuari INT,
    video INT,
    comentari TEXT NOT NULL,
    data_comentari DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    resposta INT DEFAULT NULL,
    CONSTRAINT `FK_Usuari_Comentari` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Video_Comentari` FOREIGN KEY (`video`) REFERENCES `video` (`videoID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Resposta_Comentari` FOREIGN KEY (`resposta`) REFERENCES `comentari` (`comentariID`)
        ON UPDATE CASCADE ON DELETE RESTRICT
        /*COMMENT 'Un comentari no es pot eliminar si té respostes, però eliminar el contingut del comentari inicial i canviar-ho per [Eliminat].'*/
);

CREATE TABLE `youtube`.`like_video` (
    usuari INT,
    video INT,
    like_video TINYINT NOT NULL COMMENT'-1 dislike, 1 like. Així es pot sumar fàcilment.',
    datahora TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (`usuari`, `video`),
    CONSTRAINT `FK_Usuari_LikeVideo` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Video_LikeVideo` FOREIGN KEY (`video`) REFERENCES `video` (`videoID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `youtube`.`like_comentari` (
    usuari INT,
    comentari INT,
    like_comentari TINYINT NOT NULL COMMENT'-1 dislike, 1 like. Així es pot sumar fàcilment.',
    datahora TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (`usuari`, `comentari`),
    CONSTRAINT `FK_Usuari_LikeComent` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Video_LikeComent` FOREIGN KEY (`comentari`) REFERENCES `comentari` (`comentariID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);