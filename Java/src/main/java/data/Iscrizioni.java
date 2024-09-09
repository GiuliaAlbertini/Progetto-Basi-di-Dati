package data;

import java.sql.Connection;
import java.time.LocalDate;
import java.util.List;
import java.util.LinkedList;

public class Iscrizioni {
    
    private String nomeGara;
    private LocalDate dataIscrizione;
    private int puntiOttenuti;
    private int posizioneFinale;
    private int numTessera;

    public Iscrizioni(String nomeGara, LocalDate dataIscrizione, int puntiOttenuti, int posizioneFinale, int numTessera) {
        this.nomeGara = nomeGara;
        this.dataIscrizione = dataIscrizione;
        this.puntiOttenuti = puntiOttenuti;
        this.posizioneFinale = posizioneFinale;
        this.numTessera = numTessera;
    }

    public static class DAO {

        public static boolean exists(Connection connection, String numTessera, String nomeGara) {
            try (
                final var statement = DAOUtils.prepare(
                    connection,
                    Queries.FIND_SUBSCRIPTION,
                    numTessera,
                    nomeGara
                );
                var resSet = statement.executeQuery();
                ) {
                return resSet.next();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static void add(Connection connection, String numTessera, String nomeGara, String dateOfNow) {
            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.CREATE_SUBSCRIPTION,
                    numTessera,
                    nomeGara,
                    dateOfNow
                );
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static void retire(Connection connection, String numTessera, String nomeGara) {
            try (
                final var statement = DAOUtils.prepare(
                    connection,
                    Queries.RETIRE_SUBSCRIPTION,
                    numTessera,
                    nomeGara
                );
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static List<Tesserati> getLeaderboard(Connection connection, String nomeGara) {
            List<Tesserati> res = new LinkedList<>();

            try (
                final var statement = DAOUtils.prepare(connection, Queries.GET_LEADERBOARD, nomeGara);
                final var resSet = statement.executeQuery();
            ) {
                while (resSet.next()) {
                    res.add(
                        Tesserati.DAO.find(connection, Integer.toString(resSet.getInt("numtessera"))).get()
                    );
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static List<Tesserati> getEntryList(Connection connection, String nomeGara) {
            List<Tesserati> res = new LinkedList<>();

            try (
                final var proStatement = DAOUtils.prepare(
                    connection, 
                    Queries.GET_ENTRY_LIST_PRO,
                    nomeGara
                );
                var proResSet = proStatement.executeQuery();

                final var amStatement = DAOUtils.prepare(
                    connection,
                    Queries.GET_ENTRY_LIST_AM,
                    nomeGara
                );
                var amResSet = amStatement.executeQuery();
            ) {
                while (proResSet.next()) {
                    res.add(Tesserati.DAO.find(connection, Integer.toString(proResSet.getInt("numtessera"))).get());
                }

                while (amResSet.next()) {
                    res.add(Tesserati.DAO.find(connection, Integer.toString(amResSet.getInt("numtessera"))).get());
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

    }

}
