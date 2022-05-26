DROP TABLE IF EXISTS Seuil;
DROP TABLE IF EXISTS CodeBarre;
DROP TABLE IF EXISTS AssociationCategorie;
DROP TABLE IF EXISTS Produit;
DROP TABLE IF EXISTS CategorieProduit;
DROP TABLE IF EXISTS Mesure;
DROP TABLE IF EXISTS Capteur;
DROP TABLE IF EXISTS TypeMesure;
DROP TABLE IF EXISTS OuverturePorte;
CREATE TABLE OuverturePorte(
    idOuverture INT(8) AUTO_INCREMENT,
    porteOuverte BOOLEAN NOT NULL,
    dateOuverture DATETIME NOT NULL,
    PRIMARY KEY (idOuverture)
);
CREATE TABLE TypeMesure(
    idTypeMesure INT(8),
    nomTypeMesure VARCHAR(20) NOT NULL,
    unite VARCHAR(20) NOT NULL,
    PRIMARY KEY (idTypeMesure)
);
CREATE TABLE Capteur(
    idCapteur INT(8),
    idTypeMesure INT(8) NOT NULL,
    nomCapteur VARCHAR(20) NOT NULL,
    dateInstallation DATE,
    PRIMARY KEY (idCapteur),
    FOREIGN KEY (idTypeMesure) REFERENCES TypeMesure(idTypeMesure)
);
CREATE TABLE Mesure(
    idMesure INT(8) AUTO_INCREMENT,
    idCapteur INT(8) NOT NULL,
    valeur FLOAT NOT NULL,
    dateMesure DATETIME NOT NULL,
    PRIMARY KEY (idMesure),
    FOREIGN KEY (idCapteur) REFERENCES Capteur(idCapteur)
);
CREATE TABLE CategorieProduit(
    idCategorieProduit INT(8) AUTO_INCREMENT,
    nomCategorieProduit VARCHAR(100) NOT NULL,
    PRIMARY KEY (idCategorieProduit)
);
CREATE TABLE Produit(
    codeBarre BIGINT(13) NOT NULL,
    quantite INT NOT NULL,
    nomProduit VARCHAR(100),
    denomination VARCHAR(300),
    marque VARCHAR(50),
    imageURL VARCHAR(100),
    nutriscore VARCHAR(8),
    novascore INT(8),
    masse INT(8),
    energieKcal INT(8),
    energieKj INT(8),
    matieresGrasses FLOAT(8),
    acidesGrasSatures FLOAT(8),
    glucides FLOAT(8),
    sucres FLOAT(8),
    fibres FLOAT(8),
    proteines FLOAT(8),
    sel FLOAT(8),
    PRIMARY KEY (codeBarre)
);
CREATE TABLE AssociationCategorie(
    codeBarre BIGINT(13) NOT NULL,
    idCategorieProduit INT(8) NOT NULL,
    PRIMARY KEY (codeBarre, idCategorieProduit),
    FOREIGN KEY (idCategorieProduit) REFERENCES CategorieProduit(idCategorieProduit),
    FOREIGN KEY (codeBarre) REFERENCES Produit(codeBarre)
);
CREATE TABLE CodeBarre(
    idCodeBarre INT(8) AUTO_INCREMENT,
    codeBarre BIGINT(13) NOT NULL,
    ajout BOOLEAN,
    dateCodeBarre DATETIME NOT NULL,
    PRIMARY KEY (idCodeBarre),
    FOREIGN KEY (codeBarre) REFERENCES Produit(codeBarre)
);
CREATE TABLE Seuil(
    idCategorieProduit INT(8) AUTO_INCREMENT,
    idTypeMesure INT(8),
    seuilMin FLOAT,
    seuilMax FLOAT,
    PRIMARY KEY (idCategorieProduit, idTypeMesure),
    FOREIGN KEY (idCategorieProduit) REFERENCES CategorieProduit(idCategorieProduit),
    FOREIGN KEY (idTypeMesure) REFERENCES TypeMesure(idTypeMesure)
);