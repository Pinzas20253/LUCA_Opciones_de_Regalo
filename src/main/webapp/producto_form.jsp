<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Producto" %>
<%@ include file="header.jsp" %>

<%
    Producto producto = (Producto) request.getAttribute("producto");
    boolean editando = (producto != null);
%>

<h2><%= editando ? "Editar Producto" : "Nuevo Producto" %></h2>

<form method="post" action="ProductoControlador">
    <input type="hidden" name="action" value="<%= editando ? "actualizar" : "agregar" %>">
    <% if (editando) { %>
        <input type="hidden" name="id" value="<%= producto.getIdProducto() %>">
    <% } %>

    <label>Nombre:</label>
    <input type="text" name="nombre" value="<%= editando ? producto.getNombre() : "" %>" required><br>

    <label>Descripción:</label>
    <input type="text" name="descripcion" value="<%= editando ? producto.getDescripcion() : "" %>"><br>

    <label>Precio Compra:</label>
    <input type="number" step="0.01" name="precioCompra" value="<%= editando ? producto.getPrecioCompra() : "" %>" required><br>

    <label>Precio Venta:</label>
    <input type="number" step="0.01" name="precioVenta" value="<%= editando ? producto.getPrecioVenta() : "" %>" required><br>

    <label>Stock:</label>
    <input type="number" name="stock" value="<%= editando ? producto.getStock() : "" %>" required><br>

    <label>Imagen URL:</label>
    <input type="text" name="imagenUrl" value="<%= editando ? producto.getImagenUrl() : "" %>"><br>

    <label>Estado:</label>
    <select name="estado">
        <option value="Activo" <%= editando && "Activo".equals(producto.getEstado()) ? "selected" : "" %>>Activo</option>
        <option value="Inactivo" <%= editando && "Inactivo".equals(producto.getEstado()) ? "selected" : "" %>>Inactivo</option>
    </select><br>

    <button type="submit"><%= editando ? "Actualizar" : "Agregar" %></button>
</form>

<a href="ProductoControlador?action=listar">← Volver a lista de productos</a>

<%@ include file="footer.jsp" %>
