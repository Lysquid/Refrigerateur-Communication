DROP TABLE IF EXISTS Seuil;
DROP TABLE IF EXISTS CodeBarre;
DROP TABLE IF EXISTS Produit;
DROP TABLE IF EXISTS CategorieProduit;
DROP TABLE IF EXISTS Mesure;
DROP TABLE IF EXISTS Capteur;
DROP TABLE IF EXISTS TypeMesure;
DROP TABLE IF EXISTS OuverturePorte;
CREATE TABLE OuverturePorte(
    idOuverture INT(8) auto_increment,
    porteOuverte BOOLEAN NOT NULL,
    dateOuverture DATETIME NOT NULL,
    PRIMARY KEY (idOuverture)
);
CREATE TABLE TypeMesure(
    nomTypeMesure VARCHAR(20) NOT NULL,
    unite VARCHAR(20) NOT NULL,
    PRIMARY KEY (nomTypeMesure)
);
CREATE TABLE Capteur(
    nomCapteur VARCHAR(20) NOT NULL,
    nomTypeMesure VARCHAR(20) NOT NULL,
    dateInstallation DATE,
    PRIMARY KEY (nomCapteur),
    FOREIGN KEY (nomTypeMesure) REFERENCES TypeMesure(nomTypeMesure)
);
CREATE TABLE Mesure(
    idMesure INT(8) auto_increment,
    nomCapteur VARCHAR(20) NOT NULL,
    valeur FLOAT NOT NULL,
    dateMesure DATETIME NOT NULL,
    PRIMARY KEY (idMesure),
    FOREIGN KEY (nomCapteur) REFERENCES Capteur(nomCapteur)
);
CREATE TABLE CategorieProduit(
    nomCategorieProduit VARCHAR(20) NOT NULL,
    PRIMARY KEY (nomCategorieProduit)
);
CREATE TABLE Produit(
    codeBarre INT(13) NOT NULL,
    nomProduit VARCHAR(20),
    nomCategorieProduit VARCHAR(20),
    quantite INT NOT NULL,
    PRIMARY KEY (codeBarre),
    FOREIGN KEY (nomCategorieProduit) REFERENCES CategorieProduit(nomCategorieProduit)
);
CREATE TABLE CodeBarre(
    idCodeBarre INT(8) auto_increment,
    codeBarre INT(13) NOT NULL,
    ajout BOOLEAN NOT NULL,
    dateCodeBarre DATETIME NOT NULL,
    PRIMARY KEY (idCodeBarre),
    FOREIGN KEY (codeBarre) REFERENCES Produit(codeBarre)
);
CREATE TABLE Seuil(
    nomCategorieProduit VARCHAR(20) NOT NULL,
    nomTypeMesure VARCHAR(20) NOT NULL,
    seuilMin FLOAT,
    seuilMax FLOAT,
    PRIMARY KEY (nomCategorieProduit, nomTypeMesure),
    FOREIGN KEY (nomCategorieProduit) REFERENCES CategorieProduit(nomCategorieProduit),
    FOREIGN KEY (nomTypeMesure) REFERENCES TypeMesure(nomTypeMesure)
);