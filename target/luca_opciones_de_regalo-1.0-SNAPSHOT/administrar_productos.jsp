<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, modelo.Producto" %>
<%@ include file="header.jsp" %>

<div class="main">
    <h2 style="text-align:center;">Administrar Productos</h2>

    <!-- Botón para agregar producto -->
    <div style="text-align:center; margin: 20px;">
        <a href="ProductoControlador?action=form"
           style="padding:10px 15px; background-color:#28a745; color:white; text-decoration:none; border-radius:5px;">
           ➕ Agregar Producto
        </a>
    </div>

    <%
        // Obtener lista de productos desde el controlador
        List<Producto> listaProductos = (List<Producto>) request.getAttribute("listaProductos");
    %>

    <% if (listaProductos != null && !listaProductos.isEmpty()) { %>
        <!-- Tabla con la lista de productos -->
        <table style="width: 80%; border-collapse: collapse; margin: 0 auto;">
            <thead>
                <tr>
                    <th style="border:1px solid #ccc; padding:8px;">ID</th>
                    <th style="border:1px solid #ccc; padding:8px;">Nombre</th>
                    <th style="border:1px solid #ccc; padding:8px;">Descripción</th>
                    <th style="border:1px solid #ccc; padding:8px;">Precio</th>
                    <th style="border:1px solid #ccc; padding:8px;">Stock</th>
                    <th style="border:1px solid #ccc; padding:8px;">Imagen</th>
                    <th style="border:1px solid #ccc; padding:8px;">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% for (Producto p : listaProductos) { %>
                    <tr>
                        <!-- Mostrar datos del producto -->
                        <td style="border:1px solid #ccc; padding:8px;"><%= p.getIdProducto() %></td>
                        <td style="border:1px solid #ccc; padding:8px;"><%= p.getNombre() %></td>
                        <td style="border:1px solid #ccc; padding:8px;"><%= p.getDescripcion() %></td>
                        <td style="border:1px solid #ccc; padding:8px;">$<%= p.getPrecio() %></td>
                        <td style="border:1px solid #ccc; padding:8px;"><%= p.getStock() %></td>
                        <td style="border:1px solid #ccc; padding:8px;">
                            <% if (p.getImagenUrl() != null) { %>
                                <!-- Mostrar imagen si existe -->
                                <img src="imagenes/<%= p.getImagenUrl() %>" alt="Imagen" style="width:60px; height:auto;">
                            <% } else { %>
                                <!-- Texto si no hay imagen -->
                                Sin imagen
                            <% } %>
                        </td>
                        <td style="border:1px solid #ccc; padding:8px;">
                            <!-- Acciones editar y eliminar -->
                            <a href="ProductoControlador?action=editar&id=<%= p.getIdProducto() %>"
                               style="color:blue; margin-right:10px;">✏️ Editar</a>
                            <a href="ProductoControlador?action=eliminar&id=<%= p.getIdProducto() %>"
                               style="color:red;"
                               onclick="return confirm('¿Seguro que deseas eliminar este producto?');">
                               🗑️ Eliminar
                            </a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <!-- Mensaje si no hay productos -->
        <p style="text-align:center;">⚠️ No hay productos registrados.</p>
    <% } %>
</div>

<%@ include file="footer.jsp" %>
