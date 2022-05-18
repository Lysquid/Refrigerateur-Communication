DELETE FROM Mesure;
DELETE FROM Capteur;
DELETE FROM TypeMesure;
INSERT INTO TypeMesure
VALUES (1, "température", "°C");
INSERT INTO TypeMesure
VALUES (2, "humidité", "%");
INSERT INTO TypeMesure
VALUES (3, "NH3", "ppm");
INSERT INTO TypeMesure
VALUES (4, "CO", "ppm");
INSERT INTO TypeMesure
VALUES (5, "NO2", "ppm");
INSERT INTO TypeMesure
VALUES (6, "C3H8", "ppm");
INSERT INTO TypeMesure
VALUES (7, "C4H10", "ppm");
INSERT INTO TypeMesure
VALUES (8, "CH4", "ppm");
INSERT INTO TypeMesure
VALUES (9, "H2", "ppm");
INSERT INTO TypeMesure
VALUES (10, "C2H5OH", "ppm");
INSERT INTO Capteur
VALUES (1, 1, "Thermistance", NOW());
INSERT INTO Capteur
VALUES (2, 2, "Humidité", NOW());
INSERT INTO Capteur
VALUES (3, 3, "Gaz NH3", NOW());
INSERT INTO Capteur
VALUES (4, 4, "Gaz CO", NOW());
INSERT INTO Capteur
VALUES (5, 5, "Gaz NO2", NOW());
INSERT INTO Capteur
VALUES (6, 6, "Gaz C3H8", NOW());
INSERT INTO Capteur
VALUES (7, 7, "Gaz C4H10", NOW());
INSERT INTO Capteur
VALUES (8, 8, "Gaz CH4", NOW());
INSERT INTO Capteur
VALUES (9, 9, "Gaz H2", NOW());
INSERT INTO Capteur
VALUES (10, 10, "Gaz C2H5OH", NOW());
INSERT INTO Capteur
VALUES (11, 1, "Température 2", NOW());