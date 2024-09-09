package data;

import java.util.List;
import java.util.LinkedList;

import java.sql.ResultSet;
import java.sql.Connection;

public class Cariche {
    
    private String nomeCarica;

    Cariche(String nomeCarica) {
        this.nomeCarica = nomeCarica;
    }

    public String toString() {
        return this.nomeCarica;
    }

    public String getNomeCarica() {
        return this.nomeCarica;
    }

    public static class DAO {
        private static Cariche create(ResultSet resSet) {
            try {
                return new Cariche(resSet.getString("nomecarica"));
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static List<Cariche> getList(Connection connection) {
            final List<Cariche> res = new LinkedList<>();

            try (
                var statement = DAOUtils.prepare(connection, Queries.LIST_TITLES);
                var resSet = statement.executeQuery();
            ) {
                while (resSet.next()) {
                    res.add(Cariche.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

    }

}
