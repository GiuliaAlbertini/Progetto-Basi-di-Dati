package data;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

public class Percorsi {
    
    private String nomeCircolo;
    private String nomePercorso;
    private int par;
    private float courseRating;
    
    Percorsi(String nomeCircolo, String nomePercorso, int par, float courseRating) {
        this.nomeCircolo = nomeCircolo;
        this.nomePercorso = nomePercorso;
        this.par = par;
        this.courseRating = courseRating;
    }

    public String getNomePercorso() {
        return this.nomePercorso;
    }

    public int getPar() {
        return this.par;
    }

    public float getCourseRating() {
        return this.courseRating;
    }

    public static class DAO {
        private static Percorsi create(ResultSet resSet) {
            try {
                var nomeCircolo = resSet.getString("nomecircolo");
                var nomePercorso = resSet.getString("nomepercorso");
                var par = resSet.getInt("par");
                var courseRating = resSet.getFloat("courserating");

                return new Percorsi(nomeCircolo, nomePercorso, par, courseRating);
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static List<Percorsi> findCoursesInClub(Connection connection, String clubName) {
            var res = new LinkedList<Percorsi>();

            try (
                var statement = DAOUtils.prepare(connection, Queries.FIND_COURSES_IN_CLUB, clubName);
                var resSet = statement.executeQuery();
            ) {
                while(resSet.next()) {
                    res.add(Percorsi.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }

        public static List<String> getCoursesNamesInClub(Connection connection, String nomeCircolo) {
            var courses = Percorsi.DAO.findCoursesInClub(connection, nomeCircolo);
            var res = new LinkedList<String>();

            for (var course : courses) {res.add(course.getNomePercorso());}

            return res;
        }

        public static void create(Connection connection, String nomeCircolo, String nomePercorso, String par, String courseRating) {
            try (
                var statement = DAOUtils.prepare(connection, Queries.NEW_COURSE, nomeCircolo, nomePercorso, par, courseRating);
            ) {
                statement.execute();
            } catch (Exception e) {
                throw new DAOException(e);
            }
        }

        public static Optional<Percorsi> find(Connection connection, String nomeCircolo, String nomePercorso) {
            Optional<Percorsi> res = Optional.empty();

            try (
                var statement = DAOUtils.prepare(connection, Queries.FIND_COURSE, nomeCircolo, nomePercorso);
                var resSet = statement.executeQuery();
            ) {
                if (resSet.next()) {res = Optional.of(Percorsi.DAO.create(resSet));}
            } catch (Exception e) {
                throw new DAOException(e);
            }

            return res;
        }
    }
}
