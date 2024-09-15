import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridBagLayout;
import java.awt.Image;
import java.util.List;
import java.util.Vector;

import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JScrollPane;
import javax.swing.JTextField;
import javax.swing.border.Border;
import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.JComponent;
import javax.swing.JComboBox;
import javax.swing.JLayeredPane;
import java.awt.Component;
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Insets;
import java.awt.GridBagConstraints;
import java.awt.Color;



import data.*;

public class View {

    public static void databaseLoginPage() {
        final var loginFrame = new JFrame();
        loginFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        loginFrame.setSize(400, 300);
        
        final var mainLoginPanel = new JPanel();
        mainLoginPanel.setLayout(new BoxLayout(mainLoginPanel, BoxLayout.Y_AXIS));

        final var usernameLabelPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        usernameLabelPanel.add(new JLabel("Username:"));
        mainLoginPanel.add(usernameLabelPanel);

        final var usernamePanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        final var username = new JTextField(30);
        usernamePanel.add(username);
        mainLoginPanel.add(usernamePanel);

        final var passwordLabelPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        passwordLabelPanel.add(new JLabel("Password:"));
        mainLoginPanel.add(passwordLabelPanel);

        final var passwordPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        final var password = new JPasswordField(30);
        passwordPanel.add(password);
        mainLoginPanel.add(passwordPanel);

        final var goPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        final var go = new JButton("login");
        go.addActionListener(e -> {
            loginFrame.setVisible(false);
            Main.handleLoginData(username.getText(), String.valueOf(password.getPassword()));
        });
        goPanel.add(go);
        mainLoginPanel.add(goPanel);

        loginFrame.setContentPane(mainLoginPanel);
        loginFrame.setVisible(true);
    }

    public static void loginDataError() {
        final var errorFrame = new JFrame();
        errorFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        errorFrame.setSize(400, 300);

        final var mainErrorPanel = new JPanel();
        mainErrorPanel.setLayout(new BoxLayout(mainErrorPanel, BoxLayout.Y_AXIS));

        final var messagePanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        messagePanel.add(new JLabel("Errore nei dati di login"));
        mainErrorPanel.add(messagePanel);

        final var goBackPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        final var goBack = new JButton("Riprova");
        goBack.addActionListener(e -> {
            errorFrame.setVisible(false);
            View.databaseLoginPage();
        });
        goBackPanel.add(goBack);
        mainErrorPanel.add(goBackPanel);

        errorFrame.setContentPane(mainErrorPanel);
        errorFrame.setVisible(true);
    }

    private Controller controller;
    private final JFrame frame;

    View(Runnable onClose) {
        this.frame = this.createFrame("Federazione Italiana Golf");
        this.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    private JButton playerHome(Tesserati tesserato) {
        final var button = new JButton("Torna alla zona tesserati");
        button.addActionListener(e -> {
            this.playerPage(tesserato);
            frame.validate();
        });
        return button;
    }

    private JButton adminHome() {
        final var button = new JButton("Torna alla zona amministratore");
        button.addActionListener(e -> {
            this.adminPage();
            frame.validate();
        });
        return button;
    }

    private JButton clubHome(Circoli circolo) {
        final var button = new JButton("Torna alla zona circoli");
        button.addActionListener(e -> {
            this.clubPage(circolo);
            frame.validate();
        });
        return button;
    }

    private JButton guestHome() {
        final var button = new JButton("Torna alla zona ospiti");
        button.addActionListener(e -> {
            this.guestPage();
            frame.validate();
        });
        return button;
    }

    private JButton home() {
        final var button = new JButton("Torna alla Home");
        button.addActionListener(e -> {
            controller.homePage();
            frame.validate();
        });
        return button;
    }

    public void setController(Controller controller) {
        this.controller = controller;
    }

    private JFrame createFrame(String title) {
        return new JFrame(title);
    }

    public void homePage() {
        final var mainPanel = new JPanel();
        final var padding = BorderFactory.createEmptyBorder(150, 300, 150, 300);

        mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));

        
        final var adminPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        final var clubPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        final var playerPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        final var guestPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        

        var adminLogin = new JButton("Area Riservata Amministratore");
        var clubLogin = new JButton("Area Riservata Circoli");
        var playerLogin = new JButton("Area Riservata Giocatori");
        var guestLogin = new JButton("Area Ospite");
        // modifiche giuli
        var homeButton = new JButton("Torna alla Home");
        
        Color buttonBackgroundColor = new Color(70, 130, 210); // Colore di sfondo blu 
        Color buttonTextColor = Color.WHITE; // Colore del testo bianco


        adminLogin.setBackground(buttonBackgroundColor);
        adminLogin.setForeground(buttonTextColor);
        clubLogin.setBackground(buttonBackgroundColor);
        clubLogin.setForeground(buttonTextColor);
        playerLogin.setBackground(buttonBackgroundColor);
        playerLogin.setForeground(buttonTextColor);
        guestLogin.setBackground(buttonBackgroundColor);
        guestLogin.setForeground(buttonTextColor);
        homeButton.setBackground(buttonBackgroundColor);
        homeButton.setForeground(buttonTextColor);
    


        adminLogin.addActionListener(e -> {
            controller.adminLoginClicked();
            frame.validate();
        });
        clubLogin.addActionListener(e -> {
            controller.clubLoginClicked();
            frame.validate();
        });
        playerLogin.addActionListener(e -> {
            controller.playerLoginClicked();
            frame.validate();
        });
        guestLogin.addActionListener(e -> {
            controller.guestLoginClicked();
            frame.validate();
        });
        // modifiche giuli
        homeButton.addActionListener(e -> {
            controller.homePage();
            frame.validate();
        });

        
        adminPanel.add(adminLogin);
        clubPanel.add(clubLogin);
        playerPanel.add(playerLogin);
        guestPanel.add(guestLogin);

        adminPanel.setOpaque(false);
        clubPanel.setOpaque(false);
        playerPanel.setOpaque(false);
        guestPanel.setOpaque(false);

