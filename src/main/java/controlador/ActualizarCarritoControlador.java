package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import modelo.Carrito;

@WebServlet("/ActualizarCarritoControlador")
public class ActualizarCarritoControlador extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Carrito> carrito = (List<Carrito>) session.getAttribute("carrito");

        if (carrito != null) {
            try {
                String idParam = request.getParameter("id");
                String cantidadParam = request.getParameter("cantidad");

                if (idParam != null && cantidadParam != null) {
                    int id = Integer.parseInt(idParam);
                    int cantidad = Integer.parseInt(cantidadParam);

                    boolean encontrado = false;

                    for (Iterator<Carrito> it = carrito.iterator(); it.hasNext();) {
                        Carrito c = it.next();
                        if (c.getIdProducto() == id) {
                            if (cantidad > 0) {
                                c.setCantidad(cantidad); // actualizar cantidad
                            } else {
                                it.remove(); // si la cantidad es 0 o menor, se elimina
                            }
                            encontrado = true;
                            break;
                        }
                    }

                    // Si no encontró el producto, no pasa nada
                    if (!encontrado) {
                        System.out.println("⚠ Producto con ID " + id + " no encontrado en carrito.");
                    }

                    session.setAttribute("carrito", carrito);
                }
            } catch (NumberFormatException e) {
                System.err.println("Error en parámetros de actualización del carrito: " + e.getMessage());
            }
        }

        // Redirigir siempre a carrito.jsp
        response.sendRedirect("carrito.jsp");
    }
}
