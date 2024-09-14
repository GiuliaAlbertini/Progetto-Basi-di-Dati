import java.time.LocalDate;
import java.time.LocalTime;
import java.time.Year;
import java.util.List;
import java.util.Vector;

import data.*;
import model.Model;

public class Controller {
    
    private final Model model;
    private final View view;

    Controller(Model model, View view) {
        this.model = model;
        this.view = view;
    }

    public void homePage() {
        view.homePage();
    }

    public void adminLoginClicked() {
        view.adminPage();
    }

    public void clubLoginClicked() {
        view.clubLoginPage();
    }

    public void playerLoginClicked() {
        view.playerLoginPage();
    }

    public void guestLoginClicked() {
        view.guestPage();
    }

    public void clubLoginSubmitted(String clubName) {
        var circolo = model.findClub(clubName);
        if (circolo.isEmpty()) {
            view.messagePage("Circolo non trovato");
        } else {
            view.clubPage(circolo.get());
        }
    }

    public void playerLoginSubmitted(String playerNumber) {
        var giocatore = model.findPlayer(playerNumber);
        if (giocatore.isEmpty()) {
            view.messagePage("Giocatore non trovato");
        } else {
            view.playerPage(giocatore.get());
        }
    }

    public void odmRequested() {
        List<Tesserati> odm = model.getOderOfMerit();
        view.showOrderOfMerit(odm);
    }

    public void tournamentsRequested() {
        List<Gare> tourneys = model.getTournamentList();
        view.showTournamentList(tourneys);
    }

    public void clubInfoRequested() {
        List<Circoli> clubs = model.getClubsList();
        view.showClubInfo(clubs);
    }

    public void odmUpdateRequested() {
        model.updateOdM();
        view.messagePage("Ordine di merito aggiornato correttamente");
    }

    public void playerRegistrationRequested() {
        view.playerRegistrationPage();
    }

    public void clubRegistrationRequested() {
        view.clubRegistrationPage();
    }

    public void playerUpdateRequested() {
        view.playerUpdateSelection();
    }

    public void registerPlayer(String name, String surname, String dateOfBirth) {
        if (this.isValidDate(dateOfBirth)) {
            model.registerPlayer(name, surname, dateOfBirth);
            view.messagePage("Giocatore registrato correttamente");
        } else {
            view.messagePage("Errore nel formato della data");
        }
    }

    public void registerClub(String clubName, String address) {
        model.registerClub(clubName, address);
        view.messagePage("Circolo inserito con successo");
    }

    public void updatePlayer(String number) {
        var player = model.findPlayer(number);
        if (player.isEmpty()) {
            view.messagePage("Giocatore non trovato");
        } else {
            view.playerUpdateFound(player.get());
        }
    }

    private void resignProStatus(Tesserati player) {
        model.resignProStatus(player);
        view.messagePage("Status di professionista revocato");
    }

    private void turnPro(Tesserati player) {
        model.turnPro(player);
        view.messagePage("Status di professionista associato");
    }

    private void disqualify(Tesserati player) {
        model.disqualify(player);
        view.messagePage("Squalifica registrata correttamente");
    }

    private void requalify(Tesserati player) {
        model.requalify(player);
        view.messagePage("Squalifica revocata con successo");
    }

    public void removePlayer(Tesserati player) {
        model.remove(player);
        view.messagePage("Giocatore rimosso");
    }

    public void getMemberList(Circoli circolo) {
        List<Tesserati> members = model.getMembers(circolo);
        if (members.isEmpty()) {
            view.messagePage("Il circolo non ha soci");
        } else {
            view.showMembers(circolo, members);
        }
    }

    public void memberAddition(Circoli circolo) {
        view.memberAdditionPage(circolo);
    }

    public void tournamentAddition(Circoli circolo) {
        view.addNewTournament(circolo);
    }

    public void manageTournaments(Circoli circolo) {
        List<Gare> tournaments = model.getClubTournaments(circolo.getNomeCircolo());
        view.showTournamentsToHandle(circolo, tournaments);
    }

