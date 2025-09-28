package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import modelo.Carrito;

@WebServlet("/CarritoControlador")
public class CarritoControlador extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Obtener el carrito actual o crear uno nuevo
        List<Carrito> carrito = (List<Carrito>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        try {
            // Validar que los parámetros existan
            String idParam = request.getParameter("id");
            String nombre = request.getParameter("nombre");
            String precioParam = request.getParameter("precio");

            if (idParam != null && precioParam != null && nombre != null && !nombre.isBlank()) {
                int id = Integer.parseInt(idParam);
                double precio = Double.parseDouble(precioParam);

                // Verificar si el producto ya existe en el carrito
                boolean encontrado = false;
                for (Carrito c : carrito) {
                    if (c.getIdProducto() == id) {
                        c.setCantidad(c.getCantidad() + 1); // aumentar cantidad
                        encontrado = true;
                        break;
                    }
                }

                // Si no existe, agregarlo como nuevo
                if (!encontrado) {
                    carrito.add(new Carrito(id, nombre, precio, 1));
                }

                // Guardar carrito actualizado en sesión
                session.setAttribute("carrito", carrito);
            } else {
                System.err.println("⚠ Parámetros inválidos al intentar agregar al carrito.");
            }

        } catch (NumberFormatException e) {
            System.err.println("⚠ Error de formato en parámetros del carrito: " + e.getMessage());
        }

        // Volver a la página de origen (o a index.jsp como fallback)
        String referer = request.getHeader("referer");
        response.sendRedirect(referer != null ? referer : "index.jsp");
    }
}
