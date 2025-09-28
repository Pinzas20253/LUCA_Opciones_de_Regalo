<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<!-- Directiva JSP: indica que el contenido generado es HTML en codificación UTF-8 -->

<%@ page import="modelo.Producto" %> 
<!-- Importa la clase Producto desde el paquete modelo -->

<%@ include file="header.jsp" %> 
<!-- Incluye el encabezado común de la aplicación (header.jsp) -->

<%
    // Recupera el atributo "producto" enviado desde el controlador
    Producto producto = (Producto) request.getAttribute("producto");

    // Determina si se está editando (producto no es nulo) o creando uno nuevo
    boolean editando = (producto != null);
%>

<!-- Título de la página: cambia según si se edita o se crea -->
<h2><%= editando ? "Editar Producto" : "Nuevo Producto" %></h2>

<!-- Formulario para crear o actualizar un producto -->
<form method="post" action="ProductoControlador">
    <!-- Campo oculto para definir la acción a realizar: actualizar o agregar -->
    <input type="hidden" name="action" value="<%= editando ? "actualizar" : "agregar" %>">

    <% if (editando) { %>
        <!-- Si se está editando, se envía también el ID del producto -->
        <input type="hidden" name="id" value="<%= producto.getIdProducto() %>">
    <% } %>

    <!-- Campo: Nombre del producto -->
    <label>Nombre:</label>
    <input type="text" name="nombre" value="<%= editando ? producto.getNombre() : "" %>" required><br>

    <!-- Campo: Descripción del producto -->
    <label>Descripción:</label>
    <input type="text" name="descripcion" value="<%= editando ? producto.getDescripcion() : "" %>"><br>

    <!-- Campo: Precio de compra -->
    <label>Precio Compra:</label>
    <input type="number" step="0.01" name="precioCompra" value="<%= editando ? producto.getPrecioCompra() : "" %>" required><br>

    <!-- Campo: Precio de venta -->
    <label>Precio Venta:</label>
    <input type="number" step="0.01" name="precioVenta" value="<%= editando ? producto.getPrecioVenta() : "" %>" required><br>

    <!-- Campo: Stock disponible -->
    <label>Stock:</label>
    <input type="number" name="stock" value="<%= editando ? producto.getStock() : "" %>" required><br>

    <!-- Campo: URL de la imagen del producto -->
    <label>Imagen URL:</label>
    <input type="text" name="imagenUrl" value="<%= editando ? producto.getImagenUrl() : "" %>"><br>

    <!-- Campo: Estado del producto (Activo / Inactivo) -->
    <label>Estado:</label>
    <select name="estado">
        <!-- Marca como "selected" según el estado actual del producto -->
        <option value="Activo" <%= editando && "Activo".equals(producto.getEstado()) ? "selected" : "" %>>Activo</option>
        <option value="Inactivo" <%= editando && "Inactivo".equals(producto.getEstado()) ? "selected" : "" %>>Inactivo</option>
    </select><br>

    <!-- Botón que cambia el texto según si se edita o agrega -->
    <button type="submit"><%= editando ? "Actualizar" : "Agregar" %></button>
</form>

<!-- Enlace para volver a la lista de productos -->
<a href="ProductoControlador?action=listar">← Volver a lista de productos</a>

<%@ include file="footer.jsp" %> 
<!-- Incluye el pie de página común (footer.jsp) -->
