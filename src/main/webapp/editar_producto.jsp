<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<%
    String idParam = request.getParameter("id");
    if(idParam == null) {
        response.sendRedirect("administrar_productos.jsp");
        return;
    }

    int idProducto = Integer.parseInt(idParam);
    String nombre = "";
    double precio = 0;
    int stock = 0;
    String imagen = "";

    try (Connection conn = conexion.conexionDB.getConnection();
         PreparedStatement ps = conn.prepareStatement("SELECT * FROM productos WHERE id_producto = ?")) {

        ps.setInt(1, idProducto);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            nombre = rs.getString("nombre");
            precio = rs.getDouble("precio_venta");
            stock = rs.getInt("stock");
            imagen = rs.getString("imagen_url");
        } else {
            response.sendRedirect("administrar_productos.jsp");
            return;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<h2 style="text-align:center;">Editar Producto</h2>

<form method="post" action="ActualizarProductoControlador" enctype="multipart/form-data" style="width:400px; margin:auto;">
    <input type="hidden" name="id_producto" value="<%= idProducto %>">

    <label>Nombre:</label>
    <input type="text" name="nombre" value="<%= nombre %>" required class="form-control mb-2">

    <label>Precio Venta:</label>
    <input type="number" step="0.01" name="precio_venta" value="<%= precio %>" required class="form-control mb-2">

    <label>Stock:</label>
    <input type="number" name="stock" value="<%= stock %>" required class="form-control mb-2">

    <label>Imagen (opcional):</label>
    <input type="file" name="imagen" class="form-control mb-2">

    <button type="submit" class="btn btn-success w-100">Actualizar Producto</button>
</form>

<%@ include file="footer.jsp" %>
