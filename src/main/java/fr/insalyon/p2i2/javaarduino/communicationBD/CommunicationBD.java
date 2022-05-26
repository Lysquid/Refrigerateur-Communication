package fr.insalyon.p2i2.javaarduino.communicationBD;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import pl.coderion.model.Nutriments;
import pl.coderion.model.Product;
import pl.coderion.model.ProductResponse;
import pl.coderion.service.OpenFoodFactsWrapper;
import pl.coderion.service.impl.OpenFoodFactsWrapperImpl;

public class CommunicationBD {

    private final String serveurBD = "fimi-bd-srv1.insa-lyon.fr";
    private final String portBD = "3306";
    private final String nomBD = "G221_A_BD1";
    private final String loginBD = "G221_A";
    private final String motdepasseBD = "G221_A";

    private Connection connection;
    private OpenFoodFactsWrapper foodWrapper;

    private PreparedStatement insertInfoStatement;
    private PreparedStatement insertPorteStatement;
    private PreparedStatement insertCodebarreStatement;
    private PreparedStatement updateProduitStatement;
    private PreparedStatement selectProduitStatement;
    private PreparedStatement insertProduitStatement;
    private PreparedStatement insertAssociationStatement;
    private PreparedStatement insertCategorieStatement;
    private PreparedStatement selectCategorieStatement;
    private PreparedStatement selectCodeBarreStatement;
    private PreparedStatement updateCodeBarreStatement;

