import data.DAOUtils;
import model.Model;

public class Main {
    public static void main(String[] args) {
        var connection = DAOUtils.localMySQLConnection("federgolf", "root", "BLS007ab&");
        var model = Model.fromConnection(connection);
        var view = new View(() -> {
            try {
                connection.close();
            } catch (Exception e) {}
        });
        var controller = new Controller(model, view);
        view.setController(controller);

        controller.homePage();
    }
}
