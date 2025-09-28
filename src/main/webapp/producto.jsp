<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, modelo.Producto" %>
<%@ include file="header.jsp" %>

<h2>Lista de Productos</h2>

<a href="ProductoControlador?action=nuevo" class="btn">➕ Nuevo Producto</a>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Precio Venta</th>
        <th>Stock</th>
        <th>Estado</th>
        <th>Acciones</th>
    </tr>
    <%
        List<Producto> lista = (List<Producto>) request.getAttribute("listaProductos");
        if (lista != null) {
            for (Producto p : lista) {
    %>
    <tr>
        <td><%= p.getIdProducto() %></td>
        <td><%= p.getNombre() %></td>
        <td>$<%= p.getPrecioVenta() %></td>
        <td><%= p.getStock() %></td>
        <td><%= p.getEstado() %></td>
        <td>
            <a href="ProductoControlador?action=editar&id=<%= p.getIdProducto() %>">Editar</a> |
            <a href="ProductoControlador?action=eliminar&id=<%= p.getIdProducto() %>"
               onclick="return confirm('¿Seguro de eliminar este producto?');">Eliminar</a>
        </td>
    </tr>
    <%
            }
        } else {
    %>
    <tr>
        <td colspan="6">No hay productos disponibles</td>
    </tr>
    <%
        }
    %>
</table>

<%@ include file="footer.jsp" %>
