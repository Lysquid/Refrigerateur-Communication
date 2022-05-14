drop table Seuil;
drop table CodeBarre;
drop table Produit;
drop table TypeProduit;
drop table Mesure;
drop table Capteur;
drop table TypeMesure;
drop table Ouverture;
create table Ouverture(
    idOuverture int(8) auto_increment,
    date DateTime not null,
    ouvert boolean not null,
    primary key (idOuverture)
);
create table TypeMesure(
    idTypeMesure int(8) auto_increment,
    typeMesure varchar(20) not null,
    unite varchar(20) not null,
    primary key (idTypeMesure)
);
create table Capteur(
    idCapteur int(8) auto_increment,
    idTypeMesure int(8) not null,
    dateInstallation Date not null,
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
create table TypeProduit(
    idTypeProduit int(8) auto_increment,
    typeProduit varchar(20) not null,
    primary key (idTypeProduit)
);
create table Produit(
    codeBarre int(13) not null,
    idTypeProduit int(8),
    quantite int,
    primary key(codeBarre),
    foreign key (idTypeProduit) references TypeProduit(idTypeProduit)
);
create table CodeBarre(
    idCodeBarre int(8) auto_increment,
    codeBarre int(13),
    date DateTime,
    ajout boolean,
    primary key (idCodeBarre),
    foreign key (codeBarre) references Produit(codeBarre)
);
create table Seuil(
    idTypeProduit int(8),
    idTypeMesure int(8) not null,
    seuilMin float not null,
    seuilMax float not null,
    primary key (idTypeProduit, idTypeMesure),
    foreign key (idTypeProduit) references TypeProduit(idTypeProduit),
    foreign key (idTypeMesure) references TypeMesure(idTypeMesure)
);