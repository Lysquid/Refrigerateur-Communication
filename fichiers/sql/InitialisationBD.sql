DELETE FROM Mesure;
DELETE FROM Capteur;
DELETE FROM TypeMesure;
INSERT INTO TypeMesure
VALUES ("température", "°C");
INSERT INTO TypeMesure
VALUES ("humidité", "%");
INSERT INTO TypeMesure
VALUES ("NH3", "ppm");
INSERT INTO TypeMesure
VALUES ("CO", "ppm");
INSERT INTO TypeMesure
VALUES ("NO2", "ppm");
INSERT INTO TypeMesure
VALUES ("C3H8", "ppm");
INSERT INTO TypeMesure
VALUES ("C4H10", "ppm");
INSERT INTO TypeMesure
VALUES ("CH4", "ppm");
INSERT INTO TypeMesure
VALUES ("H2", "ppm");
INSERT INTO TypeMesure
VALUES ("C2H5OH", "ppm");
INSERT INTO Capteur
VALUES ("thermistance", "température", NULL);
INSERT INTO Capteur
VALUES ("humidite", "humidité", NULL);
INSERT INTO Capteur
VALUES ("temperature2", "température", NULL);
INSERT INTO Capteur
VALUES ("gaz-NH3", "NH3", NULL);
INSERT INTO Capteur
VALUES ("gaz-CO", "CO", NULL);
INSERT INTO Capteur
VALUES ("gaz-NO2", "NO2", NULL);
INSERT INTO Capteur
VALUES ("gaz-C3H8", "C3H8", NULL);
INSERT INTO Capteur
VALUES ("gaz-C4H10", "C4H10", NULL);
INSERT INTO Capteur
VALUES ("gaz-CH4", "CH4", NULL);
INSERT INTO Capteur
VALUES ("gaz-H2", "H2", NULL);
INSERT INTO Capteur
VALUES ("gaz-C2H5OH", "C2H5OH", NULL);