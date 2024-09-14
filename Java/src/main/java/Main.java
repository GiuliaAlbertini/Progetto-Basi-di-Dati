import java.sql.Connection;

import data.DAOUtils;
import model.Model;

public class Main {
    public static void main(String[] args) {
        View.databaseLoginPage();
    }

    public static void handleLoginData(String username, String password) {
        Connection connection = null;
        try {
            connection = DAOUtils.localMySQLConnection("federgolf", username, password);
        } catch (Exception e) {
            View.loginDataError();
        }

        runApp(connection);
    }

    public static void runApp(Connection connection) {
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
