package model;

import java.sql.Connection;
import java.util.List;
import java.util.Optional;
import java.util.Vector;

import data.*;

public interface Model {
    
    public static Model fromConnection(Connection connection) {
        return new DBModel(connection);
    }

    public Optional<Circoli> findClub(String clubName);

    public Optional<Tesserati> findPlayer(String playerNumber);

    public List<Tesserati> getOderOfMerit();

    public List<Gare> getTournamentList();

    public List<Circoli> getClubsList();

    public void updateOdM();

    public void registerPlayer(String name, String surname, String dateOfBirth);

    public void registerClub(String clubName, String address);

    public void resignProStatus(Tesserati player);

    public void turnPro(Tesserati player);

    public void disqualify(Tesserati player);

    public void requalify(Tesserati player);

    public void remove(Tesserati player);

    public void removeClub(String clubName);

    public List<Tesserati> getMembers(Circoli circolo);

    public Optional<Associazioni> findAssociation(Circoli circolo, String number, int value);

    public void newMember(Circoli circolo, String number);

    public List<Prenotazioni> getBookings(Circoli circolo);

    public Vector<String> getCourseNames(Circoli circolo);

    public Optional<Gare> findTournament(String nomeGara);

    public void addNewTournament(String nomeCircolo, String nomePercorso, String nomeGara, String dataInizio,
            String durata, String maxIscritti, String dataChiusuraIscrizioni, String status, String categoria);

    public void addCourse(String nomeCircolo, String nomePercorso, String par, String courseRating);

    public Optional<Percorsi> findCourse(Circoli circolo, String nomePercorso);

    public List<Cariche> getTitles();

    public int countTitles(Circoli circolo, Cariche carica);

    public int getLimit(Circoli circolo, Cariche carica);

    public void newTitle(Circoli circolo, Tesserati tesserato, Cariche carica);

    public Optional<Attribuzioni> findTitle(Circoli circolo, Tesserati tesserato, Cariche carica);

    public Optional<Prenotazioni> findBooking(String nomeCircolo, String nomePercorso, String data, String ora);

    public void addBooking(String nomeCircolo, String nomePercorso, String data, String ora, String player1,
            String player2, String player3, String player4);

    public void recordMedical(String emissionDate, String expireDate, String playerNumber);

    public void recordPhone(String phoneNumber, String playerNumber);

    public void recordMail(String mailAddress, String playerNumber);

    public List<Gare> getAvailableTournaments(String statusProfessionista);

    public boolean isSubscribed(String numTessera, String nomeGara);

    public void recordSubscription(String numTessera, String nomeGara, String dateOfNow);

    public void retireSubscription(String numTessera, String nomeGara);

    public List<Tesserati> getLeaderboard(String nomeGara);

    public List<Tesserati> getEntryList(String nomeGara);

    public boolean hasCertificate(Tesserati tesserato);

    public boolean isCertificateValid(int numCertificato);

    public List<Gare> getClubTournaments(String nomeCircolo);

    public Stats getStats(int numTessera);

    public int getFinalPoints(int posizione, String nomeGara);

    public void recordPosition(int numTessera, String nomeGara, int posizione, int odMPoints);

    public List<Tesserati> getLimitedEntryList(String nomeGara, int maxIscritti);

}
