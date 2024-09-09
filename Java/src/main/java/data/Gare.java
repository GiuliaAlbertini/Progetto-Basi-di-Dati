package data;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class Gare {

    private String nomeGara;
    private int durata;
    private Date dataInizio;
    private String categoriaStatus;
    private int maxIscritti;
    private Date dataChiusuraIscrizioni;
    private String nomeCircolo;
    private String nomePercorso;
    private String nomeCategoria;

    public Gare(String nomeGara, int durata, Date dataInizio, String categoriaStatus, int maxIscritti,
            Date dataChiusuraIscrizioni, String nomeCircolo, String nomePercorso, String nomeCategoria) {
        this.nomeGara = nomeGara;
        this.durata = durata;
        this.dataInizio = dataInizio;
        this.categoriaStatus = categoriaStatus;
        this.maxIscritti = maxIscritti;
        this.dataChiusuraIscrizioni = dataChiusuraIscrizioni;
        this.nomeCircolo = nomeCircolo;
        this.nomePercorso = nomePercorso;
        this.nomeCategoria = nomeCategoria;
    }

    public String getNomeGara() {
        return this.nomeGara;
    }

    public int getDurata() {
        return this.durata;
    }

    public Date getDataInizio() {
        return this.dataInizio;
    }

    public String getCategoriaStatus() {
        return this.categoriaStatus;
    }

    public int getMaxIscritti() {
        return this.maxIscritti;
    }

    public Date getDataChiusuraIscrizioni() {
        return this.dataChiusuraIscrizioni;
    }

    public String getNomeCircolo() {
        return this.nomeCircolo;
    }

    public String getNomePercorso() {
        return this.nomePercorso;
    }

    public String getCategoriaOdM() {
        return this.nomeCategoria;
    }

    public static class DAO {
        private static Gare create(ResultSet resSet) {
            try {
                var nomeGara = resSet.getString("nomegara");
                var durata = resSet.getInt("durata");
                var dataInizio = resSet.getDate("datainizio");
                var categoriaStatus = resSet.getString("categoriastatus");
                var maxIscritti = resSet.getInt("maxiscritti");
                var dataChiusuraIscrizioni = resSet.getDate("datachiusuraiscrizioni");
                var nomeCircolo = resSet.getString("nomecircolo");
                var nomePercorso = resSet.getString("nomepercorso");
                var nomeCategoria = resSet.getString("nomecategoria");

                return new Gare(
                    nomeGara,
                    durata,
                    dataInizio,
                    categoriaStatus,
                    maxIscritti,
                    dataChiusuraIscrizioni,
                    nomeCircolo,
                    nomePercorso,
                    nomeCategoria
                );
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static List<Gare> tournamentList(Connection connection) {
            var res = new LinkedList<Gare>();

            try (
                var statement = DAOUtils.prepare(connection, Queries.VIEW_TOURNAMENT_LIST);
                var resSet = statement.executeQuery();
            ) {
                while (resSet.next()) {
                    res.add(Gare.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static Optional<Gare> find(Connection connection, String nomeGara) {
            Optional<Gare> res = Optional.empty();

            try (
                final var statement = DAOUtils.prepare(connection, Queries.FIND_TOURNAMENT, nomeGara);
                var resSet = statement.executeQuery();
            ) {
                if (resSet.next()) {
                    res = Optional.of(Gare.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static void addNew(Connection connection, String nomeCircolo, String nomePercorso, String nomeGara, 
                String dataInizio, String durata, String maxIscritti, String dataChiusuraIscrizioni, String status,
                String categoria) {
            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.ADD_TOURNAMENT,
                    nomeCircolo,
                    nomePercorso,
                    nomeGara,
                    dataInizio,
                    durata,
                    maxIscritti,
                    dataChiusuraIscrizioni,
                    status,
                    categoria
                );
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static List<Gare> getTournamentList(Connection connection, String statusProfessionista, String dateOfNow) {
            List<Gare> res = new LinkedList<>();
            
            try (
                var statement = DAOUtils.prepare(
                    connection,
                    Queries.AVAILABLE_TOURNAMENTS,
                    statusProfessionista,
                    dateOfNow
                );
                var resSet = statement.executeQuery();
            ) {
                while(resSet.next()) {
                    res.add(Gare.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static List<Gare> getTournamentsInClub(Connection connection, String nomeCircolo) {
            List<Gare> res = new LinkedList<>();

            try (
                final var statement = DAOUtils.prepare(connection, Queries.FIND_TOURNAMENTS_IN_CLUB, nomeCircolo);
                var resSet = statement.executeQuery();
            ) {
                while(resSet.next()) {
                    res.add(Gare.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

    }

}
