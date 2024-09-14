package data;

import java.sql.Connection;

public class Riserve {
    
    private String nomeCircolo;
    private String nomeCarica;
    private int maxNomine;

    public static class DAO {

        public static int limit(Connection connection, String nomeCircolo, String nomeCarica) {
            try (
                var statement = DAOUtils.prepare(connection, Queries.GET_MAX_TITLES, nomeCarica, nomeCircolo);
                var resSet = statement.executeQuery();
            ) {
                resSet.next();
                return resSet.getInt("maxnomine");
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static void registerLimit(Connection connection, String clubName, String titleName, String maxNomine) {
            try (
                final var statement = DAOUtils.prepare(
                    connection,
                    Queries.NEW_TITLE_LIMIT,
                    clubName,
                    titleName,
                    maxNomine
                );
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

    }
    
}
