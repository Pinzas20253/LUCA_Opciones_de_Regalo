package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import modelo.Producto;
import modelo.ProductoDAO;

@WebServlet("/ProductoControlador")
public class ProductoControlador extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductoDAO productoDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "listar";

        switch(action) {
            case "nuevo":
                request.getRequestDispatcher("producto_form.jsp").forward(request, response);
                break;
            case "editar":
                editarProducto(request, response);
                break;
            case "eliminar":
                eliminarProducto(request, response);
                break;
            case "detalle":
                verDetalleProducto(request, response);
                break;
            case "listar":
            default:
                listarProductos(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "listar";

        switch(action) {
            case "agregar":
                agregarProducto(request, response);
                break;
            case "actualizar":
                actualizarProducto(request, response);
                break;
            default:
                listarProductos(request, response);
                break;
        }
    }

    private void listarProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Producto> lista = productoDAO.listar();
        request.setAttribute("listaProductos", lista);
        request.getRequestDispatcher("producto.jsp").forward(request, response);
    }

    private void agregarProducto(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Producto p = new Producto();
        p.setNombre(request.getParameter("nombre"));
        p.setDescripcion(request.getParameter("descripcion"));
        p.setPrecioCompra(Double.parseDouble(request.getParameter("precio_compra")));
        p.setPrecioVenta(Double.parseDouble(request.getParameter("precio_venta")));
        p.setStock(Integer.parseInt(request.getParameter("stock")));
        p.setImagenUrl(request.getParameter("imagen_url"));
        p.setIdCategoria(Integer.parseInt(request.getParameter("id_categoria")));
        p.setIdProveedor(Integer.parseInt(request.getParameter("id_proveedor")));
        p.setEstado(request.getParameter("estado"));

        productoDAO.agregar(p);
        response.sendRedirect("ProductoControlador?action=listar");
    }

    private void editarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Producto p = productoDAO.obtenerPorId(id);
        request.setAttribute("producto", p);
        request.getRequestDispatcher("producto_form.jsp").forward(request, response);
    }

    private void actualizarProducto(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Producto p = new Producto();
        p.setIdProducto(Integer.parseInt(request.getParameter("id_producto")));
        p.setNombre(request.getParameter("nombre"));
        p.setDescripcion(request.getParameter("descripcion"));
        p.setPrecioCompra(Double.parseDouble(request.getParameter("precio_compra")));
        p.setPrecioVenta(Double.parseDouble(request.getParameter("precio_venta")));
        p.setStock(Integer.parseInt(request.getParameter("stock")));
        p.setImagenUrl(request.getParameter("imagen_url"));
        p.setIdCategoria(Integer.parseInt(request.getParameter("id_categoria")));
        p.setIdProveedor(Integer.parseInt(request.getParameter("id_proveedor")));
        p.setEstado(request.getParameter("estado"));

        productoDAO.actualizar(p);
        response.sendRedirect("ProductoControlador?action=listar");
    }

    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productoDAO.eliminar(id);
        response.sendRedirect("ProductoControlador?action=listar");
    }

    private void verDetalleProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Producto p = productoDAO.obtenerPorId(id);
        request.setAttribute("producto", p);
        request.getRequestDispatcher("producto_detalle.jsp").forward(request, response);
    }
}
