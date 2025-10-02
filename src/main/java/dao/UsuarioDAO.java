package dao;

import conexion.conexionDB;
import modelo.Usuario;  // 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {
    
    // Método para registrar un usuario
    public boolean registrar(Usuario usuario) {
        String sql = "INSERT INTO usuarios(nombre, correo, password, celular, direccion, rol) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getCorreo());
            ps.setString(3, usuario.getPassword());
            ps.setString(4, usuario.getCelular());
            ps.setString(5, usuario.getDireccion());
            ps.setString(6, usuario.getRol());
            
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("❌ Error al registrar usuario: " + e.getMessage());
            return false;
        }
    }

    // Método para validar login
    public Usuario validarLogin(String correo, String password) {
        String sql = "SELECT * FROM usuarios WHERE correo=? AND password=?";
        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, correo);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setCorreo(rs.getString("correo"));
                u.setPassword(rs.getString("password"));
                u.setCelular(rs.getString("celular"));
                u.setDireccion(rs.getString("direccion"));
                u.setRol(rs.getString("rol"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println("❌ Error al validar login: " + e.getMessage());
        }
        return null;
    }
}
