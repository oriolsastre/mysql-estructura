CREATE DATABASE 'optica';
CREATE TABLE IF NOT EXISTS 'adreca' (
    'id' INT PRIMARY KEY AUTO_INCREMENT,
    'carrer' VARCHAR(25) NOT NULL,
    'numero' SMALLINT UNSIGNED NOT NULL,
    'pis' TINYINT UNSIGNED,
    'porta' TINYINT UNSIGNED, //pot ser porta A, B? Alguna cosa així?
    'ciutat' VARCHAR(50) NOT NULL,
    'codipostal' VARCHAR(10), //codis postals estrangers?
    'pais' VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS 'client' (
    'id' INT PRIMARY KEY AUTO_INCREMENT,
    'nom' VARCHAR(25) NOT NULL,
    'cognoms' VARCHAR(50),
    'adreca' INT,
    'telefon' VARCHAR(20) //per tema prefixos, +00 i numeros estrangers llargs
    'email' VARCHAR(50) NULL,
    'data_registre' DATE,
    'recomanat' INT
    //afegir les FKs
);

CREATE TABLE IF NOT EXISTS 'proveidor' (
    'id' INT PRIMARY KEY AUTO_INCREMENT,
    'nom' VARCHAR(50),
    'adreca' INT,
    'telefon' VARCHAR(20),
    'fax' VARCHAR(20) NULL,
    'NIF' VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS 'marca' (
    'id' INT PRIMARY KEY AUTO_INCREMENT,
    'nom' VARCHAR(25) NOT NULL,
    'proveidor' INT NOT NULL
);

CREATE TABLE IF NOT EXISTS 'empleat' (
    'id' INT PRIMARY KEY AUTO_INCREMENT,
    'nom' VARCHAR(25) NOT NULL,
    'cognoms' VARCHAR(50)
)