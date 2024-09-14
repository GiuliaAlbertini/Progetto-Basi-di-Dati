package data;

import java.sql.Connection;
import java.util.LinkedList;
import java.util.List;

public class Stats {
    Tesserati tesserato;
    List<Iscrizioni> ultimeGare;
    float mediaPunti;

    Stats(Tesserati tesserato, List<Iscrizioni> ultimeGare, float mediaPunti) {
        this.tesserato = tesserato;
        this.ultimeGare = ultimeGare;
        this.mediaPunti = mediaPunti;
    }

    public Tesserati getTesserato() {
        return this.tesserato;
    }

    public List<Iscrizioni> getUltimeGare() {
        return List.copyOf(this.ultimeGare);
    }

    public float getMediaPunti() {
        return this.mediaPunti;
    }

    public static class DAO {

        public static Stats get(Connection connection, int numTessera) {
            final var tesserato = Tesserati.DAO.find(connection, Integer.toString(numTessera)).get();

            final List<Iscrizioni> ultimeGare = new LinkedList<>();
            try (
                final var statement = DAOUtils.prepare(connection, Queries.FIND_RESULTS, numTessera);
                var resSet = statement.executeQuery();
            ) {
                while (resSet.next()) {
                    ultimeGare.add(Iscrizioni.DAO.create(resSet));
                }
            } catch (Exception e) {
                throw new DAOException(e);
            }

            float mediaPunti = 0;
            for (var gara : ultimeGare) {
                mediaPunti = mediaPunti + gara.getPuntiOttenuti();
            }
            mediaPunti = mediaPunti / ultimeGare.size();

            return new Stats(tesserato, ultimeGare, mediaPunti);
        }

    }
}
