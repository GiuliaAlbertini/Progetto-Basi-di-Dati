package data;

public class Queries {

        public static final String FIND_CLUB = 
        """
                SELECT *
                FROM circoli
                WHERE nomecircolo = ?
                """
        ;
        public static final String FIND_PLAYER = 
        """
                SELECT *
                FROM tesserati
                WHERE numtessera = ?
                """
        ;
        public static final String VIEW_ORDER_OF_MERIT = 
        """
                SELECT *
                FROM tesserati
                WHERE statusprofessionista = 'f'
                AND numcertificato IS NOT NULL
                ORDER BY puntiodm DESC     
                """
        ;
        public static final String VIEW_TOURNAMENT_LIST = 
        """
                SELECT *
                FROM gare
                ORDER BY datainizio        
                """
        ;
        public static final String LIST_CLUBS = 
        """
                SELECT *
                FROM circoli
                ORDER BY nomecircolo
                """
        ;
        public static final String FIND_COURSES_IN_CLUB = 
        """
                SELECT *
                FROM percorsi
                WHERE nomecircolo = ?
                """
        ;
        public static final String UPDATE_ODM = 
        """
                WITH pc
                AS ( 
                SELECT numtessera, sum(puntiottenuti) as punti
                FROM iscrizioni i
                GROUP BY numtessera
                )

                UPDATE tesserati t SET puntiodm = (SELECT pc.punti FROM pc WHERE pc.numtessera = t.numtessera)
                WHERE t.numtessera IN (SELECT pc.numtessera FROM pc);        
                """
        ;
        public static final String REGISTER_PLAYER =
        """
                INSERT INTO tesserati(nome, cognome, datadinascita)
                VALUES (?, ?, ?)
                """
        ;
        public static final String REGISTER_CLUB = 
        """
                INSERT INTO circoli(nomecircolo, indirizzo)
                VALUES (?, ?)
                """
        ;
        public static final String RESIGN_PRO_STATUS = 
        """
                UPDATE tesserati
                SET statusprofessionista = 'f', eraprofessionista = 't'
                WHERE numtessera = ?
                """
        ;
        public static final String TURN_PRO = 
        """
                UPDATE tesserati
                SET statusprofessionista = 't'
                WHERE numtessera = ?
                """
        ;
        public static final String DISQUALIFY = 
        """
                UPDATE tesserati
                SET squalifica = 't'
                WHERE numtessera = ?
                """
        ;
        public static final String REQUALIFY =
        """
                UPDATE tesserati
                SET SQUALIFICA = 'f'
                WHERE numtessera = ?        
                """;
        public static final String REMOVE_PLAYER = 
        """
                DELETE FROM tesserati
                WHERE numtessera = ?
                """
        ;
        public static final String REMOVE_CLUB = 
        """
                DELETE FROM circoli
                WHERE nomecircolo = ?
                """
        ;
        public static final String MEMBERS_OF =
        """
                SELECT t.*
                FROM tesserati t, associazioni a
                WHERE t.numtessera = a.numtessera
                AND a.nomecircolo = ?
                """
        ;
        public static final String FIND_ASSOCIATION = 
        """
                SELECT *
                FROM associazioni
                WHERE numtessera = ?
                AND anno = ?
                """
        ;
        public static final String NEW_ASSOCIATION =
        """
                INSERT INTO associazioni(nomecircolo, numtessera, anno)
                VALUES (?, ?, ?)
                """
        ;
        public static final String FIND_BOOKINGS = 
        """
                SELECT *
                FROM prenotazioni
                WHERE nomecircolo = ?
                ORDER BY dataprenotazione, oraprenotazione
                """
        ;
        public static final String FIND_TOURNAMENT =
        """
                SELECT *
                FROM gare
                WHERE nomegara = ?
                """
        ;
        public static final String ADD_TOURNAMENT = 
        """
                INSERT INTO gare(nomecircolo, nomepercorso, nomegara, datainizio, durata, maxiscritti, datachiusuraiscrizioni, categoriastatus, nomecategoria)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """
        ;
        public static final String NEW_COURSE = 
        """
                INSERT INTO percorsi(nomecircolo, nomepercorso, par, courserating)
                VALUES(?, ?, ?, ?)
                """
        ;
        public static final String FIND_COURSE = 
        """
                SELECT *
                FROM percorsi
                WHERE nomecircolo = ?
                AND nomepercorso = ?
                """
        ;
        public static final String LIST_TITLES = 
        """
                SELECT *
                FROM cariche
                """
        ;
        public static final String COUNT_ASSIGNED_TITLES = 
        """
                SELECT COUNT(*) as numerocariche
                FROM attribuzioni
                WHERE nomecarica = ?
                AND nomecircolo = ?
                """
        ;
        public static final String GET_MAX_TITLES = 
        """
                SELECT maxnomine
                FROM riserve
                WHERE nomecarica = ?
                AND nomecircolo = ?        
                """
        ;
        public static final String NEW_TITLE_NOMINATION = 
        """
                INSERT INTO attribuzioni(nomecarica, numtessera, nomecircolo, anno)
                VALUES (?, ?, ?, ?)                
                """
        ;
        public static final String FIND_TITLE_ASSIGNMENT = 
        """
                SELECT *
                FROM attribuzioni
                WHERE nomecircolo = ?
                AND numtessera = ?
                AND nomecarica = ?
                AND anno = ?
                """
        ;
        public static final String FIND_BOOKING = 
        """
                SELECT *
                FROM prenotazioni
                WHERE nomecircolo = ?
                AND nomepercorso = ?
                AND dataprenotazione = ?
                AND oraprenotazione = ?
                """
        ;
        public static final String NEW_BOOKING = 
        """
                INSERT INTO prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """
        ;
        public static final String NEW_CERTIFICATE = 
        """
                INSERT INTO certificati_medici(emissione, scadenza)
                VALUES (?, ?)
                """
        ;
        public static final String ASSIGN_CERTIFICATE = 
        """
                UPDATE tesserati
                SET numcertificato = (SELECT MAX(c.numcertificato) FROM certificati_medici c)
                WHERE numtessera = ?
                """
        ;
        public static final String RECORD_PHONE = 
        """
                UPDATE tesserati
                SET telefono = ?
                WHERE numtessera = ?
                """
        ;
        public static final String RECORD_MAIL = 
        """
                UPDATE tesserati
                SET email = ?
                WHERE numtessera = ?
                """
        ;
        public static final String AVAILABLE_TOURNAMENTS = 
        """
                SELECT *
                FROM gare
                WHERE (categoriastatus = 'p' OR categoriastatus = ?)
                AND datachiusuraiscrizioni > ?
                """
        ;
        public static final String FIND_SUBSCRIPTION = 
        """
                SELECT *
                FROM iscrizioni
                WHERE numtessera = ?
                AND nomegara = ?
                """
        ;
        public static final String CREATE_SUBSCRIPTION = 
        """
                INSERT INTO iscrizioni(numtessera, nomegara, dataiscrizione)
                VALUES (?, ?, ?)
                """
        ;
        public static final String RETIRE_SUBSCRIPTION =
        """
                DELETE FROM iscrizioni
                WHERE numtessera = ?
                AND nomegara = ?
                """
        ;
        public static final String GET_LEADERBOARD = 
        """
                SELECT *
                FROM iscrizioni
                WHERE nomegara = ?
                ORDER BY posizionefinale
                """
        ;
        public static final String GET_ENTRY_LIST_PRO =
        """
                SELECT i.*
                FROM iscrizioni i, tesserati t
                WHERE i.numtessera = t.numtessera
                AND t.statusprofessionista = 't'
                AND i.nomegara = ?
                ORDER BY i.dataiscrizione
                """
        ;
        public static final String GET_ENTRY_LIST_AM =
        """
                SELECT i.*
                FROM iscrizioni i, tesserati t
                WHERE i.numtessera = t.numtessera
                AND t.statusprofessionista = 'f'
                AND i.nomegara = ?
                ORDER BY t.puntiodm DESC
                """
        ;
        public static final String FIND_CERTIFICATE =
        """
                SELECT c.*
                FROM certificati_medici c, tesserati t
                WHERE t.numcertificato IS NOT NULL
                AND t.numtessera = ?
                AND c.numcertificato = t.numcertificato
                """
        ;
        public static final String GET_CERTIFICATE_EXPIRATION =
        """
                SELECT c.scadenza
                FROM certificati_medici c, tesserati t
                WHERE numtessera = ?
                AND c.numcertificato = t.numcertificato
                """
        ;
        public static final String FIND_TOURNAMENTS_IN_CLUB =
        """
                SELECT *
                FROM gare
                WHERE nomecircolo = ?
                ORDER BY datainizio
                """
        ;
        public static final String FIND_RESULTS = 
        """
                SELECT i.*
                FROM iscrizioni i, gare g
                WHERE i.nomegara = g.nomegara
                AND i.numtessera = ?
                ORDER BY g.datainizio DESC
                LIMIT 10
                """
        ;
        public static final String COUNT_PRO_ENTRIES =
        """
                SELECT COUNT(*) AS numpro
                FROM iscrizioni i, tesserati t
                WHERE t.statusprofessionista = 't'
                AND i.numtessera = t.numtessera
                AND i.nomegara = ?
                LIMIT ?
                """
        ;
        public static final String CLEAR_PRO = 
        """
                DELETE FROM iscrizioni i
                WHERE i.nomegara = ?
                AND NOT EXISTS (SELECT *
                                FROM iscrizioni i1, tesserati t
                                WHERE t.statusprofessionista = 't'
                                AND i1.numtessera = t.numtessera
                                AND i1.nomegara = i.nomegara
                                LIMIT ?)
                """
        ;
        public static final String CLEAR_AM = 
        """
                DELETE FROM iscrizioni i
                WHERE i.nomegara = ?
                AND NOT EXISTS (SELECT *
                                FROM iscrizioni i1, tesserati t
                                WHERE t.statusprofessionista = 'f'
                                AND i1.numtessera = t.numtessera
                                LIMIT ?)
                """
        ;
        public static final String FIND_NON_POSITIONED = 
        """
                SELECT t.*
                FROM tesserati t, iscrizioni i
                WHERE i.nomegara = ?
                AND t.numtessera = i.numtessera
                AND i.posizionefinale IS NULL
                """
        ;
        public static final String GET_POINTS_FROM_POSITION = 
        """
                SELECT *
                FROM posizionamenti p, gare g
                WHERE p.posizione = ?
                AND g.nomegara = ?
                AND g.nomecategoria = p.nomecategoria
                """
        ;
        public static final String UPDATE_RESULT = 
        """
                UPDATE iscrizioni
                SET posizionefinale = ?, puntiottenuti = ?
                WHERE numtessera = ?
                AND nomegara = ?
                """
        ;

    
}
