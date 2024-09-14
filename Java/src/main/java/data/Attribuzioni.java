package data;

import java.sql.Connection;
import java.sql.ResultSet;

import java.time.Year;
import java.util.Optional;

public class Attribuzioni {
    
    private String nomeCircolo;
    private String nomeCarica;
    private int anno;
    private int numTessera;

    Attribuzioni(String nomeCircolo, String nomeCarica, int anno, int numTessera) {
        this.nomeCircolo = nomeCircolo;
        this.nomeCarica = nomeCarica;
        this.anno = anno;
        this.numTessera = numTessera;
    }
    
    public static class DAO {
        private static Attribuzioni create(ResultSet resSet) {
            try {
                return new Attribuzioni(
                    resSet.getString("nomecircolo"),
                    resSet.getString("nomecarica"),
                    resSet.getInt("anno"),
                    resSet.getInt("numtessera")
                );
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static int count(Connection connection, String nomeCircolo, String nomeCarica) {
            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.COUNT_ASSIGNED_TITLES,
                    nomeCarica,
                    nomeCircolo,
                    Year.now().toString()
                );
                var resSet = statement.executeQuery();
            ) {
                resSet.next();
                return resSet.getInt("numerocariche");
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static void add(Connection connection, String nomeCircolo, String numTessera, String nomeCarica) {
            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.NEW_TITLE_NOMINATION,
                    nomeCarica,
                    numTessera,
                    nomeCircolo,
                    Integer.toString(Year.now().getValue())
                );
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static Optional<Attribuzioni> find(Connection connection, String nomeCircolo, String numTessera,
                String nomeCarica) {
            Optional<Attribuzioni> res = Optional.empty();
            
            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.FIND_TITLE_ASSIGNMENT,
                    nomeCircolo,
                    numTessera,
                    nomeCarica,
                    Integer.toString(Year.now().getValue())
                );
                var resSet = statement.executeQuery();
            ) {
                if (resSet.next()) {
                    res = Optional.of(Attribuzioni.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

    }

}
