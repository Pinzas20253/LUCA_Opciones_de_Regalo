package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import conexion.conexionDB;

@WebServlet("/EliminarProductoControlador")
public class EliminarProductoControlador extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtiene el id del producto a eliminar
        String idStr = request.getParameter("id_producto");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("administrar_productos.jsp");
            return;
        }

        int idProducto = Integer.parseInt(idStr);

        // Conexión y eliminación del producto
        String sql = "DELETE FROM productos WHERE id_producto = ?";

        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idProducto);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            // Si quieres, puedes guardar un mensaje de error en session y mostrarlo en JSP
            HttpSession session = request.getSession();
            session.setAttribute("errorProducto", "Error al eliminar el producto: " + e.getMessage());
        }

        // Redirige de nuevo a administrar productos
        response.sendRedirect("administrar_productos.jsp");
    }
}
