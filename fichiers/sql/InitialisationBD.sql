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
VALUES ("thermistance", "température", NOW());
INSERT INTO Capteur
VALUES ("humidite", "humidité", NOW());
INSERT INTO Capteur
VALUES ("temperature2", "température", NOW());
INSERT INTO Capteur
VALUES ("gaz-NH3", "NH3", NOW());
INSERT INTO Capteur
VALUES ("gaz-CO", "CO", NOW());
INSERT INTO Capteur
VALUES ("gaz-NO2", "NO2", NOW());
INSERT INTO Capteur
VALUES ("gaz-C3H8", "C3H8", NOW());
INSERT INTO Capteur
VALUES ("gaz-C4H10", "C4H10", NOW());
INSERT INTO Capteur
VALUES ("gaz-CH4", "CH4", NOW());
INSERT INTO Capteur
VALUES ("gaz-H2", "H2", NOW());
INSERT INTO Capteur
VALUES ("gaz-C2H5OH", "C2H5OH", NOW());