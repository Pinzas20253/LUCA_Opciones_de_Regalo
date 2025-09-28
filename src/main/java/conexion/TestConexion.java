package conexion;

import java.sql.Connection;

public class TestConexion {
    public static void main(String[] args) {
        try {
            Connection conn = conexionDB.getConnection();
            System.out.println("✅ Conexión exitosa a la base de datos.");
            conn.close();
        } catch (Exception e) {
            System.out.println("❌ Error en la conexión:");
            e.printStackTrace();
        }
    }
}
