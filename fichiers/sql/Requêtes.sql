--Récupération de la dernière date ligne de la table OuverturePorte

SELECT date, porteOuverte
FROM OuverturePorte
LIMIT 0,1;

--Récupération des seuils correspondat au type du produit (? = Type du produit que l'on cherche)

SELECT seuilMax, seuilMin, nomTypeMesure
FROM Seuil, TypeMesure, CategorieProduit
WHERE Seuil.idTypeMesure = TypeMesure.idTypeMesure
AND Seuil.idCategorieProduit = CategorieProduit.idCategorieProduit
AND CategorieProduit.nomCategorieProduit = ?;

--Récupération des différentes seuils correspondant au type de mesure

-- Affichage de la quantité d'un produit correspondant à un code barre
SELECT idCodebarre, nomProduit, quantite
FROM CodeBarre, Produit
WHERE CodeBarre.codeBarre = Produit.codeBarre;

-- pour chaque capteur, envoyer le type, la valeur et l’unité de la mesure sur un certaine période de temps
SELECT idCapteur, nomTypeMesure, valeur, unite, mesure.date
FROM TypeMesure, Capteur, Mesure
WHERE TypeMesure.idTypeMesure = Capteur.idTypeMesure
AND Capteur.idCapteur = Mesure.idCapteur
AND date < ?
AND date > ?;


