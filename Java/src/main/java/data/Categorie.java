package data;

public class Categorie {
    private String nomeCategoria;

    public static String getCategory(String durata, Object categoriaStatus) {
        
        if (categoriaStatus.equals("professionistica")) {
            switch (durata) {
                case "1":
                    return "d";
            
                case "2":
                    return "c";

                case "3":
                    return "b";

                case "4(solo per gare professionistiche)":
                    return "a";
            }
        } else {
            switch (durata) {
                case "1":
                    return "g";

                case "2":
                    return "f";

                case "3":
                    return "e";
            }
        }

        return "";
    }

    
}
