<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, modelo.Producto, modelo.Categoria, modelo.Proveedor, modelo.ProductoDAO" %>

<%@ include file="header.jsp" %>

<%
    ProductoDAO dao = new ProductoDAO();
    List<Producto> productos = dao.listarProductos();

    String mensaje = request.getParameter("mensaje");
    String error = request.getParameter("error");
%>

<div class="container">
    <h1>Administrar Productos</h1>

    <% if (mensaje != null) { %>
        <div style="color:green;"><%= mensaje %></div>
    <% } %>
    <% if (error != null) { %>
        <div style="color:red;"><%= error %></div>
    <% } %>

    <a href="producto_form.jsp" style="margin-bottom:15px; display:inline-block;">Agregar Nuevo Producto</a>

    <table border="1" cellpadding="10" cellspacing="0">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>Categoría</th>
            <th>Proveedor</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
        <% for (Producto p : productos) { %>
            <tr>
                <td><%= p.getIdProducto() %></td>
                <td><%= p.getNombre() %></td>
                <td>$<%= p.getPrecioVenta() %></td>
                <td><%= p.getStock() %></td>
                <td><%= p.getCategoria().getNombreCategoria() %></td>
                <td><%= p.getProveedor().getEmpresa() %></td>
                <td><%= p.getEstado() %></td>
                <td>
                    <a href="producto_form.jsp?id=<%= p.getIdProducto() %>">Editar</a>
                    &nbsp;|&nbsp;
                    <a href="ProductoControlador?accion=detalle&id=<%= p.getIdProducto() %>" target="_blank">Ver</a>
                </td>
            </tr>
        <% } %>
    </table>
</div>

<%@ include file="footer.jsp" %>
