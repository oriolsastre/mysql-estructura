DROP DATABASE IF EXISTS `spotify`;
CREATE DATABASE `spotify`;
USE `spotify`;

CREATE TABLE `spotify`.`pais` (
    paisID INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE `spotify`.`usuari` (
    usuariID INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) UNIQUE NOT NULL,
    contrasenya CHAR(128) NOT NULL COMMENT 'Encriptar amb un hash de 128 bits en aquest cas',
    email VARCHAR(100) UNIQUE NOT NULL COMMENT 'Un email no pot gestionar més usuaris',
    data_naixement DATE COMMENT 'Si és null, sassumeix <18 anys per restriccions i tal',
    sexe TINYINT COMMENT '0 ns/nc, 1 home, 2 dona, 3 altres, 4,5,6, etc.',
    codi_postal VARCHAR(10),
    pais INT,
    premium BOOL COMMENT '0 free, 1 premium',
    CONSTRAINT `FK_Pais_Usuari` FOREIGN KEY (`pais`) REFERENCES `pais` (`paisID`)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE `spotify`.`artista` (
    artistaID INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    imatge BLOB
);

CREATE TABLE `spotify`.`artista_similar` (
    artista INT,
    similar INT,
    PRIMARY KEY (`artista`, `similar`),
    CONSTRAINT `FK_ArtistaSimilar_1` FOREIGN KEY (`artista`) REFERENCES `artista` (`artistaID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_ArtistaSimilar_2` FOREIGN KEY (`similar`) REFERENCES `artista` (`artistaID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `spotify`.`album` (
    albumID INT PRIMARY KEY AUTO_INCREMENT,
    titol VARCHAR(100) NOT NULL,
    any_publicacio YEAR,
    cover BLOB,
    artista INT NOT NULL,
    CONSTRAINT `FK_Artista_Album` FOREIGN KEY (`artista`) REFERENCES `artista` (`artistaID`)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE `spotify`.`canco` (
    cancoID INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    durada SMALLINT UNSIGNED NOT NULL COMMENT 'Durada en segons',
    reproduccions INT UNSIGNED NOT NULL DEFAULT 0,
    artista INT COMMENT 'Potser colabora un artista aliè en un album dun artista',
    album INT,
    CONSTRAINT `FK_Artista_Canco` FOREIGN KEY (`artista`) REFERENCES `artista` (`artistaID`)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `FK_Album_Canco` FOREIGN KEY (`album`) REFERENCES `album` (`albumID`)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE `spotify`.`fav_artista` (
    usuari INT,
    artista INT,
    PRIMARY KEY (`usuari`, `artista`),
    CONSTRAINT `FK_Usuari_FavArtista` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Artista_FavArtista` FOREIGN KEY (`artista`) REFERENCES `artista` (`artistaID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `spotify`.`fav_album` (
    usuari INT,
    album INT,
    PRIMARY KEY (`usuari`, `album`),
    CONSTRAINT `FK_Usuari_FavAlbum` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Artista_FavAlbum` FOREIGN KEY (`album`) REFERENCES `album` (`albumID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `spotify`.`fav_canco` (
    usuari INT,
    canco INT,
    PRIMARY KEY (`usuari`, `canco`),
    CONSTRAINT `FK_Usuari_FavCanco` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Artista_FavCanco` FOREIGN KEY (`canco`) REFERENCES `canco` (`cancoID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `spotify`.`playlist` (
    playlistID INT PRIMARY KEY AUTO_INCREMENT,
    usuari INT,
    titol VARCHAR(50) NOT NULL,
    num_canco SMALLINT UNSIGNED NOT NULL COMMENT 'Això es pot comprovar que sigui així, o es pot fer automatic.',
    data_creacio DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    actiu BOOL NOT NULL DEFAULT 1 COMMENT '0 ha estat borrada, 1 la llista és activa',
    data_eliminacio DATETIME DEFAULT NULL,
    CONSTRAINT `FK_Usuari_Playlist` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE SET NULL
    /*ON CASCADE SET NULL, ja que veiem que les playlists son col·laboratives i hi ha altra gent que potser hi participa i no cal que se li esborri.*/
);

CREATE TABLE `spotify`.`playlist_compartida` (
    playlist INT,
    usuari INT,
    PRIMARY KEY(`playlist`, `usuari`),
    CONSTRAINT `FK_Playlist_LlistaCompartida` FOREIGN KEY (`playlist`) REFERENCES `playlist` (`playlistID`)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `FK_Usuari_LlistaCompartida` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `spotify`.`canco_playlist` (
    playlist INT,
    canco INT,
    usuari INT,
    data_afegit DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    posicio INT UNSIGNED COMMENT 'Per ordenar les cançons a la Playlist',
    PRIMARY KEY (`playlist`, `canco`), /*Una cançó no es pot repetir en una mateixa playlist. Si es volgués fer, potser afegiria un camp que sigui cancoPlaylistID i fer-ho com a clau primària única.*/
    CONSTRAINT `FK_Playlist_CanPlay` FOREIGN KEY (`playlist`) REFERENCES `playlist` (`playlistID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Canco_CanPlay` FOREIGN KEY (`canco`) REFERENCES `canco` (`cancoID`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `FK_Usuari_CanPlay` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE SET NULL   
);

CREATE TABLE `spotify`.`subscripcio` (
    subscripcioID INT PRIMARY KEY AUTO_INCREMENT,
    usuari INT,
    data_inici DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    data_renovacio DATETIME ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `FK_Usuari_Subscripcio` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE `spotify`.`targeta` (
    targetaID INT PRIMARY KEY AUTO_INCREMENT,
    usuari INT NOT NULL,
    /* ---------- */
    numero VARCHAR(50) NOT NULL,
    data_caducitat DATE NOT NULL COMMENT 'Afegir com a dia 01 sense tenir-lo en compte',
    codi_seguretat VARCHAR(5) NOT NULL,
    /* Idealment aquestes dades potser haurien de ser guardades amb alguna encriptació? */
    CONSTRAINT `FK_Usuari_Targeta` FOREIGN KEY (`usuari`) REFERENCES `usuari` (`usuariID`)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `spotify`.`pagament` (
    pagamentID INT PRIMARY KEY NOT NULL,
    subscripcio INT NOT NULL,
    data_pagament DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metode TINYINT NOT NULL COMMENT '1 Targeta credit, 2 paypal, 3...',
    targeta INT,
    paypal VARCHAR(50),
    total DOUBLE NOT NULL,
    CONSTRAINT `FK_Subscripcio_Pagament` FOREIGN KEY (`subscripcio`) REFERENCES `subscripcio` (`subscripcioID`)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `FK_Targeta_Pagament` FOREIGN KEY (`targeta`) REFERENCES `targeta` (`targetaID`)
        ON UPDATE CASCADE ON DELETE SET NULL
);