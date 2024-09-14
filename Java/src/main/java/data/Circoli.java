package data;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class Circoli {
    
    private String nomeCircolo;
    private String indirizzo;
    private final List<Percorsi> percorsi = new LinkedList<Percorsi>();

    Circoli(String nomeCircolo, String indirizzo, Percorsi... percorsi) {
        this.nomeCircolo = nomeCircolo;
        this.indirizzo = indirizzo;
    }

    public String getNomeCircolo() {
        return this.nomeCircolo;
    }

    public String getIndirizzo() {
        return this.indirizzo;
    }

    public List<Percorsi> getPercorsi() {
        return List.copyOf(this.percorsi);
    }

    public void addPercorso(Percorsi percorso) {
        this.percorsi.add(percorso);
    }

    public final class DAO {
        private static Circoli create(ResultSet resSet) {
            try {
                var nomeCircolo = resSet.getString("nomecircolo");
                var indirizzo = resSet.getString("indirizzo");

                return new Circoli(nomeCircolo, indirizzo);
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }
        
        public final static Optional<Circoli> find(Connection connection, String clubName) {
            Optional<Circoli> res = Optional.empty();

            try (
                var statement = DAOUtils.prepare(connection, Queries.FIND_CLUB, clubName);
                var resSet = statement.executeQuery();
            ) {
                if (resSet.next()) {
                    res = Optional.of(Circoli.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static List<Circoli> clubList(Connection connection) {
            var res = new LinkedList<Circoli>();

            try (
                var statement = DAOUtils.prepare(connection, Queries.LIST_CLUBS);
                var resSet = statement.executeQuery();
            ) {
                while (resSet.next()) {
                    var club = Circoli.DAO.create(resSet);
                    for (var course : Percorsi.DAO.findCoursesInClub(connection, club.getNomeCircolo())) {
                        club.addPercorso(course);
                    }

                    res.add(club);
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static void registerNew(Connection connection, String clubName, String address) {
            try (
                var statement = DAOUtils.prepare(connection, Queries.REGISTER_CLUB, clubName, address);
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }
    }

}
