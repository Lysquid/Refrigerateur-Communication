package fr.insalyon.p2i2.javaarduino.communicationBD;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class CommunicationBD {

    private final String serveurBD = "fimi-bd-srv1.insa-lyon.fr";
    private final String portBD = "3306";
    private final String nomBD = "G221_A_BD1";
    private final String loginBD = "G221_A";
    private final String motdepasseBD = "G221_A";

    private Connection connection = null;

    private PreparedStatement insertInfoStatement = null;
    private PreparedStatement insertPorteStatement = null;
    private PreparedStatement insertCodebarreStatement = null;
    private PreparedStatement updateProduitStatement = null;
    private PreparedStatement selectProduitStatement = null;

    private PreparedStatement selectMesuresStatement = null;

    public CommunicationBD() {

        try {
            // Enregistrement de la classe du driver par le driverManager
            // Class.forName("com.mysql.jdbc.Driver");
            // System.out.println("Driver trouvé...");
            // Création d'une connexion sur la base de donnée
            String urlJDBC = "jdbc:mysql://" + this.serveurBD + ":" + this.portBD + "/" + this.nomBD;
            urlJDBC += "?zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=Europe/Paris";

            System.out.println("Connexion à " + urlJDBC);
            this.connection = DriverManager.getConnection(urlJDBC, this.loginBD, this.motdepasseBD);

            System.out.println("Connexion établie...");

            // Requête de test pour lister les tables existantes dans les BDs MySQL
            PreparedStatement statement = this.connection.prepareStatement(
                    "SELECT table_schema, table_name"
                            + " FROM information_schema.tables"
                            + " WHERE table_schema NOT LIKE '%_schema' AND table_schema != 'mysql'"
                            + " ORDER BY table_schema, table_name");
            ResultSet result = statement.executeQuery();

            System.out.println("Liste des tables:");
            while (result.next()) {
                System.out.println("- " + result.getString("table_schema") + "." + result.getString("table_name"));
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            // throw new Exception("Erreur dans la méthode connexionBD()");
            System.exit(1);
        }

    }

    public void creerRequetesParametrees() {
        try {
            // À compléter
            insertInfoStatement = connection.prepareStatement("INSERT INTO Mesure"
                    + " VALUES (NULL, ?, ?, NOW());");
            insertPorteStatement = connection.prepareStatement("INSERT INTO OuverturePorte"
                    + " VALUES (NULL, ?, NOW());");
            insertCodebarreStatement = connection.prepareStatement("INSERT INTO CodeBarre"
                    + " VALUES (NULL, ?, ?, NOW());");
            updateProduitStatement = connection.prepareStatement("UPDATE Produit"
                    + " SET quantite = quantite + ?"
                    + " WHERE codeBarre = ?;");
            selectProduitStatement = connection.prepareStatement("SELECT COUNT(*)"
                    + " FROM Produit"
                    + " WHERE codeBarre = ?;");

            this.selectMesuresStatement = connection.prepareStatement("SELECT numInventaire, valeur, dateMesure"
                    + " FROM Mesure"
                    + " WHERE numInventaire = ?"
                    + " AND dateMesure > ?"
                    + " AND dateMesure < ?");
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
            System.exit(1);
        }
    }

    public void lireMesures(BufferedReader input) throws Exception {
        try {

            String line;

            while ((line = input.readLine()) != null) {
                String[] valeurs = line.split(";");
                if (valeurs.length > 1) {

                    // À compléter
                    Integer numInventaire = Integer.parseInt(valeurs[0]);
                    Double valeur = Double.parseDouble(valeurs[1]);
                    System.out.println("Le Capteur n°" + numInventaire + " a mesuré: " + valeur);

                    ajouterMesure(numInventaire, valeur, new Date());
                }
            }

        } catch (IOException ex) {
            ex.printStackTrace(System.err);
            throw new Exception("Erreur dans la méthode lireMesures()");
        }

    }

    public int ajouterMesure(int numInventaire, double valeur, Date datetime) {
        try {
            // À compléter
            this.insertInfoStatement.setInt(1, numInventaire);
            this.insertInfoStatement.setDouble(2, valeur);
            this.insertInfoStatement.setTimestamp(3, new Timestamp(datetime.getTime())); // DATETIME
            return this.insertInfoStatement.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
            return -1;
        }
    }

    public void ecrireMesures(PrintWriter output, int numInventaire, Date dateDebut, Date dateFin) throws Exception {

        try {

            // À compléter
            this.selectMesuresStatement.setInt(1, numInventaire);
            this.selectMesuresStatement.setTimestamp(2, new Timestamp(dateDebut.getTime()));
            this.selectMesuresStatement.setTimestamp(3, new Timestamp(dateFin.getTime()));
            ResultSet result = this.selectMesuresStatement.executeQuery();

            SimpleDateFormat formatDatePourCSV = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            DecimalFormat formatNombreDecimal = new DecimalFormat("0.00");
            formatNombreDecimal.setDecimalFormatSymbols(new DecimalFormatSymbols(Locale.ROOT));

            while (result.next()) {

                // À compléter

                Integer.toString(result.getInt("numInventaire"));
                String dateMesure = formatDatePourCSV.format(result.getTimestamp("dateMesure"));
                String valeur = formatNombreDecimal.format(result.getDouble("valeur"));
                output.println(Integer.toString(numInventaire) + ";"
                        + dateMesure + ";" + valeur);

            }

        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
            throw new Exception("Erreur dans la méthode ecrireMesures()");
        }
    }

    public void handleData(String line) {

        // String[] data = line.split(";");
        // int sensorid = Integer.parseInt(data[0]);
        // double value = Double.parseDouble(data[1]);
        // ...

        String[] data = line.split(";");
        String typePaquet = data[0];
        String capteur = data[1];
        String mesure = data[2];

        try {

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

        } catch (SQLException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }

    private void handleCodebarre(String mesure) throws SQLException {

        long codeBarre = Long.parseLong(mesure);

        selectProduitStatement.setLong(1, codeBarre);
        System.out.println(selectProduitStatement.toString());
        ResultSet result = selectProduitStatement.executeQuery();
        System.out.println(result.getInt(1));
        boolean produitExiste = result.getInt(0) == 1;

        Boolean ajout = true;

        if (!produitExiste) {
            // TODO : ajouter produit
        }

        updateProduitStatement.setInt(1, ajout ? 1 : -1);
        updateProduitStatement.setLong(2, codeBarre);
        System.out.println(updateProduitStatement.toString());
        updateProduitStatement.executeUpdate();

        insertCodebarreStatement.setLong(1, codeBarre);
        insertCodebarreStatement.setBoolean(2, ajout);
        System.out.println(insertCodebarreStatement);
        insertCodebarreStatement.executeUpdate();

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
