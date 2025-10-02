package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Producto;
import modelo.ProductoDAO;

import java.io.IOException;
import java.util.List;

@WebServlet("/productos")
public class ProductoControlador extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductoDAO dao = new ProductoDAO();
        List<Producto> listaProductos = dao.listarProductos();

        request.setAttribute("listaProductos", listaProductos);

        // Redirige a la página de catálogo o productos cliente
        request.getRequestDispatcher("productos_cliente.jsp").forward(request, response);
    }
}