    public void courseAddition(Circoli circolo) {
        view.addNewCourse(circolo);
    }

    public void titleAssignment(Circoli circolo) {
        view.assignTitle(circolo);
    }

    public void bookingAddition(Circoli circolo) {
        view.addBooking(circolo);
    }

    public void registerMember(Circoli circolo, String number) {
        if (model.findPlayer(number).isEmpty()) {
            view.messagePage("Giocatore non trovato");
        } else if (model.findAssociation(circolo, number, Year.now().getValue()).isEmpty()) {
            model.newMember(circolo, number);
            view.messagePage("Socio registrato correttamente");
        } else {
            view.messagePage("Il giocatore risulta associato per l'anno corrente");
        }
    }

    public void seeBookings(Circoli circolo) {
        List<Prenotazioni> bookings = model.getBookings(circolo);
        if (bookings.isEmpty()) {
            view.messagePage("Il circolo non ha ancora registrato prenotazioni");
        } else {
            view.showBookings(circolo, bookings);
        }
    }

    public void addNewTournament(Circoli circolo, Object nomePercorso, String nomeGara, String dataInizio, 
        String durata, String maxIscritti, String dataChiusuraIscrizioni, Object categoriaStatus) {
        if (!this.isValidDate(dataInizio)) {
            view.messagePage("Errore nel formato della data di inizio gara");
        } else if (!this.isValidDate(dataChiusuraIscrizioni)) {
            view.messagePage("Errore nel formato della data di chiusura iscrizioni");
        } else if (!model.findTournament(nomeGara).isEmpty()) {
            view.messagePage("Trovata una gara registrata allo stesso nome");
        } else if (!this.isValidInteger(maxIscritti)) {
            view.messagePage("Inserire un numero intero come massimo di iscritti");
        } else if (durata.toString().equals("4") && categoriaStatus.equals("dilettantistica")) {
            view.messagePage("Una gara dilettantistica deve avere durata minore o uguale a 3 giorni");
        } else {
            model.addNewTournament(
                circolo.getNomeCircolo(),
                nomePercorso.toString(),
                nomeGara,
                dataInizio,
                durata,
                maxIscritti,
                dataChiusuraIscrizioni,
                categoriaStatus.equals("professionistica") ? new String("p") : new String("d"),
                this.getCategory(durata.toString(), categoriaStatus)
                );
                view.messagePage("Gara registrata con successo");
        }
    }

    private boolean isValidInteger(String maxIscritti) {
        try {
            Integer.parseInt(maxIscritti);
        } catch (Exception e) {
            return false;
        }

        return true;
    }

    private String getCategory(String durata, Object categoriaStatus) {
        return Categorie.getCategory(durata, categoriaStatus);
    }

    public Vector<String> getCourseNames(Circoli circolo) {
        return model.getCourseNames(circolo);
    }

    public void addCourse(Circoli circolo, String nomePercorso, String par, String courseRating) {
        if (model.findCourse(circolo, nomePercorso).isEmpty()) {
            model.addCourse(circolo.getNomeCircolo(), nomePercorso, par, courseRating);
            view.messagePage("Percorso inserito correttamente");
        } else {
            view.messagePage("Impossibile registrare il percorso");
        }
    }

    public List<Tesserati> getMembers(Circoli circolo) {
        return model.getMembers(circolo);
    }

    public void newTitle(Circoli circolo, Tesserati tesserato, Cariche carica) {
        if (this.isAvailable(circolo, carica, tesserato)) {
            model.newTitle(circolo, tesserato, carica);
            view.messagePage("Carica assegnata con successo");
        } else {
            view.messagePage("La carica risulta non disponibile");
        }
    }

    private boolean isAvailable(Circoli circolo, Cariche carica, Tesserati tesserato) {
        return model.countTitles(circolo, carica) < model.getLimit(circolo, carica)
            && model.findTitle(circolo, tesserato, carica).isEmpty();
    }

