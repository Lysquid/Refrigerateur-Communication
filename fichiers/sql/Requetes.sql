--Récupération de la dernière date ligne de la table OuverturePorte

SELECT dateOuverture, porteOuverte
FROM OuverturePorte
ORDER BY dateOuverture DESC
LIMIT 0,1;

--Récupération des seuils correspondat au type du produit (? = Type du produit que l'on cherche)

SELECT seuilMax, seuilMin, nomTypeMesure
FROM Seuil, TypeMesure, CategorieProduit
WHERE Seuil.idTypeMesure = TypeMesure.idTypeMesure
AND Seuil.idCategorieProduit = CategorieProduit.idCategorieProduit
AND CategorieProduit.nomCategorieProduit = ?;

--Récupération des différentes seuils correspondant au type de mesure (? = Type de mesure que l'on cherche)

SELECT seuilMax, seuilMin, nomCategorieProduit
FROM Seuil, TypeMesure, CategorieProduit
WHERE Seuil.idTypeMesure = TypeMesure.idTypeMesure
AND Seuil.idCategorieProduit = CategorieProduit.idCategorieProduit
AND TypeMesure.nomTypeMesure = ?;

-- Affichage des produits et de leur quantité, correspondant à un code barre

SELECT CodeBarre.codeBarre, nomProduit, quantite
FROM CodeBarre, Produit
WHERE CodeBarre.codeBarre = Produit.codeBarre
GROUP BY CodeBarre.codeBarre;

-- pour un capteur donné, envoyer le type, la valeur et l’unité de la mesure sur un certaine période de temps

SELECT Capteur.nomCapteur, nomTypeMesure, valeur, unite, Mesure.dateMesure
FROM TypeMesure, Capteur, Mesure
WHERE TypeMesure.idTypeMesure = Capteur.idTypeMesure
AND Capteur.idCapteur = Mesure.idCapteur
AND Capteur.nomCapteur = ?
AND dateMesure > ?
AND dateMesure < ?;

-- pour récupérer la liste des produits dans le réfrigérateur et leur quantité

SELECT nomProduit, quantite
FROM Produit
WHERE quantite != 0;

-- Nom et Nombre des produits ajoutés ou retirés dans le réfrigérateur pendant un certain temps

SELECT nomProduit, Count(nomProduit)*quantite as nbProduitAjoute
FROM Produit, CodeBarre
WHERE Produit.codeBarre = CodeBarre.codeBarre
AND dateCodeBarre >= ?
AND dateCodeBarre <= ?
AND ajout = true
GROUP BY nomProduit
ORDER BY nomProduit;

-- Historique de flux sortant ou entrant dans le frigo

SELECT nomProduit, dateCodeBarre
FROM CodeBarre, Produit
WHERE Produit.codeBarre = CodeBarre.codeBarre
AND dateCodeBarre >= ?
AND dateCodeBarre <= ?
AND ajout = ?;

-- Historique complet des flux du frigo

SELECT nomProduit, dateCodeBarre, ajout
FROM CodeBarre, Produit
WHERE Produit.codeBarre = CodeBarre.codeBarre
AND dateCodeBarre >= ?
AND dateCodeBarre <= ?
ORDER BY dateCodeBarre ASC;

-- Moyenne sur un certain interval de temps, d'un produit retiré ou ajouté

SELECT nomProduit, (Count(nomProduit)*quantite)/(DATEDIFF(?,?)/?) as moyenneNombreProduit -- avec ? au dénominateur le nombre de jour de la moyenne que tu veux faire
FROM Produit, CodeBarre
WHERE Produit.codeBarre = CodeBarre.codeBarre
AND dateCodeBarre >= ?
AND dateCodeBarre <= ?
AND ajout = ?
GROUP BY nomProduit;

-- Moyenne sur un certain interval de temps d'un type de produit retiré ou ajouté

SELECT nomCategorieProduit, (Count(nomProduit))/(DATEDIFF(?,?)/?) as moyenneCategorieProduit -- avec le ? seul, le nombre de jour jour de jour de la moyenne que tu veux faire
FROM Produit, CodeBarre, CategorieProduit, AssociationCategorie
WHERE Produit.codeBarre = AssociationCategorie.codeBarre
AND Produit.codeBarre = CodeBarre.codeBarre
AND AssociationCategorie.idCategorieProduit = CategorieProduit.idCategorieProduit
AND dateCodeBarre >= ?
AND dateCodeBarre <= ?
AND ajout = ?
GROUP BY nomCategorieProduit;

-- Combien de fois le frigo est ouvert sur un certain interval de temps

SELECT COUNT(porteOuverte) as nombreOuverture
FROM OuverturePorte
WHERE porteOuverte = true
AND dateOuverture >= ?
AND dateOuverture <= ?;

-- Historique d'ouverture du frigo sur un certain interval de temps

SELECT porteOuverte, dateOuverture
FROM OuverturePorte
WHERE dateOuverture >= ?
AND dateOuverture <= ?;
