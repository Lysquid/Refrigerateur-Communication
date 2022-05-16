package fr.insalyon.p2i2.javaarduino.communicationBD;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
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

    // À adapter à votre BD
    private final String serveurBD = "fimi-bd-srv1.insa-lyon.fr";
    private final String portBD = "3306";
    private final String nomBD = "G221_A_BD1";
    private final String loginBD = "G221_A";
    private final String motdepasseBD = "G221_A";

    private Connection connection = null;
    private PreparedStatement insertMesureStatement = null;
    private PreparedStatement selectMesuresStatement = null;

    public Connection connexionBD() throws Exception {

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

            return connection;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new Exception("Erreur dans la méthode connexionBD()");
        }

    }

    public void creerRequetesParametrees() throws Exception {
        try {
            // À compléter
            this.insertMesureStatement = this.connection.prepareStatement("INSERT INTO Mesure"
                    + " (idCapteur, date, valeur)"
                    + " VALUES (?, ?, ?);");
            this.selectMesuresStatement = this.connection.prepareStatement("SELECT numInventaire, valeur, dateMesure"
                    + " FROM Mesure"
                    + " WHERE numInventaire = ?"
                    + " AND dateMesure > ?"
                    + " AND dateMesure < ?");
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
            throw new Exception("Erreur dans la méthode creerRequetesParametrees()");
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
            this.insertMesureStatement.setInt(1, numInventaire);
            this.insertMesureStatement.setDouble(2, valeur);
            this.insertMesureStatement.setTimestamp(3, new Timestamp(datetime.getTime())); // DATETIME
            return this.insertMesureStatement.executeUpdate();
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

                    break;

                case "codebarre":

                    break;

                default:
                    break;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void handleInfo(String capteur, String mesure) throws SQLException {

        PreparedStatement insertStatement = this.connection.prepareStatement("INSERT INTO Mesure"
                + " (idCapteur, date, valeur)"
                + " VALUES (?, ?, ?);");

        Date datetime = new Date();

        insertStatement.setInt(1, 1);
        insertStatement.setTimestamp(2, new Timestamp(datetime.getTime()));
        insertStatement.setFloat(3, Float.parseFloat(mesure));

    }
}
