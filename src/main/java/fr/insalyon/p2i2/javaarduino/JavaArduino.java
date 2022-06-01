package fr.insalyon.p2i2.javaarduino;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;

import fr.insalyon.p2i2.javaarduino.communicationBD.CommunicationBD;
import fr.insalyon.p2i2.javaarduino.usb.ArduinoManager;
import fr.insalyon.p2i2.javaarduino.util.Console;

public class JavaArduino {

    public static void main(String[] args) {

        CommunicationBD communicationBD = new CommunicationBD();
        communicationBD.creerRequetesParametrees();
        insererCodebarres(communicationBD);

        // Objet matérialisant la console d'exécution (Affichage Écran / Lecture
        // Clavier)
        final Console console = new Console();

        // Affichage sur la console
        console.log("DÉBUT du programme TestArduino");

        console.log("TOUS les Ports COM Virtuels:");
        for (String port : ArduinoManager.listVirtualComPorts()) {
            console.log(" - " + port);
        }
        console.log("----");

        // Recherche d'un port disponible (avec une liste d'exceptions si besoin)
        String myPort = ArduinoManager.searchVirtualComPort("COM0", "/dev/tty.usbserial-FTUS8LMO", "<autre-exception>");

        console.log("CONNEXION au port " + myPort);

        ArduinoManager arduino = new ArduinoManager(myPort) {
            @Override
            protected void onData(String line) {

                // Cette méthode est appelée AUTOMATIQUEMENT lorsque l'Arduino envoie des
                // données
                // Affichage sur la Console de la ligne transmise par l'Arduino
                console.println("ARDUINO >> " + line);

                communicationBD.handleData(line);

            }

        };

        try {

            console.log("DÉMARRAGE de la connexion");
            // Connexion à l'Arduino
            arduino.start();

            console.log("BOUCLE infinie en attente du Clavier");
            // Boucle d'ecriture sur l'arduino (execution concurrente au thread)
            boolean exit = false;

            while (!exit) {

                // Lecture Clavier de la ligne saisie par l'Utilisateur
                String line = console.readLine("Envoyer une ligne (ou 'stop') > ");

                if (line.length() != 0) {

                    // Affichage sur l'écran
                    console.log("CLAVIER >> " + line);

                    // Test de sortie de boucle
                    exit = line.equalsIgnoreCase("stop");

                    if (!exit) {
                        // Envoi sur l'Arduino du texte saisi au Clavier
                        arduino.write(line);
                    }
                }
            }

            console.log("ARRÊT de la connexion");
            // Fin de la connexion à l'Arduino
            arduino.stop();

        } catch (IOException ex) {
            // Si un problème a eu lieu...
            console.log(ex);
        }

    }

    private static void insererCodebarres(CommunicationBD communicationBD) {
        try {
            if (communicationBD.isProduitEmpty()) {
                return;
            }
            FileInputStream file;
            String line;
            BufferedReader input;

            // Ajout
            file = new FileInputStream("./fichiers/input/codebarresAjout.txt");
            input = new BufferedReader(new InputStreamReader(file));
            while ((line = input.readLine()) != null) {
                if (line.length() > 0) {
                    String paquet = "codebarre;0;" + line;
                    System.out.println(paquet);
                    communicationBD.handleData(paquet);
                }
            }
            input.close();
            communicationBD.majQuantite(true);

            file = new FileInputStream("./fichiers/input/codebarresRetrait.txt");
            input = new BufferedReader(new InputStreamReader(file));
            while ((line = input.readLine()) != null) {
                if (line.length() > 0) {
                    String paquet = "codebarre;0;" + line;
                    System.out.println(paquet);
                    communicationBD.handleData(paquet);
                }
            }
            input.close();
            communicationBD.majQuantite(false);

        } catch (NumberFormatException | IOException | SQLException e) {
            e.printStackTrace();
        }
    }
}
