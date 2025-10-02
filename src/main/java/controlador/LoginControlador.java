package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import modelo.Usuario;
import dao.UsuarioDAO;

@WebServlet("/login")
public class LoginControlador extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Ingrese correo y contraseña.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Hashea la contraseña con SHA-256
        String hashedPassword = hashSHA256(password);

        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.validarLogin(email, hashedPassword);

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario.getNombre());
            session.setAttribute("rol", usuario.getRol());

            // Redirección según rol
            if ("administrador".equalsIgnoreCase(usuario.getRol())) {
                response.sendRedirect(request.getContextPath() + "/administrar_productos.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }

        } else {
            request.setAttribute("error", "Correo o contraseña incorrectos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
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
