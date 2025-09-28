package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conexion.conexionDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginControlador")
public class LoginControlador extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String contraseña = request.getParameter("contraseña");

        // Validación rápida de parámetros
        if (correo == null || correo.isBlank() || contraseña == null || contraseña.isBlank()) {
            request.setAttribute("error", "Por favor ingrese correo y contraseña.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String sql = "SELECT id_usuario, nombre, rol FROM usuarios WHERE correo = ? AND contraseña = ?";

        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, correo.trim());
            ps.setString(2, contraseña.trim()); // 🔒 En producción usar hash (ej: BCrypt)

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int idUsuario = rs.getInt("id_usuario");
                    String nombre = rs.getString("nombre");
                    String rol = rs.getString("rol");

                    // Crear sesión segura
                    HttpSession session = request.getSession(true);
                    session.setAttribute("id_usuario", idUsuario);
                    session.setAttribute("nombre_usuario", nombre);
                    session.setAttribute("rol_usuario", rol);

                    // 🔐 Recomendación: configurar tiempo de expiración de sesión
                    session.setMaxInactiveInterval(30 * 60); // 30 minutos

                    // Redirigir según rol
                    if ("admin".equalsIgnoreCase(rol)) {
                        response.sendRedirect("administrar_productos.jsp");
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                } else {
                    // Usuario o clave incorrecta
                    request.setAttribute("error", "⚠️ Correo o contraseña incorrectos.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Error en la base de datos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
