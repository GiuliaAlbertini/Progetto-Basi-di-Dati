package model;

import java.sql.Connection;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Vector;

import java.time.LocalDate;

import data.*;

public class DBModel implements Model{

    private final Connection connection;

    DBModel(Connection connection) {
        Objects.requireNonNull(connection, "Model created with null connection");
        this.connection = connection;
    }

    @Override
    public Optional<Circoli> findClub(String clubName) {
        return Circoli.DAO.find(connection, clubName);
    }

    @Override
    public Optional<Tesserati> findPlayer(String playerNumber) {
        return Tesserati.DAO.find(connection, playerNumber);
    }

    @Override
    public List<Tesserati> getOderOfMerit() {
        return Tesserati.DAO.oderOfMerit(connection);
    }

    @Override
    public List<Gare> getTournamentList() {
        return Gare.DAO.tournamentList(connection);
    }

    @Override
    public List<Circoli> getClubsList() {
        return Circoli.DAO.clubList(connection);
    }

    @Override
    public void updateOdM() {
        try (
            var statement = DAOUtils.prepare(connection, Queries.UPDATE_ODM);
        ) {
            statement.execute();
        } catch (Exception e) {
            throw new DAOException(e);
        }
    }

    @Override
    public void registerPlayer(String name, String surname, String dateOfBirth) {
        Tesserati.DAO.registerNew(connection, name, surname, dateOfBirth);
    }

    @Override
    public void registerClub(String clubName, String address) {
        Circoli.DAO.registerNew(connection, clubName, address);
    }

    @Override
    public void resignProStatus(Tesserati player) {
        Tesserati.DAO.resignProStatus(connection, player);
    }

    @Override
    public void turnPro(Tesserati player) {
        Tesserati.DAO.turnPro(connection, player);
    }

    @Override
    public void disqualify(Tesserati player) {
        Tesserati.DAO.disqualify(connection, player);
    }

    @Override
    public void requalify(Tesserati player) {
        Tesserati.DAO.requalify(connection, player);
    }

    @Override
    public void remove(Tesserati player) {
        Tesserati.DAO.remove(connection, player);
    }

    @Override
    public void removeClub(String clubName) {
        Circoli.DAO.remove(connection, clubName);
    }

    @Override
    public List<Tesserati> getMembers(Circoli circolo) {
        return Tesserati.DAO.membersOf(connection, circolo);
    }

    @Override
    public Optional<Associazioni> findAssociation(Circoli circolo, String number, int year) {
        return Associazioni.DAO.find(connection, circolo, number, year);
    }

    @Override
    public void newMember(Circoli circolo, String number) {
        Associazioni.DAO.register(connection, circolo, number);
    }

    @Override
    public List<Prenotazioni> getBookings(Circoli circolo) {
        return Prenotazioni.DAO.getList(connection, circolo);
    }

    @Override
    public Vector<String> getCourseNames(Circoli circolo) {
        return new Vector<String>(Percorsi.DAO.getCoursesNamesInClub(connection, circolo.getNomeCircolo()));
    }

    @Override
    public Optional<Gare> findTournament(String nomeGara) {
        return Gare.DAO.find(connection, nomeGara);
    }

    @Override
    public void addNewTournament(String nomeCircolo, String nomePercorso, String nomeGara, String dataInizio,
            String durata, String maxIscritti, String dataChiusuraIscrizioni, String status, String categoria) {
        Gare.DAO.addNew(
            connection,
            nomeCircolo,
            nomePercorso,
            nomeGara,
            dataInizio,
            durata,
            maxIscritti,
            dataChiusuraIscrizioni,
            status,
            categoria
        );
    }

    @Override
    public void addCourse(String nomeCircolo, String nomePercorso, String par, String courseRating) {
        Percorsi.DAO.create(connection, nomeCircolo, nomePercorso, par, courseRating);
    }

    @Override
    public Optional<Percorsi> findCourse(Circoli circolo, String nomePercorso) {
        return Percorsi.DAO.find(connection, circolo.getNomeCircolo(), nomePercorso);
    }

    @Override
    public List<Cariche> getTitles() {
        return Cariche.DAO.getList(connection);
    }

    @Override
    public int countTitles(Circoli circolo, Cariche carica) {
        return Attribuzioni.DAO.count(connection, circolo.getNomeCircolo(), carica.getNomeCarica());
    }

