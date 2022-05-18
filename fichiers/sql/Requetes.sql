--Récupération de la dernière date ligne de la table OuverturePorte

SELECT date, porteOuverte
FROM OuverturePorte
LIMIT 0,1;

--Récupération des seuils correspondat au type du produit (? = Type du produit que l'on cherche)

SELECT seuilMax, seuilMin, nomTypeMesure
FROM Seuil, TypeMesure, CategorieProduit
WHERE Seuil.nomTypeMesure = TypeMesure.nomTypeMesure
AND Seuil.nomCategorieProduit = CategorieProduit.nomCategorieProduit
AND CategorieProduit.nomCategorieProduit = ?;

--Récupération des différentes seuils correspondant au type de mesure (? = Type de mesure que l'on cherche)

SELECT seuilMax, seuilMin, nomCategorieProduit
FROM Seuil, TypeMesure, CategorieProduit
WHERE Seuil.nomTypeMesure = TypeMesure.nomTypeMesure
AND Seuil.nomCategorieProduit = CategorieProduit.nomCategorieProduit
AND TypeMesure.nomTypeMesure = ?;

-- Affichage du produit et de sa quantité, correspondant à un code barre

SELECT idCodebarre, nomProduit, quantite
FROM CodeBarre, Produit
WHERE CodeBarre.codeBarre = Produit.codeBarre;

-- pour chaque capteur, envoyer le type, la valeur et l’unité de la mesure sur un certaine période de temps

SELECT Capteur.nomCapteur, nomTypeMesure, valeur, unite, Mesure.dateMesure
FROM TypeMesure, Capteur, Mesure
WHERE TypeMesure.nomTypeMesure = Capteur.nomTypeMesure
AND Capteur.nomCapteur = Mesure.nomCapteur
AND dateMesure < ?
AND dateMesure > ?;

-- pour récupérer la liste des produits dans le réfrigérateur et leur quantité

SELECT nomProduit, quantite
FROM Produit
WHERE quantite != 0;

-- Nombre de produit ajouté dans le réfrigérateur pendant ? temps

SELECT Count(nomProduit)*quantite as nbProduit
FROM Produit, CodeBarre
WHERE Produit.codeBarre = CodeBarre.codeBarre
AND dateCodeBarre >= ?
AND dateCodeBarre <= ?
AND ajout = true;

-- récupérer le nom des produits ajoutés pendant un certains temps
SELECT nomProduit, dateCodeBarre
FROM CodeBarre, Produit
WHERE Produit.codeBarre = CodeBarre.codeBarre
AND dateCodeBarre <= ?
AND dateCodeBarre >= ?
AND ajout = true;




