package data;

import java.sql.Connection;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.Optional;

public class CertificatiMedici {
    
    private int numTessera;
    private LocalDate emissione;
    private LocalDate scadenza;

    CertificatiMedici(int numTessera, LocalDate emissione, LocalDate scadenza) {
        this.numTessera = numTessera;
        this.emissione = emissione;
        this.scadenza = scadenza;
    }

    public static class DAO {

        private static CertificatiMedici create(ResultSet resSet) {
            try {
                return new CertificatiMedici(
                    resSet.getInt("numcertificato"),
                    resSet.getDate("emissione").toLocalDate(),
                    resSet.getDate("scadenza").toLocalDate()
                );
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static void add(Connection connection, String emissionDate, String expireDate, String playerNumber) {
            try (
                final var creationStatement = DAOUtils.prepare(
                    connection, 
                    Queries.NEW_CERTIFICATE, 
                    emissionDate,
                    expireDate
                );
                final var registrationStatement = DAOUtils.prepare(
                    connection, 
                    Queries.ASSIGN_CERTIFICATE, 
                    playerNumber
                );
            ) {
                creationStatement.execute();
                registrationStatement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static Optional<CertificatiMedici> find(Connection connection, int numTessera) {
            Optional<CertificatiMedici> res = Optional.empty();

            try (
                final var statement = DAOUtils.prepare(connection, Queries.FIND_CERTIFICATE, numTessera);
                var resSet = statement.executeQuery();
            ) {
                if (resSet.next()) {
                    res = Optional.of(CertificatiMedici.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static LocalDate getExpirydate(Connection connection, int numCertificato) {
            try (
                final var statement = DAOUtils.prepare(connection, Queries.GET_CERTIFICATE_EXPIRATION, numCertificato);
                var resSet = statement.executeQuery();
            ) {
                if (resSet.next()) {
                    return resSet.getDate("scadenza").toLocalDate();
                } else {
                    return LocalDate.MIN;
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

    }

}