    public List<Cariche> getTitles() {
        return model.getTitles();
    }

    public void addBooking(Circoli circolo, String nomePercorso, String data, String ora, String player1, String player2,
            String player3, String player4) {

        String num2 = this.getValue(player2);
        String num3= this.getValue(player3);
        String num4 = this.getValue(player4);
        if (!this.isValidDate(data)) {
            view.messagePage("Errore nel formato della data");
        } else if (!this.isvalidTime(ora)) {
            view.messagePage("Errore nel formato dell'orario");
        } else if (!this.isValidInteger(player1)) {
            view.messagePage("Inserire un numero intero come numero di tessera");
        } else if (
            model.findPlayer(player1).isEmpty() ||
            (num2 != null && model.findPlayer(num2).isEmpty()) ||
            (num3 != null && model.findPlayer(num3).isEmpty()) ||
            (num4 != null && model.findPlayer(num4).isEmpty())
        ) {
            view.messagePage("Numeri di tessera non validi");
        } else if (this.arePlayersRepeated(player1, num2, num3, num4)) {
            view.messagePage("Errore: ripetizione di numeri di tessera uguali");
        } else if (!this.bookingAvailable(circolo, nomePercorso, data, ora)) {
            view.messagePage("Prenotazione non disponibile");
        } else {
            model.addBooking(
                circolo.getNomeCircolo(),
                nomePercorso,
                data,
                ora,
                player1,
                num2,
                num3,
                num4
            );
            view.messagePage("Prenotazione registrata con successo");
        }
    }

    private boolean arePlayersRepeated(String player1, String num2, String num3, String num4) {
        return (num2 != null && num2.equals(player1))
            || (num3 != null && (num3.equals(num2) || num3.equals(player1)))
            || (num4 != null && (num4.equals(num3) || num4.equals(num2) || num4.equals(player1)));
    }

    private boolean isvalidTime(String ora) {
        try {
            LocalTime.parse(ora);
        } catch (Exception e) {
            return false;
        }

        return true;
    }

    private String getValue(String player) {
        String val = null;
        try {
            val = Integer.toString(Integer.parseInt(player));
        } catch (Exception e) {
            return null;
        }

        return val;
    }

    private boolean bookingAvailable(Circoli circolo, String nomePercorso, String data, String ora) {
        return model.findBooking(circolo.getNomeCircolo(), nomePercorso, data, ora).isEmpty();
    }

    public void getAvailableTournaments(Tesserati tesserato) {
        if (this.hasValidCertificate(tesserato)) {
            List<Gare> availableTournaments = model.getAvailableTournaments(this.getStatus(tesserato));
            view.showTournaments(tesserato, availableTournaments);
        }
        else {
            view.messagePage("Il tesserato non dispone di un certificato medico");
        }
    }

    public boolean hasValidCertificate(Tesserati tesserato) {
        return model.hasCertificate(tesserato) && model.isCertificateValid(tesserato.getNumCertificato());
    }

    private String getStatus(Tesserati tesserato) {
        if (tesserato.getStatusProfessionista().equals("t")) {
            return "p";
        } else {
            return "d";
        }
    }

    public void getPersonalStats(Tesserati tesserato) {
        view.showStats(model.getStats(tesserato.getNumTessera()));
    }

    public void recordMedical(String emissionDate, Tesserati tesserato) {
        if(!this.isValidDate(emissionDate)) {
            view.messagePage("Errore nel formato della data");
        } else if (LocalDate.parse(emissionDate).isAfter(LocalDate.now())) {
            view.messagePage("Impossibile inserire un certificato medico postdatato");
        } else {
            model.recordMedical(
                emissionDate,
                (LocalDate.parse(emissionDate)).plusYears(2).toString(),
                Integer.toString(tesserato.getNumTessera())
            );
            view.messagePage("Certificato registrato correttamente");
        }
    }

    private boolean isValidDate(String date) {
        try {
            LocalDate.parse(date);
        } catch (Exception e) {
            return false;
        }

        return true;
    }

