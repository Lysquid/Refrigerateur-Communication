drop table Seuil;
drop table CodeBarre;
drop table Produit;
drop table CategorieProduit;
drop table Mesure;
drop table Capteur;
drop table TypeMesure;
drop table OuverturePorte;
create table OuverturePorte(
    idOuverturePorte int(8) auto_increment,
    date DateTime not null,
    porteOuverte boolean not null,
    primary key (idOuverturePorte)
);
create table TypeMesure(
    idTypeMesure int(8) auto_increment,
    nomTypeMesure varchar(20) not null,
    unite varchar(20) not null,
    primary key (idTypeMesure)
);
create table Capteur(
    idCapteur int(8) auto_increment,
    idTypeMesure int(8) not null,
    dateInstallation Date,
    primary key (idCapteur),
    foreign key (idTypeMesure) references TypeMesure(idTypeMesure)
);
create table Mesure(
    idMesure int(8) auto_increment,
    idCapteur int(8) not null,
    date DateTime not null,
    valeur float not null,
    primary key(idMesure),
    foreign key (idCapteur) references Capteur(idCapteur)
);
create table CategorieProduit(
    idCategorieProduit int(8) auto_increment,
    nomCategorieProduit varchar(20) not null,
    primary key (idCategorieProduit)
);
create table Produit(
    codeBarre int(13) not null,
    idCategorieProduit int(8),
    nomProduit varchar(20),
    quantite int not null,
    primary key(codeBarre),
    foreign key (idCategorieProduit) references CategorieProduit(idCategorieProduit)
);
create table CodeBarre(
    idCodeBarre int(8) auto_increment,
    codeBarre int(13) not null,
    date DateTime not null,
    ajout boolean not null,
    primary key (idCodeBarre),
    foreign key (codeBarre) references Produit(codeBarre)
);
create table Seuil(
    idCategorieProduit int(8) not null,
    idTypeMesure int(8) not null,
    seuilMin float,
    seuilMax float,
    primary key (idCategorieProduit, idTypeMesure),
    foreign key (idCategorieProduit) references CategorieProduit(idCategorieProduit),
    foreign key (idTypeMesure) references TypeMesure(idTypeMesure)
);