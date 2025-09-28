package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import modelo.Carrito;

@WebServlet("/EliminarCarritoControlador")
public class EliminarCarritoControlador extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // evita crear sesión si no existe

        if (session != null) {
            List<Carrito> carrito = (List<Carrito>) session.getAttribute("carrito");

            if (carrito != null && request.getParameter("id") != null) {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));

                    // Usar removeIf (más seguro que un bucle con remove)
                    boolean eliminado = carrito.removeIf(c -> c.getIdProducto() == id);

                    if (eliminado) {
                        session.setAttribute("carrito", carrito);
                    }
                } catch (NumberFormatException e) {
                    // Si llega un id no válido, lo ignoramos
                    System.err.println("⚠️ ID de producto inválido en EliminarCarritoControlador");
                }
            }
        }

        // Siempre redirigir al carrito
        response.sendRedirect("carrito.jsp");
    }
}
