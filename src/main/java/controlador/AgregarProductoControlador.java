package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Producto;
import modelo.ProductoDAO;

import java.io.IOException;

@WebServlet("/agregarProducto")
public class AgregarProductoControlador extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Captura datos del formulario
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        double precioVenta = Double.parseDouble(request.getParameter("precio_venta"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String imagen = request.getParameter("imagen");
        int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));
        int idProveedor = Integer.parseInt(request.getParameter("id_proveedor"));

        // Crear objeto producto
        Producto p = new Producto();
        p.setNombre(nombre);
        p.setDescripcion(descripcion);
        p.setPrecioVenta(precioVenta);
        p.setStock(stock);
        p.setImagen(imagen);
        p.setEstado("Activo");

        // Categoria y proveedor
        p.setCategoria(new modelo.Categoria());
        p.getCategoria().setIdCategoria(idCategoria);

        p.setProveedor(new modelo.Proveedor());
        p.getProveedor().setIdProveedor(idProveedor);

        // Guardar producto usando DAO
        ProductoDAO dao = new ProductoDAO();
        boolean agregado = dao.agregarProducto(p);

        if (agregado) {
            response.sendRedirect("administrar_productos.jsp?msg=Producto agregado correctamente");
        } else {
            response.sendRedirect("administrar_productos.jsp?error=No se pudo agregar el producto");
        }
    }
}
