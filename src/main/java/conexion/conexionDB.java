package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class conexionDB {
    // Asegúrate que el nombre de la BD aquí coincida con la que tienes en MySQL
    private static final String URL = "jdbc:mysql://localhost:3306/luca_opciones_de_regalo";
    private static final String USER = "root";
    // Si tu usuario root tiene contraseña, ponla aquí; si no, deja ""
    private static final String PASSWORD = "Luca12345*";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
