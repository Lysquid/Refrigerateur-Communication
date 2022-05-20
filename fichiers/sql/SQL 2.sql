--Création des TypesMesures
INSERT INTO TypeMesure
VALUES(1, 'Temperature', '°C');
INSERT INTO TypeMesure
VALUES(2, 'Humidite', '%'); 

--Création CatégorieProduits
INSERT INTO CategorieProduit
VALUES (1, "Waters");
INSERT INTO CategorieProduit
VALUES(NULL, "Milks");
INSERT INTO CategorieProduit
VALUES(NULL, "Tomatoes");
INSERT INTO CategorieProduit
VALUES(NULL, "Sodas");
INSERT INTO CategorieProduit
VALUES(NULL, "Leaf salads");
INSERT INTO CategorieProduit
VALUES(NULL, "Eggs");
INSERT INTO CategorieProduit
VALUES(NULL, "Chocolates");
INSERT INTO CategorieProduit
VALUES(NULL, "Mayonnaises");
INSERT INTO CategorieProduit
VALUES(NULL, "Oysters");
INSERT INTO CategorieProduit
VALUES(NULL, "Leeks");
INSERT INTO CategorieProduit
VALUES(NULL, "Green beans");
INSERT INTO CategorieProduit
VALUES(NULL, "Cheeses");
INSERT INTO CategorieProduit
VALUES(NULL, "Meats");
INSERT INTO CategorieProduit
VALUES(NULL, "Pastries");
INSERT INTO CategorieProduit
VALUES(NULL, "Cakes");
INSERT INTO CategorieProduit
VALUES(NULL, "Puff pastry sheet");
INSERT INTO CategorieProduit
VALUES(NULL, "Fishes");
INSERT INTO CategorieProduit
VALUES(NULL, "Butters");
INSERT INTO CategorieProduit
VALUES(NULL, "Margarines");
INSERT INTO CategorieProduit
VALUES(NULL, "Mustards");

s
--Création Produits
INSERT INTO Produit
VALUES (3068320124827, "Eau minérale Evian", 1, 1);
INSERT INTO Produit
VALUES (8000500037560, "Kinder Bueno", 2, 1);

--Création Seuils
INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Milks'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    1,
    4
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Tomatoes'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    0,
    2
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Tomatoes'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Humidite'),
    5,
    8
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Sodas'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    3,
    7
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Leaf Salads'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    1,
    4
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Eggs'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    0,
    22
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Eggs'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Humidite'),
    35,
    45
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Chocolates'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    12,
    22
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Mayonnaises'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    0,
    4
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Oysters'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    2,
    15
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Leeks'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    0,
    6
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Green Beans'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    0,
    6
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Cheeses'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    6,
    8
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Cheeses'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Humidite'),
    85,
    95
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Meats'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    0,
    4
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Pastries'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    -1,
    5
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Cakes'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    -1,
    7
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Puff pastry sheet'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    4,
    6
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Fishes'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    0,
    4
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Butters'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    0,
    6
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Margarines'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    0,
    6
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Mustards'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    2,
    7
);

INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Waters'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    0,
    14
);