    @Override
    public int getLimit(Circoli circolo, Cariche carica) {
        return Riserve.DAO.limit(connection, circolo.getNomeCircolo(), carica.getNomeCarica());
    }

    @Override
    public void newTitle(Circoli circolo, Tesserati tesserato, Cariche carica) {
        Attribuzioni.DAO.add(connection, circolo.getNomeCircolo(), Integer.toString(tesserato.getNumTessera()), carica.getNomeCarica());
    }

    @Override
    public Optional<Attribuzioni> findTitle(Circoli circolo, Tesserati tesserato, Cariche carica) {
        return Attribuzioni.DAO.find(
            connection,
            circolo.getNomeCircolo(),
            Integer.toString(tesserato.getNumTessera()),
            carica.getNomeCarica()
        );
    }

    @Override
    public Optional<Prenotazioni> findBooking(String nomeCircolo, String nomePercorso, String data, String ora) {
        return Prenotazioni.DAO.find(
            connection,
            nomeCircolo,
            nomePercorso,
            data,
            ora
        );
    }

    @Override
    public void addBooking(String nomeCircolo, String nomePercorso, String data, String ora, String player1,
            String player2, String player3, String player4) {
        Prenotazioni.DAO.add(
            connection,
            nomeCircolo,
            nomePercorso,
            data,
            ora,
            player1,
            player2,
            player3,
            player4
        );
    }

    @Override
    public void recordMedical(String emissionDate, String expireDate, String playerNumber) {
        CertificatiMedici.DAO.add(connection, emissionDate, expireDate, playerNumber);
    }

    @Override
    public void recordPhone(String phoneNumber, String playerNumber) {
        Tesserati.DAO.recordPhone(connection, playerNumber, phoneNumber);
    }

    @Override
    public void recordMail(String mailAddress, String playerNumber) {
        Tesserati.DAO.recordMail(connection, mailAddress, playerNumber);
    }

    @Override
    public List<Gare> getAvailableTournaments(String statusProfessionista) {
        return Gare.DAO.getTournamentList(
            connection,
            statusProfessionista,
            LocalDate.now().toString()
        );
    }

    @Override
    public boolean isSubscribed(String numTessera, String nomeGara) {
        return Iscrizioni.DAO.exists(connection, numTessera, nomeGara);
    }

    @Override
    public void recordSubscription(String numTessera, String nomeGara, String dateOfNow) {
        Iscrizioni.DAO.add(connection, numTessera, nomeGara, dateOfNow);
    }

    @Override
    public void retireSubscription(String numTessera, String nomeGara) {
        Iscrizioni.DAO.retire(connection, numTessera, nomeGara);
    }

    @Override
    public List<Tesserati> getLeaderboard(String nomeGara) {
        return Iscrizioni.DAO.getLeaderboard(connection, nomeGara);
    }

    @Override
    public List<Tesserati> getEntryList(String nomeGara) {
        return Iscrizioni.DAO.getEntryList(connection, nomeGara);
    }

    @Override
    public boolean hasCertificate(Tesserati tesserato) {
        return CertificatiMedici.DAO.find(connection, tesserato.getNumTessera()).isPresent();
    }

    @Override
    public boolean isCertificateValid(int numCertificato) {
        return CertificatiMedici.DAO.getExpirydate(connection, numCertificato).isAfter(LocalDate.now());
    }

    @Override
    public List<Gare> getClubTournaments(String nomeCircolo) {
        return Gare.DAO.getTournamentsInClub(connection, nomeCircolo);
    }

    @Override
    public Stats getStats(int numTessera) {
        return Stats.DAO.get(connection, numTessera);
    }

    @Override
    public void clearEntryList(String nomeGara, int maxIscritti) {
        Iscrizioni.DAO.clearEntryList(connection, nomeGara, maxIscritti);
    }

    @Override
    public List<Tesserati> getNonPositionedPlayers(String nomeGara) {
        return Tesserati.DAO.getNonPositionedInTournament(connection, nomeGara);
    }

    @Override
    public int getFinalPoints(int posizione, String nomeGara) {
        return Posizionamenti.DAO.getOdMPoints(connection, posizione, nomeGara);
    }

    @Override
    public void recordPosition(int numTessera, String nomeGara, int posizione, int odMPoints) {
        Iscrizioni.DAO.setResult(connection, numTessera, nomeGara, posizione, odMPoints);
    }
    
}
