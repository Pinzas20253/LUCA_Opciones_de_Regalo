<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, modelo.Categoria, modelo.Proveedor, modelo.Producto, modelo.ProductoDAO" %>
<%@ include file="header.jsp" %>

<%
    ProductoDAO dao = new ProductoDAO();
    List<Categoria> categorias = dao.listarCategorias();
    List<Proveedor> proveedores = dao.listarProveedores();

    String idParam = request.getParameter("id");
    Producto producto = null;
    boolean esEdicion = false;

    if (idParam != null && !idParam.trim().isEmpty()) {
        int idProducto = Integer.parseInt(idParam);
        producto = dao.obtenerProductoPorId(idProducto);
        esEdicion = true;
    }
%>

<div class="container">
    <h1><%= esEdicion ? "Editar Producto" : "Agregar Nuevo Producto" %></h1>

    <form method="post" action="<%= request.getContextPath() %>/<%= esEdicion ? "ActualizarProductoControlador" : "AgregarProductoControlador" %>" enctype="multipart/form-data">
        <% if (esEdicion) { %>
            <input type="hidden" name="id" value="<%= producto.getIdProducto() %>">
        <% } %>

        <label>Nombre:</label><br>
        <input type="text" name="nombre" value="<%= esEdicion ? producto.getNombre() : "" %>" required><br><br>

        <label>Descripción:</label><br>
        <textarea name="descripcion" rows="4" cols="50"><%= esEdicion ? producto.getDescripcion() : "" %></textarea><br><br>

        <label>Precio de venta:</label><br>
        <input type="number" step="0.01" name="precioVenta" value="<%= esEdicion ? producto.getPrecioVenta() : "" %>" required><br><br>

        <label>Stock:</label><br>
        <input type="number" name="stock" value="<%= esEdicion ? producto.getStock() : "0" %>" required><br><br>

        <label>Categoría:</label><br>
        <select name="idCategoria" required>
            <option value="">-- Seleccionar --</option>
            <% for (Categoria c : categorias) { %>
                <option value="<%= c.getIdCategoria() %>" <%= esEdicion && producto.getCategoria().getIdCategoria() == c.getIdCategoria() ? "selected" : "" %>>
                    <%= c.getNombreCategoria() %>
                </option>
            <% } %>
        </select><br><br>

        <label>Proveedor:</label><br>
        <select name="idProveedor" required>
            <option value="">-- Seleccionar --</option>
            <% for (Proveedor p : proveedores) { %>
                <option value="<%= p.getIdProveedor() %>" <%= esEdicion && producto.getProveedor().getIdProveedor() == p.getIdProveedor() ? "selected" : "" %>>
                    <%= p.getEmpresa() %>
                </option>
            <% } %>
        </select><br><br>

        <label>Imagen (URL o archivo):</label><br>
        <input type="text" name="imagen" value="<%= esEdicion ? producto.getImagen() : "" %>"><br><br>

        <label>Estado:</label><br>
        <select name="estado" required>
            <option value="Activo" <%= esEdicion && "Activo".equals(producto.getEstado()) ? "selected" : "" %>>Activo</option>
            <option value="Inactivo" <%= esEdicion && "Inactivo".equals(producto.getEstado()) ? "selected" : "" %>>Inactivo</option>
        </select><br><br>

        <button type="submit"><%= esEdicion ? "Actualizar Producto" : "Agregar Producto" %></button>
    </form>
</div>

<%@ include file="footer.jsp" %>