        mainPanel.add(adminPanel);
        mainPanel.add(clubPanel);
        mainPanel.add(playerPanel);
        mainPanel.add(guestPanel);

        frame.setContentPane(mainPanel);
        ((JComponent) frame.getContentPane()).setBorder(padding);
        frame.setSize(1000, 600);
        frame.setVisible(true);

        //String imagepath = "C:\\Users\\alber\\Desktop\\Progetto-Basi-di-Dati\\immagini\\2150978119.jpg";
        //setBackGroundImage(mainPanel, imagepath);
    }

    public void adminPage() {
        // aggiornamento Odm
        // Registrazione di un nuovo giocatore
        // Registrazione di un nuovo circolo
        // Gestione di un giocatore
        // Gestione di un circolo
        final JPanel adminHomePanel = new JPanel();
        adminHomePanel.setLayout(new GridBagLayout());
        

        var odmUpdate = new JButton("Aggiorna Ordine di Merito");
        var newPlayer = new JButton("Registra un nuovo tesserato");
        var newClub = new JButton("Registra un nuovo circolo");
        var updatePlayer = new JButton("Modifica il profilo di un tesserato");
        var homeButton = new JButton("Torna alla Home");

        
        odmUpdate.setAlignmentX(Component.CENTER_ALIGNMENT);
        newPlayer.setAlignmentX(Component.CENTER_ALIGNMENT);
        newClub.setAlignmentX(Component.CENTER_ALIGNMENT);
        updatePlayer.setAlignmentX(Component.CENTER_ALIGNMENT);
        homeButton.setAlignmentX(Component.CENTER_ALIGNMENT);
        

        
        adminHomePanel.add(odmUpdate);
        adminHomePanel.add(newPlayer);
        adminHomePanel.add(newClub);
        adminHomePanel.add(updatePlayer);
        adminHomePanel.add(homeButton);
        

    
        Color buttonBackgroundColor = new Color(70, 130, 210); // Colore di sfondo blu 
        Color buttonTextColor = Color.WHITE; // Colore del testo bianco


        odmUpdate.setBackground(buttonBackgroundColor);
        odmUpdate.setForeground(buttonTextColor);
        newPlayer.setBackground(buttonBackgroundColor);
        newPlayer.setForeground(buttonTextColor);
        newClub.setBackground(buttonBackgroundColor);
        newClub.setForeground(buttonTextColor);
        updatePlayer.setBackground(buttonBackgroundColor);
        updatePlayer.setForeground(buttonTextColor);
        homeButton.setBackground(buttonBackgroundColor);
        homeButton.setForeground(buttonTextColor);

        
        // modifiche giuli

        homeButton.addActionListener(e -> {
            controller.homePage();
            frame.validate();
        });

        odmUpdate.addActionListener(e -> {
            controller.odmUpdateRequested();
            frame.validate();
        });
        newPlayer.addActionListener(e -> {
            controller.playerRegistrationRequested();
            frame.validate();
        });
        newClub.addActionListener(e -> {
            controller.clubRegistrationRequested();
            frame.validate();
        });
        updatePlayer.addActionListener(e -> {
            controller.playerUpdateRequested();
            frame.validate();
        });
       
         

        

         
        // Usa GridBagConstraints per centrare i pulsanti
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = 0;
        gbc.gridy = GridBagConstraints.RELATIVE;
        gbc.insets = new Insets(10, 0, 10, 0); // Spazi fissi tra i pulsanti
        gbc.anchor = GridBagConstraints.CENTER;
        gbc.fill = GridBagConstraints.HORIZONTAL; // Permette ai pulsanti di espandersi orizzontalmente se necessario

        gbc.gridy = 0;
        adminHomePanel.add(odmUpdate, gbc);
        
        gbc.gridy = 1;
        adminHomePanel.add(newPlayer, gbc);
        
        gbc.gridy = 2;
        adminHomePanel.add(newClub,gbc);
    
        gbc.gridy = 3;
        adminHomePanel.add(updatePlayer,gbc);
        
        gbc.gridy = 4;
        adminHomePanel.add(homeButton,gbc);
       
        

        frame.setContentPane(adminHomePanel);
        frame.setVisible(true);

        //String imagepath = "C:\\Users\\alber\\Desktop\\Progetto-Basi-di-Dati\\immagini\\2150978119.jpg";
        //setBackGroundImage(adminHomePanel, imagepath);
      
    }

    public void clubLoginPage() {
        final JPanel clubLoginPanel = new JPanel();
        clubLoginPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 10, 10));

        JTextField clubName = new JTextField("Inserire il nome del circolo", 20);
        JButton go = new JButton("Accedi");
        // modifiche giuli
        var homeButton = new JButton("Torna alla Home");

        homeButton.addActionListener(e -> {
            controller.homePage();
            frame.validate();
        });

        go.addActionListener(e -> {
            controller.clubLoginSubmitted(clubName.getText());
            frame.validate();
        });

        Color buttonBackgroundColor = new Color(70, 130, 210); // Colore di sfondo blu 
        Color buttonTextColor = Color.WHITE; // Colore del testo bianco
        homeButton.setBackground(buttonBackgroundColor);
        homeButton.setForeground(buttonTextColor);
        go.setBackground(buttonBackgroundColor);
        go.setForeground(buttonTextColor);

        clubLoginPanel.add(clubName);
        clubLoginPanel.add(go);
        clubLoginPanel.add(homeButton);

        JPanel outerPanel = new JPanel();
        outerPanel.setLayout(new BoxLayout(outerPanel, BoxLayout.Y_AXIS)); // Layout verticale
        outerPanel.add(Box.createVerticalGlue()); // Spazio flessibile sopra
        outerPanel.add(clubLoginPanel);
        outerPanel.add(Box.createVerticalGlue()); 

        frame.setContentPane(outerPanel);
    }

    public void playerLoginPage() {
        final JPanel playerLoginPanel = new JPanel();
        playerLoginPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 10, 10));

        JTextField playerNumber = new JTextField("Inserire il numero di tessera", 20);
        JButton go = new JButton("Accedi");
        // modifiche giuli
        var homeButton = new JButton("Torna alla Home");

        homeButton.addActionListener(e -> {
            controller.homePage();
            frame.validate();
        });

        go.addActionListener(e -> {
            controller.playerLoginSubmitted(playerNumber.getText());
            frame.validate();
        });

        Color buttonBackgroundColor = new Color(70, 130, 210); // Colore di sfondo blu 
        Color buttonTextColor = Color.WHITE; // Colore del testo bianco
        homeButton.setBackground(buttonBackgroundColor);
        homeButton.setForeground(buttonTextColor);
        go.setBackground(buttonBackgroundColor);
        go.setForeground(buttonTextColor);

        playerLoginPanel.add(playerNumber);
        playerLoginPanel.add(go);
        playerLoginPanel.add(homeButton);

        JPanel outerPanel = new JPanel();
        outerPanel.setLayout(new BoxLayout(outerPanel, BoxLayout.Y_AXIS)); // Layout verticale
        outerPanel.add(Box.createVerticalGlue()); // Spazio flessibile sopra
        outerPanel.add(playerLoginPanel);
        outerPanel.add(Box.createVerticalGlue()); 

        frame.setContentPane(outerPanel);
    }

    public void guestPage() {
        final var guestHomePanel = new JPanel();
        guestHomePanel.setLayout(new GridBagLayout());

        var odm = new JButton("Visualizza Ordine di Merito");
        var tourneys = new JButton("Visualizza le gare");
        var clubs = new JButton("Visualizza le informazioni relative ai circoli");
        // modifiche giuli
        var homeButton = new JButton("Torna alla Home");

        homeButton.addActionListener(e -> {
            controller.homePage();
            frame.validate();
        });
        odm.addActionListener(e -> {
            controller.odmRequested();
            frame.validate();
        });
        tourneys.addActionListener(e -> {
            controller.tournamentsRequested();
            frame.validate();
        });
        clubs.addActionListener(e -> {
            controller.clubInfoRequested();
            frame.validate();
        });

        guestHomePanel.add(odm);
        guestHomePanel.add(tourneys);
        guestHomePanel.add(clubs);
        guestHomePanel.add(homeButton);

        odm.setAlignmentX(Component.CENTER_ALIGNMENT);
        tourneys.setAlignmentX(Component.CENTER_ALIGNMENT);
        clubs.setAlignmentX(Component.CENTER_ALIGNMENT);
        homeButton.setAlignmentX(Component.CENTER_ALIGNMENT);

        var buttonBackgroundColor = new Color(70, 130, 210);
        var buttonTextColor = Color.WHITE;

        odm.setBackground(buttonBackgroundColor);
        odm.setForeground(buttonTextColor);
        tourneys.setBackground(buttonBackgroundColor);
        tourneys.setForeground(buttonTextColor);
        clubs.setBackground(buttonBackgroundColor);
        clubs.setForeground(buttonTextColor);
        homeButton.setBackground(buttonBackgroundColor);
        homeButton.setForeground(buttonTextColor);

        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = 0;
        gbc.gridy = GridBagConstraints.RELATIVE;
        gbc.insets = new Insets(10, 0, 10, 0);
        gbc.anchor = GridBagConstraints.CENTER;
        gbc.fill = GridBagConstraints.HORIZONTAL;

        gbc.gridy = 0;
        guestHomePanel.add(odm, gbc);
        gbc.gridy = 1;
        guestHomePanel.add(tourneys, gbc);
        gbc.gridy = 2;
        guestHomePanel.add(clubs, gbc);
        gbc.gridy = 3;
        guestHomePanel.add(homeButton, gbc);

        frame.setContentPane(guestHomePanel);
    }

    public void clubPage(Circoli circolo) {
        // Visualizza i propri tesserati
        // Registra nuovi tesserati
        // Registra nuove gare
        // Registra nuove nomine
        // Registra un nuovo percorso
        // Inserimento prenotazioni
        final var clubPanel = new JPanel();
        clubPanel.setLayout(new BoxLayout(clubPanel, BoxLayout.Y_AXIS));

        final var members = new JButton("Visualizza i soci");
        final var newMember = new JButton("Registra un nuovo socio");
        final var newTournament = new JButton("Pubblica una nuova gara");
        final var manageTournament = new JButton("Gestisci una gara");
        final var newCourse = new JButton("Registra un nuovo percorso");
        final var newTitle = new JButton("Affida una carica");
        final var bookings = new JButton("Visualizza le prenotazioni");
        final var newBooking = new JButton("Fissa una prenotazione");

        members.addActionListener(e -> {
            controller.getMemberList(circolo);
            frame.validate();
        });
        newMember.addActionListener(e -> {
            controller.memberAddition(circolo);
            frame.validate();
        });
        newTournament.addActionListener(e -> {
            controller.tournamentAddition(circolo);
            frame.validate();
        });
        manageTournament.addActionListener(e -> {
            controller.manageTournaments(circolo);
            frame.validate();
        });
        newCourse.addActionListener(e -> {
            controller.courseAddition(circolo);
            frame.validate();
        });
        newTitle.addActionListener(e -> {
            controller.titleAssignment(circolo);
            frame.validate();
        });
        bookings.addActionListener(e -> {
            controller.seeBookings(circolo);
            frame.validate();
        });
        newBooking.addActionListener(e -> {
            controller.bookingAddition(circolo);
            frame.validate();
        });

        clubPanel.add(members);
        clubPanel.add(newMember);
        clubPanel.add(newTitle);
        clubPanel.add(newTournament);
        clubPanel.add(manageTournament);
        clubPanel.add(newCourse);
        clubPanel.add(bookings);
        clubPanel.add(newBooking);
        clubPanel.add(this.home());
        frame.setContentPane(clubPanel);
    }

    public void playerPage(Tesserati tesserato) {
        // Visualizzare e iscriversi alle gare
        // Visualizzare le proprie statistiche
        // Aggiungere email - telefono - certificato medico
        final var playerPanel = new JPanel();
        playerPanel.setLayout(new BoxLayout(playerPanel, BoxLayout.Y_AXIS));

        final var tournamentSubscription = new JButton("Visualizza le gare e le iscrizioni");
        final var statsViewer = new JButton("Visualizza le statistiche personali");
        final var addData = new JButton("Registra nuovi dati");
        final var homeButton = new JButton("Torna alla Home");

        homeButton.addActionListener(e -> {
            controller.homePage();
            frame.validate();
        });
        tournamentSubscription.addActionListener(e -> {
            controller.getAvailableTournaments(tesserato);
            frame.validate();
        });
        statsViewer.addActionListener(e -> {
            controller.getPersonalStats(tesserato);
            frame.validate();
        });
        addData.addActionListener(e -> {
            this.dataAdditionPage(tesserato);
            frame.validate();
        });

        playerPanel.add(tournamentSubscription);
        playerPanel.add(statsViewer);
        playerPanel.add(addData);
        playerPanel.add(this.home());
        frame.setContentPane(playerPanel);
    }

    private void dataAdditionPage(Tesserati tesserato) {
        final var dataAdditionPanel = new JPanel();
        dataAdditionPanel.setLayout(new BoxLayout(dataAdditionPanel, BoxLayout.Y_AXIS));

        final var medicalRegistrationPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        medicalRegistrationPanel.add(new JLabel("Certificato medico: "));
        final var emissionDate = new JTextField("Data di emissione (formato YYYY-MM-DD)");
        medicalRegistrationPanel.add(emissionDate);
        final var recordMedical = new JButton("Registra il certificato");
        recordMedical.addActionListener(e -> {
            controller.recordMedical(emissionDate.getText(), tesserato);
            frame.validate();
        });
        medicalRegistrationPanel.add(recordMedical);

        final var mailRegistrationPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        mailRegistrationPanel.add(new JLabel("Email: "));
        final var mailAddress = new JTextField(30);
        mailRegistrationPanel.add(mailAddress);
        final var recordMail = new JButton("Registra la mail");
        recordMail.addActionListener(e -> {
            controller.recordMail(mailAddress.getText(), tesserato);
            frame.validate();
        });
        mailRegistrationPanel.add(recordMail);

        final var phoneRegistrationPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        phoneRegistrationPanel.add(new JLabel("Numero di telefono: "));
        final var phone = new JTextField(10);
        phoneRegistrationPanel.add(phone);
        final var recordPhone = new JButton("Registra il telefono");
        recordPhone.addActionListener(e -> {
            controller.recordPhone(phone.getText(), tesserato);
            frame.validate();
        });
        phoneRegistrationPanel.add(recordPhone);

        dataAdditionPanel.add(medicalRegistrationPanel);
        dataAdditionPanel.add(mailRegistrationPanel);
        dataAdditionPanel.add(phoneRegistrationPanel);
        dataAdditionPanel.add(this.playerHome(tesserato));
        frame.setContentPane(dataAdditionPanel);
    }

    public void showOrderOfMerit(List<Tesserati> odm) {
        final JPanel orderOfMeritPanel = new JPanel();
        orderOfMeritPanel.setLayout(new BoxLayout(orderOfMeritPanel, BoxLayout.Y_AXIS));

        for (var player : odm) {
            JPanel playerPanel = new JPanel();
            playerPanel.setLayout(new FlowLayout());
            playerPanel.add(new JLabel(player.getName()));
            playerPanel.add(new JLabel(player.getSurname()));
            playerPanel.add(new JLabel(String.valueOf(player.getOdMPoints())));

            orderOfMeritPanel.add(playerPanel);
        }

        orderOfMeritPanel.add(this.guestHome());
        frame.setContentPane(new JScrollPane(orderOfMeritPanel));
    }

    public void showTournamentList(List<Gare> tourneys) {
        JPanel tournamentListPanel = new JPanel();
        tournamentListPanel.setLayout(new BoxLayout(tournamentListPanel, BoxLayout.Y_AXIS));

        for (var elem : tourneys) {
            JPanel tournamentPanel = new JPanel();
            tournamentPanel.setLayout(new FlowLayout());

            tournamentPanel.add(new JLabel(elem.getNomeGara()));
            tournamentPanel.add(new JLabel(elem.getDataInizio().toString()));
            tournamentPanel.add(new JLabel(Integer.toString(elem.getDurata())));
            tournamentPanel.add(new JLabel(elem.getNomeCircolo()));
            tournamentPanel.add(new JLabel(elem.getNomePercorso()));
            tournamentPanel.add(new JLabel(elem.getDataChiusuraIscrizioni().toString()));
            tournamentPanel.add(new JLabel(Integer.toString(elem.getMaxIscritti())));
            tournamentPanel.add(new JLabel(elem.getCategoriaOdM()));
            tournamentPanel.add(new JLabel(elem.getCategoriaStatus()));
            tournamentPanel.add(new JLabel(Integer.toString(elem.getMaxIscritti())));

            final var listaIscritti = new JButton();
            if (controller.isOver(elem)) {
                listaIscritti.setText("Visualizza classifica");
                listaIscritti.addActionListener(e -> {
                    controller.getLeaderboard(elem);
                    frame.validate();
                });
            } else {
                listaIscritti.setText("Visualizza lista iscritti");
                listaIscritti.addActionListener(e -> {
                    controller.getEntryList(elem);
                    frame.validate();
                });
            }
            tournamentPanel.add(listaIscritti);

            tournamentListPanel.add(tournamentPanel);
        }

        tournamentListPanel.add(this.guestHome());
        frame.setContentPane(new JScrollPane(tournamentListPanel));
    }

    public void showClubInfo(List<Circoli> clubs) {
        final JPanel clubInfoPanel = new JPanel();
        clubInfoPanel.setLayout(new BoxLayout(clubInfoPanel, BoxLayout.Y_AXIS));

        for (var club : clubs) {
            final JPanel singleClubPanel = new JPanel();
            singleClubPanel.setLayout(new BoxLayout(singleClubPanel, BoxLayout.Y_AXIS));

            singleClubPanel.add(new JLabel(club.getNomeCircolo()));
            singleClubPanel.add(new JLabel(club.getIndirizzo()));

            for (var course : club.getPercorsi()) {
                final JPanel singleCoursePanel = new JPanel();
                singleCoursePanel.setLayout(new FlowLayout());

                singleCoursePanel.add(new JLabel(course.getNomePercorso()));
                singleCoursePanel.add(new JLabel(Integer.toString(course.getPar())));
                singleCoursePanel.add(new JLabel(Float.toString(course.getCourseRating())));

                singleClubPanel.add(singleCoursePanel);
            }

            clubInfoPanel.add(singleClubPanel);
        }

        clubInfoPanel.add(this.guestHome());
        frame.setContentPane(new JScrollPane(clubInfoPanel));
    }

    public void playerRegistrationPage() {
        final JPanel playerDataPanel = new JPanel();
        playerDataPanel.setLayout(new BoxLayout(playerDataPanel, BoxLayout.Y_AXIS));

        final JTextField name = new JTextField("Nome");
        final var surname = new JTextField("Cognome");
        final var DoB = new JTextField("Data di nascita (formato YYYY-MM-DD)");

        // modifiche giuli
        var adminButton = new JButton("Torna indietro");

        adminButton.addActionListener(e -> {
            controller.getView().adminPage();
            frame.validate();
        });

        playerDataPanel.add(name);
        playerDataPanel.add(surname);
        playerDataPanel.add(DoB);

        final var register = new JButton("Registra i dati inseriti");
        register.addActionListener(e -> {
            controller.registerPlayer(name.getText(), surname.getText(), DoB.getText());
            frame.validate();
        });

        playerDataPanel.add(register);
        playerDataPanel.add(adminButton);
        frame.setContentPane(playerDataPanel);
    }

    public void addNewTournament(Circoli circolo) {
        final var newTournamentPanel = new JPanel();
        newTournamentPanel.setLayout(new BoxLayout(newTournamentPanel, BoxLayout.Y_AXIS));

        final var courseChoicePanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        courseChoicePanel.add(new JLabel("Scegli il percorso"));
        final var courseChoiceMenu = new JComboBox<String>(controller.getCourseNames(circolo));
        courseChoicePanel.add(courseChoiceMenu);

        final var tournamentInfoPanel = new JPanel();
        tournamentInfoPanel.setLayout(new BoxLayout(tournamentInfoPanel, BoxLayout.Y_AXIS));
        final var name = new JTextField("Inserire nome della gara");
        final var dataInizio = new JTextField("Inserire la data di inizio del torneo (formato YYYY-MM-DD)");
        final var durata = new JPanel(new FlowLayout(FlowLayout.LEFT));
        durata.add(new JLabel("Seleziona la durata della gara"));
        final String[] durations = { "1", "2", "3", "4" };
        final var chooseDuration = new JComboBox<String>(durations);
        durata.add(chooseDuration);
        final var dataChiusuraIscrizioni = new JTextField(
                "Inserire la data di chiusura delle iscrizioni (formato YYYY-MM-DD)");
        final var statusPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        statusPanel.add(new JLabel("Scegliere lo status della gara"));
        final String[] statuses = { "professionistica", "dilettantistica" };
        final var statusChoice = new JComboBox<String>(statuses);
        statusPanel.add(statusChoice);
        final var maxIscritti = new JTextField("Inserire il massimo di iscritti");
        tournamentInfoPanel.add(name);
        tournamentInfoPanel.add(dataInizio);
        tournamentInfoPanel.add(durata);
        tournamentInfoPanel.add(maxIscritti);
        tournamentInfoPanel.add(dataChiusuraIscrizioni);
        tournamentInfoPanel.add(statusPanel);

        final var go = new JButton("Inserisci torneo");
        go.addActionListener(e -> {
            controller.addNewTournament(
                    circolo,
                    courseChoiceMenu.getSelectedItem(),
                    name.getText(),
                    dataInizio.getText(),
                    (String)chooseDuration.getSelectedItem(),
                    maxIscritti.getText(),
                    dataChiusuraIscrizioni.getText(),
                    statusChoice.getSelectedItem());
            frame.validate();
        });

        newTournamentPanel.add(courseChoicePanel);
        newTournamentPanel.add(tournamentInfoPanel);
        newTournamentPanel.add(go);
        newTournamentPanel.add(this.clubHome(circolo));
        frame.setContentPane(newTournamentPanel);
    }

    /*
     * public void debugScreen(Object ... values) {
     * final var newFrame = new JFrame("debug");
     * final var debugPanel = new JPanel();
     * debugPanel.setLayout(new BoxLayout(debugPanel, BoxLayout.Y_AXIS));
     * 
     * for (var value : values) {
     * debugPanel.add(new JLabel(value.toString()));
     * }
     * 
     * newFrame.setContentPane(debugPanel);
     * newFrame.setVisible(true);
     * }
     */

    public void addNewCourse(Circoli circolo) {
        final var newCoursePanel = new JPanel();
        newCoursePanel.setLayout(new BoxLayout(newCoursePanel, BoxLayout.Y_AXIS));

        final var nomePercorso = new JTextField("Inserire il nome del percorso");
        final var par = new JTextField("Inserire il par");
        final var courseRating = new JTextField("Inserire il course rating");

        final var go = new JButton("Registra percorso");
        go.addActionListener(e -> {
            controller.addCourse(
                    circolo,
                    nomePercorso.getText(),
                    par.getText(),
                    courseRating.getText());
            frame.validate();
        });

        newCoursePanel.add(nomePercorso);
        newCoursePanel.add(par);
        newCoursePanel.add(courseRating);
        newCoursePanel.add(go);
        newCoursePanel.add(this.clubHome(circolo));
        frame.setContentPane(newCoursePanel);
    }

    public void assignTitle(Circoli circolo) {
        final var titleAssignmentPanel = new JPanel();
        titleAssignmentPanel.setLayout(new BoxLayout(titleAssignmentPanel, BoxLayout.Y_AXIS));

        final var chooseMemberPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        chooseMemberPanel.add(new JLabel("Seleziona socio"));
        final var chooseMember = new JComboBox<Tesserati>(new Vector<Tesserati>(controller.getMembers(circolo)));
        chooseMemberPanel.add(chooseMember);

        final var chooseTitlePanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        chooseTitlePanel.add(new JLabel("Seleziona carica"));
        final var chooseTitle = new JComboBox<Cariche>(new Vector<Cariche>(controller.getTitles()));
        chooseTitlePanel.add(chooseTitle);

        titleAssignmentPanel.add(chooseMemberPanel);
        titleAssignmentPanel.add(chooseTitlePanel);
        final var go = new JButton("Assegna carica");
        go.addActionListener(e -> {
            controller.newTitle(circolo, (Tesserati) chooseMember.getSelectedItem(),
                    (Cariche) chooseTitle.getSelectedItem());
            frame.validate();
        });

        titleAssignmentPanel.add(go);
        titleAssignmentPanel.add(this.clubHome(circolo));
        frame.setContentPane(titleAssignmentPanel);
    }

    public void addBooking(Circoli circolo) {
        final var addBookingPanel = new JPanel();
        addBookingPanel.setLayout(new BoxLayout(addBookingPanel, BoxLayout.Y_AXIS));

        final var coursePanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        coursePanel.add(new JLabel("Selezionare il percorso"));
        final var courses = controller.getCourseNames(circolo);
        final var chooseCourse = new JComboBox<String>(courses);
        coursePanel.add(chooseCourse);
        addBookingPanel.add(coursePanel);

        final var datePanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        final var dateInsertion = new JTextField("Inserire la data (formato YYYY-MM-DD)");
        datePanel.add(dateInsertion);
        addBookingPanel.add(datePanel);

        final var hourPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        final var hourInsertion = new JTextField("Inserire l'orario (formato hh:mm)");
        hourPanel.add(hourInsertion);
        addBookingPanel.add(hourPanel);

        final var playersPanel = new JPanel();
        playersPanel.setLayout(new BoxLayout(playersPanel, BoxLayout.Y_AXIS));
        final var player1 = new JTextField("Inserire il numero di tessera del primo giocatore");
        final var player2 = new JTextField("Inserire il numero di tessera del secondo giocatore");
        final var player3 = new JTextField("Inserire il numero di tessera del terzo giocatore");
        final var player4 = new JTextField("Inserire il numero di tessera del quarto giocatore");
        playersPanel.add(player1);
        playersPanel.add(player2);
        playersPanel.add(player3);
        playersPanel.add(player4);
        addBookingPanel.add(playersPanel);

        final var go = new JButton("Assegna percorso");
        go.addActionListener(e -> {
            controller.addBooking(
                    circolo,
                    (String) chooseCourse.getSelectedItem(),
                    dateInsertion.getText(),
                    hourInsertion.getText(),
                    player1.getText(),
                    player2.getText(),
                    player3.getText(),
                    player4.getText());
            frame.validate();
        });

        addBookingPanel.add(go);
        addBookingPanel.add(this.clubHome(circolo));
        frame.setContentPane(addBookingPanel);
    }

    public void messagePage(String message) {
        final var prevPanel = frame.getContentPane();

        final var errorPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        errorPanel.add(new JLabel(message));

        final var goback = new JButton("Torna indietro");
        goback.addActionListener(e -> {
            frame.setContentPane(prevPanel);
            frame.validate();
        });

        errorPanel.add(goback);
        frame.setContentPane(errorPanel);
    }

    public void showTournaments(Tesserati tesserato, List<Gare> availableTournaments) {
        final var showTournamentsPanel = new JPanel();
        showTournamentsPanel.setLayout(new BoxLayout(showTournamentsPanel, BoxLayout.Y_AXIS));

        for (var elem : availableTournaments) {
            final var singleTournamentPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
            singleTournamentPanel.add(new JLabel(elem.getNomeGara()));
            singleTournamentPanel.add(new JLabel(elem.getNomeCircolo()));
            singleTournamentPanel.add(new JLabel(elem.getNomePercorso()));
            singleTournamentPanel.add(new JLabel("Data inizio: " + elem.getDataInizio().toString()));
            singleTournamentPanel.add(new JLabel("Durata: " + Integer.toString(elem.getDurata()) + " giorni"));
            singleTournamentPanel.add(new JLabel("Categoria: " + elem.getCategoriaOdM()));
            singleTournamentPanel.add(new JLabel("Status: " + elem.getCategoriaStatus()));
            singleTournamentPanel
                    .add(new JLabel("Chiusura iscrizioni: " + elem.getDataChiusuraIscrizioni().toString()));
            showTournamentsPanel.add(singleTournamentPanel);

            final var participate = new JButton();
            if (controller.isSubscribed(tesserato, elem)) {
                participate.setText("Ritira l'iscrizione");
                participate.addActionListener(e -> {
                    controller.retireSubscription(tesserato, elem);
                    frame.validate();
                });
                showTournamentsPanel.add(participate);
            } else {
                participate.setText("Iscriviti");
                participate.addActionListener(e -> {
                    controller.recordSubscription(tesserato, elem);
                    frame.validate();
                });
                showTournamentsPanel.add(participate);
            }

        }

        showTournamentsPanel.add(this.playerHome(tesserato));
        frame.setContentPane(new JScrollPane(showTournamentsPanel));
    }

    public void showLeaderboard(List<Tesserati> leaderboard) {
        final var leaderboardPanel = new JPanel();
        leaderboardPanel.setLayout(new BoxLayout(leaderboardPanel, BoxLayout.Y_AXIS));

        int i = 1;
        for (var elem : leaderboard) {
            final var playerPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
            playerPanel.add(new JLabel(Integer.toString(i)));
            playerPanel.add(new JLabel(elem.getName()));
            playerPanel.add(new JLabel(elem.getSurname()));

            i++;
            leaderboardPanel.add(playerPanel);
        }

        leaderboardPanel.add(this.guestHome());
        frame.setContentPane(new JScrollPane(leaderboardPanel));
    }

    public void showEntryList(List<Tesserati> entryList) {
        final var leaderboardPanel = new JPanel();
        leaderboardPanel.setLayout(new BoxLayout(leaderboardPanel, BoxLayout.Y_AXIS));

        int i = 1;
        for (var elem : entryList) {
            final var playerPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
            playerPanel.add(new JLabel(Integer.toString(i)));
            playerPanel.add(new JLabel(elem.getName()));
            playerPanel.add(new JLabel(elem.getSurname()));

            i++;
            leaderboardPanel.add(playerPanel);
        }

        leaderboardPanel.add(this.guestHome());
        frame.setContentPane(new JScrollPane(leaderboardPanel));
    }

    public void showTournamentsToHandle(Circoli circolo, List<Gare> tournaments) {
        final var tournamentListPanel = new JPanel();
        tournamentListPanel.setLayout(new BoxLayout(tournamentListPanel, BoxLayout.Y_AXIS));

        for (var elem : tournaments) {
            final var tournamentPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));

            tournamentPanel.add(new JLabel(elem.getNomeGara()));
            tournamentPanel.add(new JLabel(elem.getNomePercorso()));
            tournamentPanel.add(new JLabel(elem.getDataInizio().toString()));
            tournamentPanel.add(new JLabel("Durata: " + Integer.toString(elem.getDurata()) + " giorni"));
            tournamentPanel.add(new JLabel(
                    "Categoria " + (elem.getCategoriaStatus().equals("p") ? "professionistica" : "dilettantistica")));
            tournamentPanel.add(new JLabel("Categoria OdM : " + elem.getCategoriaOdM()));

            if (controller.isOver(elem)) {
                final var classifica = new JButton("Pubblica/ aggiorna classifica");
                classifica.addActionListener(e -> {
                    controller.handleResult(elem);
                    frame.validate();
                });
                tournamentPanel.add(classifica);
            }

            tournamentListPanel.add(tournamentPanel);
        }

        tournamentListPanel.add(this.clubHome(circolo));
        frame.setContentPane(new JScrollPane(tournamentListPanel));
    }

    public void clubRegistrationPage() {
        final JPanel clubRegistrationPanel = new JPanel();
        clubRegistrationPanel.setLayout(new BoxLayout(clubRegistrationPanel, BoxLayout.Y_AXIS));

        final var name = new JTextField("Nome del Circolo");
        final var address = new JTextField("Indirizzo del Circolo");
        final var caddieMaster = this.maxOf("Caddie Master");
        final var greenkeeper = this.maxOf("Greenkeeper");
        final var maestro = this.maxOf("Maestri");
        final var referenteAtleti = this.maxOf("Referenti Atleti");
        final var segretario = this.maxOf("Segretari");
        final var go = new JButton("Registra i dati inseriti");

        clubRegistrationPanel.add(name);
        clubRegistrationPanel.add(address);
        clubRegistrationPanel.add(caddieMaster);
        clubRegistrationPanel.add(greenkeeper);
        clubRegistrationPanel.add(referenteAtleti);
        clubRegistrationPanel.add(maestro);
        clubRegistrationPanel.add(segretario);
        go.addActionListener(e -> {
            controller.registerClub(
            name.getText(),
            address.getText(),
            caddieMaster.getText(),
            greenkeeper.getText(),
            referenteAtleti.getText(),
            maestro.getText(),
            segretario.getText()
            );
            frame.validate();
        });
        clubRegistrationPanel.add(go);

        clubRegistrationPanel.add(this.adminHome());
        frame.setContentPane(clubRegistrationPanel);
    }

    private JTextField maxOf(String nomeCarica) {
        return new JTextField("Massimo numero di " + nomeCarica);
    }

    public void playerUpdateSelection() {
        final var playerSelectionFrame = new JPanel(new FlowLayout(FlowLayout.CENTER));
        final var number = new JTextField("Inserire il numero di tessera");
        playerSelectionFrame.add(number);

        final var go = new JButton("Procedi");
        go.addActionListener(e -> {
            controller.updatePlayer(number.getText());
            frame.validate();
        });
        playerSelectionFrame.add(go);

        playerSelectionFrame.add(this.adminHome());
        frame.setContentPane(playerSelectionFrame);
    }

    public void playerUpdateFound(Tesserati player) {
        final var playerUpdatePanel = new JPanel();
        playerUpdatePanel.setLayout(new BoxLayout(playerUpdatePanel, BoxLayout.Y_AXIS));

        final var disqualify = new JButton("Assegna/revoca squalifica");
        final var turnProfessional = new JButton("Modifica lo status di professionista");

        turnProfessional.addActionListener(e -> {
            controller.changeStatus(player);
            frame.validate();
        });

        disqualify.addActionListener(e -> {
            controller.toggleDisqualification(player);
            frame.validate();
        });

        playerUpdatePanel.add(turnProfessional);
        playerUpdatePanel.add(disqualify);
        playerUpdatePanel.add(this.adminHome());
        frame.setContentPane(playerUpdatePanel);
    }

    public void showMembers(Circoli circolo, List<Tesserati> members) {
        final var showMembersPanel = new JPanel();
        showMembersPanel.setLayout(new BoxLayout(showMembersPanel, BoxLayout.Y_AXIS));

        for (var member : members) {
            final var memberPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));

            memberPanel.add(new JLabel(Integer.toString(member.getNumTessera())));
            memberPanel.add(new JLabel(member.getName()));
            memberPanel.add(new JLabel(member.getSurname()));
            memberPanel.add(new JLabel(member.getDataDiNascita().toString()));
            memberPanel.add(new JLabel(member.getStatusProfessionista()));
            memberPanel.add(new JLabel(member.getEraProfessionista()));
            memberPanel.add(new JLabel(member.getSqualifica()));
            memberPanel.add(new JLabel(Integer.toString(member.getOdMPoints())));
            if (member.getNumCertificato() != 0) {
                memberPanel.add(new JLabel(Integer.toString(member.getNumCertificato())));
            }
            memberPanel.add(new JLabel(member.getEmail()));
            memberPanel.add(new JLabel(member.getTelefono()));

            showMembersPanel.add(memberPanel);
        }

        showMembersPanel.add(this.clubHome(circolo));
        frame.setContentPane(new JScrollPane(showMembersPanel));
    }

    public void memberAdditionPage(Circoli circolo) {
        final var memberAdditionPanel = new JPanel();
        memberAdditionPanel.setLayout(new BoxLayout(memberAdditionPanel, BoxLayout.Y_AXIS));

        final var number = new JTextField("Inserire il numero di tessera");
        memberAdditionPanel.add(number);
        final var go = new JButton("Registra socio");
        go.addActionListener(e -> {
            controller.registerMember(circolo, number.getText());
            frame.validate();
        });

        memberAdditionPanel.add(go);
        memberAdditionPanel.add(this.clubHome(circolo));
        frame.setContentPane(memberAdditionPanel);
    }

    public void showBookings(Circoli circolo, List<Prenotazioni> bookings) {
        final var showBookingsPanel = new JPanel();
        showBookingsPanel.setLayout(new BoxLayout(showBookingsPanel, BoxLayout.Y_AXIS));

        for (var elem : bookings) {
            final var bookingPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));

            bookingPanel.add(new JLabel(elem.getNomePercorso()));
            bookingPanel.add(new JLabel(elem.getDataPrenotazione().toString()));
            bookingPanel.add(new JLabel(elem.getOraPrenotazione().toString()));
            bookingPanel.add(new JLabel(Integer.toString(elem.getNumTessera1())));
            bookingPanel.add(new JLabel(Integer.toString(elem.getNumTessera2())));
            bookingPanel.add(new JLabel(Integer.toString(elem.getNumTessera3())));
            bookingPanel.add(new JLabel(Integer.toString(elem.getNumTessera4())));

            showBookingsPanel.add(bookingPanel);
        }

        final var goback = new JButton("Torna indietro");
        goback.addActionListener(e -> {
            this.clubPage(circolo);
            frame.validate();
        });

        showBookingsPanel.add(goback);
        showBookingsPanel.add(this.clubHome(circolo));
        frame.setContentPane(new JScrollPane(showBookingsPanel));
    }

    public void showStats(Stats stats) {
        final var statsPanel = new JPanel();
        statsPanel.setLayout(new BoxLayout(statsPanel, BoxLayout.Y_AXIS));

        final var playerInfoPanel = new JPanel();
        playerInfoPanel.setLayout(new BoxLayout(playerInfoPanel, BoxLayout.Y_AXIS));
        playerInfoPanel.add(new JLabel(
            stats.getTesserato().getName() + " " +
            stats.getTesserato().getSurname() + " " + 
            "tesserato numero " +
            Integer.toString(stats.getTesserato().getNumTessera())
        ));
        playerInfoPanel.add(new JLabel(
            controller.hasValidCertificate(stats.getTesserato()) ? 
            "Il tesserato ha un certificato medico valido" :
            "Il tesserato non ha un certificato medico valido"
        ));
        playerInfoPanel.add(new JLabel(
            stats.getTesserato().getStatusProfessionista().equals("t") ? "Professionista" : "Dilettante"
        ));
        playerInfoPanel.add(new JLabel(
            "Data di nascita: " +
            stats.getTesserato().getDataDiNascita().toString()
        ));
        playerInfoPanel.add(this.showContacts(stats.getTesserato()));
        statsPanel.add(playerInfoPanel);

        final var lastTournamentsPanel = new JPanel();
        lastTournamentsPanel.setLayout(new BoxLayout(lastTournamentsPanel, BoxLayout.Y_AXIS));
        for (var result : stats.getUltimeGare()) {
            final var resultPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
            resultPanel.add(new JLabel(result.getNomeGara()));
            resultPanel.add(new JLabel("Posizione finale: " + Integer.toString(result.getPosizioneFinale())));
            resultPanel.add(new JLabel("Punti ottenuti: " + Integer.toString(result.getPuntiOttenuti())));
            lastTournamentsPanel.add(resultPanel);
        }
        lastTournamentsPanel.add(new JLabel("Media punti nelle ultime 10 gare: " +Float.toString(stats.getMediaPunti())));
        statsPanel.add(lastTournamentsPanel);

        statsPanel.add(this.playerHome(stats.getTesserato()));

        frame.setContentPane(new JScrollPane(statsPanel));
    }

    private JLabel showContacts(Tesserati tesserato) {
        String email = "non registrato";
        if (tesserato.getEmail() != null) {
            email = tesserato.getEmail();
        }

        String phone = "non registrato";
        if (tesserato.getTelefono() != null) {
            phone = tesserato.getTelefono();
        }
        return new JLabel(
            "Indirizzo mail: " + email + " Numero di telefono: " + phone
        );
    }

    public void insertPosition(Gare gara, int posizione, List<Tesserati> nonPositionedPlayers) {
        final var positionPanel = new JPanel();
        positionPanel.setLayout(new BoxLayout(positionPanel, BoxLayout.Y_AXIS));

        positionPanel.add(new JLabel(
            "Inserire il giocatore in" +
            Integer.toString(posizione) +
            " posizione"
        ));

        final var selectPlayer = new JComboBox<Tesserati>(new Vector<Tesserati>(nonPositionedPlayers));
        final var recordResult = new JButton("Registra la posizione");

        recordResult.addActionListener(e -> {
            controller.recordResult((Tesserati)selectPlayer.getSelectedItem(), gara, posizione, nonPositionedPlayers);
            frame.validate();
        });

        positionPanel.add(selectPlayer);
        positionPanel.add(recordResult);
        frame.setContentPane(positionPanel);
    }

    public void setBackGroundImage(JPanel panel, String imagePath) {
        ImageIcon image;
        image = loadImage(imagePath);
        JLabel background = new JLabel(image);
        background.setBounds(0,0, panel.getWidth(), panel.getHeight()); //setta l'immagine della grandezza giusta
        panel.setLayout(null); //se metto un layout me lo toglie e mi mette quello che voglio 
        panel.add(background);
        panel.repaint();
    }

    public ImageIcon loadImage (String pathImage){
        return new ImageIcon(pathImage);
    }

}