<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String idParam = request.getParameter("id");
    if(idParam == null) {
        response.sendRedirect("administrar_productos.jsp");
        return;
    }

    int idProducto = Integer.parseInt(idParam);

    try (Connection conn = conexion.conexionDB.getConnection();
         PreparedStatement ps = conn.prepareStatement("DELETE FROM productos WHERE id_producto = ?")) {

        ps.setInt(1, idProducto);
        ps.executeUpdate();

    } catch (SQLException e) {
        e.printStackTrace();
    }

    response.sendRedirect("administrar_productos.jsp");
%>
