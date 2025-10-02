package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Producto;
import modelo.ProductoDAO;

import java.io.IOException;

@WebServlet("/actualizarProducto")
public class ActualizarProductoControlador extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Captura datos del formulario
        int idProducto = Integer.parseInt(request.getParameter("id_producto"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        double precioVenta = Double.parseDouble(request.getParameter("precio_venta"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String imagen = request.getParameter("imagen");
        int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));
        int idProveedor = Integer.parseInt(request.getParameter("id_proveedor"));
        String estado = request.getParameter("estado");

        // Crear objeto producto
        Producto p = new Producto();
        p.setIdProducto(idProducto);
        p.setNombre(nombre);
        p.setDescripcion(descripcion);
        p.setPrecioVenta(precioVenta);
        p.setStock(stock);
        p.setImagen(imagen);
        p.setEstado(estado);

        // Categoria y proveedor
        p.setCategoria(new modelo.Categoria());
        p.getCategoria().setIdCategoria(idCategoria);

        p.setProveedor(new modelo.Proveedor());
        p.getProveedor().setIdProveedor(idProveedor);

        // Actualizar producto usando DAO
        ProductoDAO dao = new ProductoDAO();
        boolean actualizado = dao.actualizarProducto(p);

        if (actualizado) {
            response.sendRedirect("administrar_productos.jsp?msg=Producto actualizado correctamente");
        } else {
            response.sendRedirect("administrar_productos.jsp?error=No se pudo actualizar el producto");
        }
    }
}