    public CommunicationBD() {

        foodWrapper = new OpenFoodFactsWrapperImpl();

        try {
            // Création d'une connexion sur la base de donnée
            String urlJDBC = "jdbc:mysql://" + serveurBD + ":" + portBD + "/" + nomBD;
            urlJDBC += "?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=Europe/Paris";

            System.out.println("Connexion à " + urlJDBC);
            connection = DriverManager.getConnection(urlJDBC, loginBD, motdepasseBD);

            System.out.println("Connexion établie...");

            // Requête de test pour lister les tables existantes dans les BDs MySQL
            PreparedStatement statement = connection.prepareStatement(
                    "SELECT table_schema, table_name"
                            + " FROM information_schema.tables"
                            + " WHERE table_schema NOT LIKE '%_schema' AND table_schema != 'mysql'"
                            + " ORDER BY table_schema, table_name");
            ResultSet result = statement.executeQuery();

            System.out.println("Liste des tables:");
            while (result.next()) {
                if (result.getString("table_schema").contains("BD1")) {
                    System.out.println("- " + result.getString("table_name"));
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            System.exit(1);
        }

    }

    public void creerRequetesParametrees() {
        try {
            insertInfoStatement = connection.prepareStatement("INSERT INTO Mesure"
                    + " VALUES (NULL, ?, ?, NOW());");
            insertPorteStatement = connection.prepareStatement("INSERT INTO OuverturePorte"
                    + " VALUES (NULL, ?, NOW());");
            selectProduitStatement = connection.prepareStatement("SELECT codeBarre"
                    + " FROM Produit"
                    + " WHERE codeBarre = ?;");
            insertProduitStatement = connection.prepareStatement("INSERT INTO Produit"
                    + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
            selectCategorieStatement = connection.prepareStatement("SELECT idCategorieProduit"
                    + " FROM CategorieProduit"
                    + " WHERE nomCategorieProduit = ?;");
            insertCategorieStatement = connection.prepareStatement("INSERT INTO CategorieProduit"
                    + " VALUES (NULL, ?);");
            insertAssociationStatement = connection.prepareStatement("INSERT INTO AssociationCategorie"
                    + " VALUES (?, ?);");
            insertCodebarreStatement = connection.prepareStatement("INSERT INTO CodeBarre"
                    + " VALUES (NULL, ?, NULL, NOW());");
            selectCodeBarreStatement = connection.prepareStatement("SELECT codeBarre"
                    + " FROM CodeBarre"
                    + " WHERE ajout IS NULL;");
            updateProduitStatement = connection.prepareStatement("UPDATE Produit"
                    + " SET quantite = quantite + ?"
                    + " WHERE codeBarre = ?;");
            updateCodeBarreStatement = connection.prepareStatement("UPDATE CodeBarre"
                    + " SET ajout = ?"
                    + " WHERE ajout IS NULL;");

        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
            System.exit(1);
        }
    }

    public void handleData(String line) {

        try {
            String[] data = line.split(";");
            String typePaquet = data[0];
            String capteur = data[1];
            String mesure = data[2];

            switch (typePaquet) {
                case "info":
                    handleInfo(capteur, mesure);
                    break;

                case "porte":
                    handlePorte(mesure);
                    break;

                case "codebarre":
                    handleCodebarre(mesure);
                    break;

                default:
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void handleCodebarre(String mesure) throws SQLException {
        long codeBarre;
        try {
            codeBarre = Long.parseLong(mesure);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return;
        }

        selectProduitStatement.setLong(1, codeBarre);
        System.out.println(selectProduitStatement.toString());
        ResultSet resultProduit = selectProduitStatement.executeQuery();
        boolean produitExiste = resultProduit.next();

        if (!produitExiste) {

            ProductResponse productResponse = foodWrapper.fetchProductByCode(String.valueOf(codeBarre));
            Product product = productResponse.getProduct();

            if (!productResponse.isStatus()) {
                System.out.println("Status: " + productResponse.getStatusVerbose());
                return;
            }

            Nutriments nutriments = product.getNutriments();

            insertProduitStatement.setLong(1, codeBarre);
            insertProduitStatement.setInt(2, 0);
            insertProduitStatement.setString(3, product.getProductName());
            insertProduitStatement.setString(4, product.getGenericName());
            insertProduitStatement.setString(5, product.getBrands());
            insertProduitStatement.setString(6, product.getImageSmallUrl());
            insertProduitStatement.setString(7, product.getNutritionGrades());
            try {
                insertProduitStatement.setInt(8, Integer.valueOf(product.getNovaGroup()));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            // TODO : Parser le grammage / litrage
            // insertProduitStatement.setInt(9, product.getQuantity());
            insertProduitStatement.setNull(9, 0);
            insertProduitStatement.setInt(10, nutriments.getEnergyKj());
            insertProduitStatement.setInt(11, nutriments.getEnergyKcal());
            insertProduitStatement.setFloat(12, nutriments.getFat());
            insertProduitStatement.setFloat(13, nutriments.getSaturatedFat());
            insertProduitStatement.setFloat(14, nutriments.getCarbohydrates());
            insertProduitStatement.setFloat(15, nutriments.getSugars());
            insertProduitStatement.setFloat(16, nutriments.getFiber());
            insertProduitStatement.setFloat(17, nutriments.getProteins());
            insertProduitStatement.setFloat(18, nutriments.getSalt());

            System.out.println(insertProduitStatement);
            insertProduitStatement.executeUpdate();

            String[] categories = product.getCategories().split(",");

            for (String categorie : categories) {

                if (categorie.startsWith(" ")) {
                    categorie = categorie.substring(1);
                }
                if (categorie.startsWith("fr:")) {
                    categorie = categorie.substring(3, 4).toUpperCase() + categorie.substring(4);
                } else if (categorie.startsWith("en:")) {
                    continue;
                }

                selectCategorieStatement.setString(1, categorie);
                System.out.println(selectCategorieStatement);
                ResultSet resultCategorie = selectCategorieStatement.executeQuery();

                if (!resultCategorie.next()) {
                    insertCategorieStatement.setString(1, categorie);
                    System.out.println(insertCategorieStatement);
                    insertCategorieStatement.executeUpdate();
                }

                System.out.println(selectCategorieStatement);
                resultCategorie = selectCategorieStatement.executeQuery();
                resultCategorie.next();
                int idCategorieProduit = resultCategorie.getInt(1);

                insertAssociationStatement.setLong(1, codeBarre);
                insertAssociationStatement.setInt(2, idCategorieProduit);
                System.out.println(insertAssociationStatement);
                insertAssociationStatement.executeUpdate();

            }

        }

        insertCodebarreStatement.setLong(1, codeBarre);
        System.out.println(insertCodebarreStatement);
        insertCodebarreStatement.executeUpdate();

        majQuantite(true);

    }

    private void majQuantite(boolean ajout) throws SQLException {
        ResultSet result = selectCodeBarreStatement.executeQuery();

        while (result.next()) {
            long codeBarre = result.getLong(1);

            updateProduitStatement.setInt(1, ajout ? 1 : -1);
            updateProduitStatement.setLong(2, codeBarre);
            System.out.println(updateProduitStatement.toString());
            updateProduitStatement.executeUpdate();
        }

        updateCodeBarreStatement.setBoolean(1, ajout);
        System.out.println(updateCodeBarreStatement);
        updateCodeBarreStatement.executeUpdate();

    }

    private void handlePorte(String mesure) throws SQLException {

        insertPorteStatement.setInt(1, Integer.parseInt(mesure));
        System.out.println(insertPorteStatement);
        insertPorteStatement.executeUpdate();

    }

    private void handleInfo(String capteur, String mesure) throws SQLException {
        insertInfoStatement.setInt(1, Integer.valueOf(capteur));
        insertInfoStatement.setDouble(2, Double.valueOf(mesure));
        System.out.println(insertInfoStatement);
        insertInfoStatement.executeUpdate();
    }
}
