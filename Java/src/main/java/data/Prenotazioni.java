package data;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class Prenotazioni {
    
    private String nomeCircolo;
    private String nomePercorso;
    private Date dataPrenotazione;
    private Time oraPrenotazione;
    private int numTessera1;
    private int numTessera2;
    private int numTessera3;
    private int numTessera4;

    Prenotazioni(String nomeCircolo, String nomePercorso, Date dataPrenotazione, Time oraPrenotazione, int numTessera1,
        int numTessera2, int numTessera3, int numTessera4) {
            this.nomeCircolo = nomeCircolo;
            this.nomePercorso = nomePercorso;
            this.dataPrenotazione = dataPrenotazione;
            this.oraPrenotazione = oraPrenotazione;
            this.numTessera1 = numTessera1;
            this.numTessera2 = numTessera2;
            this.numTessera3 = numTessera3;
            this.numTessera4 = numTessera4;
    }

    public String getNomePercorso() {
        return this.nomePercorso;
    }

    public Date getDataPrenotazione() {
        return this.dataPrenotazione;
    }

    public Time getOraPrenotazione(){
        return this.oraPrenotazione;
    }

    public int getNumTessera1() {
        return this.numTessera1;
    }

    public int getNumTessera2() {
        return this.numTessera2;
    }

    public int getNumTessera3() {
        return this.numTessera3;
    }

    public int getNumTessera4() {
        return this.numTessera4;
    }

    public static class DAO {

        public static Prenotazioni create(ResultSet resSet){
            try {
                var nomeCircolo = resSet.getString("nomecircolo");
                var nomePercorso = resSet.getString("nomepercorso");
                var dataPrenotazione = resSet.getDate("dataprenotazione");
                var oraPrenotazione = resSet.getTime("oraprenotazione");
                var numTessera1 = resSet.getInt("numtessera1");
                var numTessera2 = resSet.getInt("numtessera2");
                var numTessera3 = resSet.getInt("numtessera3");
                var numTessera4 = resSet.getInt("numtessera4");

                return new Prenotazioni(nomeCircolo, nomePercorso, dataPrenotazione, oraPrenotazione, numTessera1,
                    numTessera2, numTessera3, numTessera4);
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static List<Prenotazioni> getList(Connection connection, Circoli circolo) {
            List<Prenotazioni> res = new LinkedList<>();

            try (
                var statement = DAOUtils.prepare(connection, Queries.FIND_BOOKINGS, circolo.getNomeCircolo());
                var resSet = statement.executeQuery();
            ) {
                while(resSet.next()) {
                    res.add(Prenotazioni.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static Optional<Prenotazioni> find(Connection connection, String nomeCircolo, String nomePercorso,
                String data, String ora) {
            Optional<Prenotazioni> res = Optional.empty();

            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.FIND_BOOKING,
                    nomeCircolo,
                    nomePercorso,
                    data,
                    ora
                );
                var resSet = statement.executeQuery();
            ) {
                if (resSet.next()) {
                    res = Optional.of(Prenotazioni.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static void add(Connection connection, String nomeCircolo, String nomePercorso, String data, String ora,
                String player1, String player2, String player3, String player4) {
            try (
                var statement = DAOUtils.prepare(
                    connection, 
                    Queries.NEW_BOOKING,
                    nomeCircolo,
                    nomePercorso,
                    data,
                    ora,
                    player1,
                    player2,
                    player3,
                    player4
                );
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

    }

}
