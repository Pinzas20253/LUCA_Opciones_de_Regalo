<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<!-- Directiva JSP que define el tipo de contenido de la página y el lenguaje de script usado (Java) -->

<%@ page import="java.util.*, modelo.Producto" %> 
<!-- Importa las clases necesarias: utilidades de Java y la clase Producto de tu modelo -->

<%@ include file="header.jsp" %> 
<!-- Incluye el archivo header.jsp (barra de navegación y encabezado) -->

<h2>Lista de Productos</h2>
<!-- Título de la página -->

<a href="ProductoControlador?action=nuevo" class="btn">➕ Nuevo Producto</a>
<!-- Enlace para ir al controlador y crear un nuevo producto -->

<table border="1" cellpadding="5" cellspacing="0">
    <!-- Inicio de tabla para mostrar productos -->
    <tr>
        <!-- Encabezados de la tabla -->
        <th>ID</th>
        <th>Nombre</th>
        <th>Precio Venta</th>
        <th>Stock</th>
        <th>Estado</th>
        <th>Acciones</th>
    </tr>
    <%
        // Obtiene la lista de productos desde el atributo "listaProductos" del request
        List<Producto> lista = (List<Producto>) request.getAttribute("listaProductos");
        if (lista != null) { // Si la lista no es nula
            for (Producto p : lista) { // Recorre cada producto de la lista
    %>
    <tr>
        <!-- Muestra los datos del producto en cada columna -->
        <td><%= p.getIdProducto() %></td>
        <td><%= p.getNombre() %></td>
        <td>$<%= p.getPrecioVenta() %></td>
        <td><%= p.getStock() %></td>
        <td><%= p.getEstado() %></td>
        <td>
            <!-- Enlaces para editar o eliminar el producto -->
            <a href="ProductoControlador?action=editar&id=<%= p.getIdProducto() %>">Editar</a> |
            <a href="ProductoControlador?action=eliminar&id=<%= p.getIdProducto() %>"
               onclick="return confirm('¿Seguro de eliminar este producto?');">Eliminar</a>
        </td>
    </tr>
    <%
            }
        } else { // Si no hay lista o está vacía
    %>
    <tr>
        <!-- Mensaje de que no hay productos -->
        <td colspan="6">No hay productos disponibles</td>
    </tr>
    <%
        }
    %>
</table>
<!-- Fin de la tabla de productos -->

<%@ include file="footer.jsp" %> 
<!-- Incluye el footer.jsp al final de la página -->