    public void recordPhone(String phoneNumber, Tesserati tesserato) {
        if (phoneNumber.isEmpty()) {
            view.messagePage("Impossibile registrare: dato non inserito");
        } else if (phoneNumber.length() <= 10) {
            model.recordPhone(
                phoneNumber,
                Integer.toString(tesserato.getNumTessera())
            );
            view.messagePage("Recapito telefonico registrato correttamente");
        } else {
            view.messagePage("Impossibile registrare:numero di telefono troppo lungo");
        }
    }

    public void recordMail(String mailAddress, Tesserati tesserato) {
        if (mailAddress.isEmpty()) {
            view.messagePage("Impossibile registrare: dato non inserito");
        } else {
            model.recordMail(mailAddress, Integer.toString(tesserato.getNumTessera()));
            view.messagePage("Indirizzo email registrato correttamente");
        }
    }

    public void recordSubscription(Tesserati tesserato, Gare gara) {
        if (this.isSubscribed(tesserato, gara)) {
            view.messagePage("Il giocatore risulta iscritto");
        } else {
            model.recordSubscription(Integer.toString(tesserato.getNumTessera()), gara.getNomeGara(), LocalDate.now().toString());
            view.messagePage("Iscritto con successo");
        }
    }

    public boolean isSubscribed(Tesserati tesserato, Gare gara) {
        return model.isSubscribed(Integer.toString(tesserato.getNumTessera()), gara.getNomeGara());
    }

    public void retireSubscription(Tesserati tesserato, Gare gara) {
        if (!this.isSubscribed(tesserato, gara)) {
            view.messagePage("Il giocatore non risulta iscritto");
        } else {
            model.retireSubscription(Integer.toString(tesserato.getNumTessera()), gara.getNomeGara());
            view.messagePage("Iscrizione revocata correttamente");
        }
    }

    public boolean isOver(Gare elem) {
        return LocalDate.now().isAfter(elem.getDataInizio().toLocalDate().plusDays(elem.getDurata()));
    }

    public void getLeaderboard(Gare elem) {
        List<Tesserati> leaderboard = model.getLeaderboard(elem.getNomeGara());
        view.showLeaderboard(leaderboard);
    }

    public void getEntryList(Gare elem) {
        List<Tesserati> entryList = model.getEntryList(elem.getNomeGara());
        view.showEntryList(entryList);
    }

    public void handleResult(Gare gara) {
        List<Tesserati> availablePlayers = model.getLimitedEntryList(gara.getNomeGara(), gara.getMaxIscritti());
        view.insertPosition(gara, 1, availablePlayers);
    }

    public View getView() {
        return view;
    }

    public void changeStatus(Tesserati player) {
        if (player.getStatusProfessionista().equals("t")) {
            this.resignProStatus(player);
        } else if (player.getEraProfessionista().equals("f")) {
            this.turnPro(player);
        } else {
            view.messagePage("Impossibile assegnare lo status di professionista: il giocatore vi ha precedentemente rinunciato");
        }
    }

    public void toggleDisqualification(Tesserati player) {
        if (player.getSqualifica().equals("t")) {
            this.requalify(player);
        } else {
            this.disqualify(player);
        }
    }

    public void recordResult(Tesserati tesserato, Gare gara, int posizione, List<Tesserati> availablePlayers) {
        model.recordPosition(
            tesserato.getNumTessera(),
            gara.getNomeGara(),
            posizione,
            this.getOdMPoints(posizione, gara.getNomeGara())
        );

        availablePlayers.remove(tesserato);
        if (!availablePlayers.isEmpty()) {
            view.insertPosition(gara, posizione + 1, availablePlayers);
        } else {
            view.clubPage(model.findClub(gara.getNomeCircolo()).get());
            view.messagePage("Classifica registrata correttamente");
        }
    }

    private int getOdMPoints(int posizione, String nomeGara) {
        return model.getFinalPoints(posizione, nomeGara);
    }
}