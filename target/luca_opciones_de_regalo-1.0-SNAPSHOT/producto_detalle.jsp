<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Producto, modelo.ProductoDAO" %>
<%@ include file="header.jsp" %>

<%
    int idProducto = Integer.parseInt(request.getParameter("id"));
    ProductoDAO dao = new ProductoDAO();
    Producto producto = dao.obtenerProductoPorId(idProducto);
%>

<div style="display:flex; gap:30px; margin:20px;">
    <div>
        <% if (producto.getImagen() != null && !producto.getImagen().trim().isEmpty()) { %>
            <img src="<%= request.getContextPath() %>/imagenes/<%= producto.getImagen() %>" 
                 alt="<%= producto.getNombre() %>" 
                 style="max-width:400px; max-height:400px;">
        <% } else { %>
            <div style="width:400px;height:400px;border:1px solid #ccc; display:flex; align-items:center; justify-content:center;">
                Sin imagen
            </div>
        <% } %>
    </div>

    <div>
        <h2><%= producto.getNombre() %></h2>
        <p><strong>Descripción:</strong> <%= producto.getDescripcion() %></p>
        <p><strong>Precio:</strong> $<%= producto.getPrecioVenta() %></p>
        <p><strong>Stock:</strong> <%= producto.getStock() %></p>
        <p><strong>Categoría:</strong> <%= producto.getCategoria().getNombreCategoria() %></p>
        <p><strong>Proveedor:</strong> <%= producto.getProveedor().getEmpresa() %></p>

        <form method="post" action="<%= request.getContextPath() %>/CarritoControlador" style="margin-top:10px;">
            <input type="hidden" name="id" value="<%= producto.getIdProducto() %>">
            <input type="hidden" name="nombre" value="<%= producto.getNombre() %>">
            <input type="hidden" name="precio" value="<%= producto.getPrecioVenta() %>">
            <button type="submit">Añadir al carrito</button>
        </form>

        <button style="margin-top:10px;" onclick="compartirProducto(<%= producto.getIdProducto() %>, '<%= producto.getNombre() %>')">
            Compartir
        </button>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
function compartirProducto(id, nombre) {
    const url = window.location.origin + "<%= request.getContextPath() %>/ProductoControlador?accion=detalle&id=" + encodeURIComponent(id);
    if (navigator.share) {
        navigator.share({title: "LUCA Opciones de Regalo", text: "Mira este producto: " + nombre, url: url}).catch(console.log);
    } else {
        navigator.clipboard.writeText(url).then(() => alert("Enlace copiado: " + url));
    }
}
</script>
