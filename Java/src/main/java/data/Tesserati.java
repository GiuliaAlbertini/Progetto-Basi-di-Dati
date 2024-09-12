package data;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class Tesserati {

    private int numTessera;
    private int numCertificato;
    private String nome;
    private String cognome;
    private Date dataDiNascita;
    private String email;
    private String telefono;
    private String statusProfessionista;
    private String eraProfessionista;
    private int puntiOdM;
    private String squalifica;

    public Tesserati(int numTessera, int numCertificato, String nome, String cognome, Date dataDiNascita,
            String email, String telefono, String statusProfessionista, String eraProfessionista, int puntiOdM,
            String squalifica) {
        this.numCertificato = numCertificato;
        this.numTessera = numTessera;
        this.nome = nome;
        this.cognome = cognome;
        this.dataDiNascita = dataDiNascita;
        this.email = email;
        this.telefono = telefono;
        this.statusProfessionista = statusProfessionista;
        this.eraProfessionista = eraProfessionista;
        this.puntiOdM = puntiOdM;
        this.squalifica = squalifica;
    }

    public int getNumTessera() {
        return this.numTessera;
    }

    public int getNumCertificato() {
        return this.numCertificato;
    }

    public String getName() {
        return this.nome;
    }

    public String getSurname() {
        return this.cognome;
    }

    public Date getDataDiNascita() {
        return this.dataDiNascita;
    }

    public String getEmail() {
        return this.email;
    }

    public String getTelefono() {
        return this.telefono;
    }

    public String getStatusProfessionista() {
        return this.statusProfessionista;
    }

    public String getEraProfessionista() {
        return this.eraProfessionista;
    }

    public int getOdMPoints() {
        return this.puntiOdM;
    }

    public String getSqualifica() {
        return this.squalifica;
    }

    public String toString() {
        return Integer.toString(this.numTessera) + ", " + this.nome + " " + this.cognome;
    }

    public final class DAO {
        private static Tesserati create(ResultSet resSet) {
            try {
                var numTessera = resSet.getInt("numtessera");
                var numCertificato = resSet.getInt("numcertificato");
                var nome = resSet.getString("nome");
                var cognome = resSet.getString("cognome");
                var dataDiNascita = resSet.getDate("datadinascita");
                var email = resSet.getString("email");
                var telefono = resSet.getString("telefono");
                var statusProfessionista = resSet.getString("statusprofessionista");
                var eraProfessionista = resSet.getString("eraprofessionista");
                var puntiOdM = resSet.getInt("puntiodm");
                var squalifica = resSet.getString("squalifica");

                return new Tesserati(
                    numTessera, 
                    numCertificato, 
                    nome, 
                    cognome, 
                    dataDiNascita, 
                    email, 
                    telefono, 
                    statusProfessionista,
                    eraProfessionista,
                    puntiOdM,
                    squalifica
                );
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static Optional<Tesserati> find(Connection connection, String playerNumber) {
            Optional<Tesserati> res = Optional.empty();

            try (
                var statement = DAOUtils.prepare(connection, Queries.FIND_PLAYER, playerNumber);
                var resSet = statement.executeQuery();
            ) {
               if (resSet.next()) {
                res = Optional.of(Tesserati.DAO.create(resSet));
               } 
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static List<Tesserati> oderOfMerit(Connection connection) {
            var resList = new LinkedList<Tesserati>();

            try (
                var statement = DAOUtils.prepare(connection, Queries.VIEW_ORDER_OF_MERIT);
                var resSet = statement.executeQuery();
            ) {
                while(resSet.next()) {
                    resList.add(Tesserati.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return resList;
        }

        public static void registerNew(Connection connection, String name, String surname, String dateOfBirth) {
            try (
                var statement = DAOUtils.prepare(connection, Queries.REGISTER_PLAYER, name, surname, dateOfBirth);
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static void resignProStatus(Connection connection, Tesserati player) {
            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.RESIGN_PRO_STATUS,
                    Integer.toString(player.getNumTessera())
                )
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static void turnPro(Connection connection, Tesserati player) {
            try (
                var statement = DAOUtils.prepare(
                    connection, 
                    Queries.TURN_PRO,
                    Integer.toString(player.getNumTessera())
                )
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static void disqualify(Connection connection, Tesserati player) {
            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.DISQUALIFY,
                    Integer.toString(player.getNumTessera())
                )
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static void requalify(Connection connection, Tesserati player) {
            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.REQUALIFY,
                    Integer.toString(player.getNumTessera())
                )
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static void remove(Connection connection, Tesserati player) {
            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.REMOVE_PLAYER,
                    player.getNumTessera()
                )
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static List<Tesserati> membersOf(Connection connection, Circoli circolo) {
            List<Tesserati> res = new LinkedList<>();

            try (
                var statement = DAOUtils.prepare(connection, Queries.MEMBERS_OF, circolo.getNomeCircolo());
                var resSet = statement.executeQuery();
            ) {
                while(resSet.next()) {
                    res.add(Tesserati.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static void recordPhone(Connection connection, String playerNumber, String phoneNumber) {
            try (
                final var statement = DAOUtils.prepare(
                    connection, 
                    Queries.RECORD_PHONE,
                    phoneNumber,
                    playerNumber
                );
            ) {
               statement.execute(); 
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static void recordMail(Connection connection, String mailAddress, String playerNumber) {
            try (
                final var statement = DAOUtils.prepare(
                    connection, 
                    Queries.RECORD_MAIL, 
                    mailAddress,
                    playerNumber
                );
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static List<Tesserati> getNonPositionedInTournament(Connection connection, String nomeGara) {
            List<Tesserati> res = new LinkedList<>();

            try (
                final var statement = DAOUtils.prepare(connection, Queries.FIND_NON_POSITIONED, nomeGara);
                var resSet = statement.executeQuery();
            ) {
                while (resSet.next()) {
                    res.add(Tesserati.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }
    }

}
