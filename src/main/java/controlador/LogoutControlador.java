package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LogoutControlador")
public class LogoutControlador extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtiene la sesión actual, si existe
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Invalida la sesión para cerrar la sesión del usuario
            session.invalidate();
        }

        // Redirige a la página principal
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Maneja POST de la misma forma que GET
        doGet(request, response);
    }
}
