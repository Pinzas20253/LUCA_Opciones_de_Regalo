package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet("/registro")
public class RegistroControlador extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("nombre");
        String email = request.getParameter("correo"); // ⚡ corregido
        String password = request.getParameter("password");
        String celular = request.getParameter("celular");
        String direccion = request.getParameter("direccion");

        if (nombre == null || nombre.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "Complete los campos obligatorios (nombre, correo y contraseña).");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        String hashedPassword = hashSHA256(password);

        String sql = "INSERT INTO usuarios (nombre, correo, password, celular, direccion, rol) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = conexion.conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ps.setString(2, email);
            ps.setString(3, hashedPassword); // guardamos el hash
            ps.setString(4, celular);
            ps.setString(5, direccion);
            ps.setString(6, "cliente"); // rol por defecto

            int filas = ps.executeUpdate();

            if (filas > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", nombre);
                session.setAttribute("rol", "cliente");
                response.sendRedirect("bienvenido.jsp");
            } else {
                request.setAttribute("error", "No se pudo completar el registro. Intente nuevamente.");
                request.getRequestDispatcher("registro.jsp").forward(request, response);
            }

        } catch (SQLIntegrityConstraintViolationException ex) {
            request.setAttribute("error", "El correo electrónico ya está registrado.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);

        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error de base de datos: " + ex.getMessage());
            request.getRequestDispatcher("registro.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error inesperado: " + ex.getMessage());
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("registro.jsp");
    }

    // Método para generar hash SHA-256
    private String hashSHA256(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] resultado = md.digest(input.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : resultado) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return input;
        }
    }
}
