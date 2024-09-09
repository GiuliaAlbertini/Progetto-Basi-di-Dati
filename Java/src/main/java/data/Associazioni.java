package data;

import java.sql.Connection;
import java.sql.ResultSet;
import java.time.Year;
import java.util.Optional;

public class Associazioni {
    
    private String nomeCircolo;
    private int numTessera;
    private int anno;

    Associazioni(String nomeCircolo, int numTessera, int anno) {
        this.nomeCircolo = nomeCircolo;
        this.numTessera = numTessera;
        this.anno = anno;
    }

    public static class DAO {

        private static Associazioni create(ResultSet resSet) {
            try {
                final var nomeCircolo = resSet.getString("nomecircolo");
                final var numTessera = resSet.getInt("numtessera");
                final var anno = resSet.getInt("anno");

                return new Associazioni(nomeCircolo, numTessera, anno);
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static Optional<Associazioni> find(Connection connection, Circoli circolo, String number, int year) {
            Optional<Associazioni> res = Optional.empty();

            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.FIND_ASSOCIATION,
                    number,
                    year
                );
                var resSet = statement.executeQuery();
            ) {
                if (resSet.next()) {
                    res = Optional.of(Associazioni.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static void register(Connection connection, Circoli circolo, String number) {
            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.NEW_ASSOCIATION,
                    circolo.getNomeCircolo(),
                    number,
                    Year.now().getValue()
                )
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

    }
}
