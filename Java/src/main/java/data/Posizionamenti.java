package data;

import java.sql.Connection;

public class Posizionamenti {
    
    private String nomeCategoria;
    private int posizione;
    private int punteggio;

    public static class DAO {

        public static int getOdMPoints(Connection connection, int posizione, String nomeGara) {
            try (
                final var statement = DAOUtils.prepare(
                    connection,
                    Queries.GET_POINTS_FROM_POSITION,
                    posizione,
                    nomeGara
                );
                var resSet = statement.executeQuery();
            ) {
                resSet.next();
                return resSet.getInt("punteggio");
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

    }

}
