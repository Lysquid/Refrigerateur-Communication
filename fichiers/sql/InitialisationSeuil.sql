--Création des TypesMesures
INSERT INTO TypeMesure
VALUES(1, 'Temperature', '°C');
INSERT INTO TypeMesure
VALUES(2, 'Humidite', '%'); 

--Création CatégorieProduits
INSERT INTO CategorieProduit
VALUES (1, "Eaux");
INSERT INTO CategorieProduit
VALUES(2, "Laits");
INSERT INTO CategorieProduit
VALUES(3, "Tomates");
INSERT INTO CategorieProduit
VALUES(4, "Sodas");
INSERT INTO CategorieProduit
VALUES(5, "Salades vertes");
INSERT INTO CategorieProduit
VALUES(6, "Œufs");
INSERT INTO CategorieProduit
VALUES(7, "Chocolats");
INSERT INTO CategorieProduit
VALUES(8, "Mayonnaises");
INSERT INTO CategorieProduit
VALUES(9, "Huîtres");
INSERT INTO CategorieProduit
VALUES(10, "Poireaux");
INSERT INTO CategorieProduit
VALUES(11, "Haricots verts");
INSERT INTO CategorieProduit
VALUES(12, "Cheeses");
INSERT INTO CategorieProduit
VALUES(13, "Viandes");
INSERT INTO CategorieProduit
VALUES(14, "Pâtisseries");
INSERT INTO CategorieProduit
VALUES(15, "Gâteaux");
INSERT INTO CategorieProduit
VALUES(16, "Pâtes feuilletées");
INSERT INTO CategorieProduit
VALUES(17, "Poissons");
INSERT INTO CategorieProduit
VALUES(18, "Beurres");
INSERT INTO CategorieProduit
VALUES(19, "Margarines");
INSERT INTO CategorieProduit
VALUES(20, "Moutardes");

--Création Seuils
INSERT INTO Seuil 
VALUES(
    (SELECT idCategorieProduit
    FROM CategorieProduit
    WHERE nomCategorieProduit = 'Laits'),
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
    WHERE nomCategorieProduit = 'Tomates'),
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
    WHERE nomCategorieProduit = 'Tomates'),
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
    WHERE nomCategorieProduit = 'Salades vertes'),
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
    WHERE nomCategorieProduit = 'Œufs'),
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
    WHERE nomCategorieProduit = 'Œufs'),
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
    WHERE nomCategorieProduit = 'Chocolats'),
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
    WHERE nomCategorieProduit = 'Huîtres'),
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
    WHERE nomCategorieProduit = 'Poireaux'),
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
    WHERE nomCategorieProduit = 'Haricots verts'),
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
    WHERE nomCategorieProduit = 'Viandes'),
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
    WHERE nomCategorieProduit = 'Pâtisseries'),
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
    WHERE nomCategorieProduit = 'Gâteaux'),
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
    WHERE nomCategorieProduit = 'Pâtes feuilletées'),
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
    WHERE nomCategorieProduit = 'Poissons'),
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
    WHERE nomCategorieProduit = 'Beurres'),
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
    WHERE nomCategorieProduit = 'Moutardes'),
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
    WHERE nomCategorieProduit = 'Eaux'),
    (SELECT idTypeMesure
    FROM TypeMesure
    WHERE nomTypeMesure = 'Temperature'),
    0,
    14
);