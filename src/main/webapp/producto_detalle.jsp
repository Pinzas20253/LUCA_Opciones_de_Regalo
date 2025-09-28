<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, conexion.conexionDB" %>
<%@ include file="header.jsp" %>

<%
    String idParam = request.getParameter("id");
    if (idParam == null) {
        out.println("<p>Producto no especificado.</p>");
        return;
    }

    int idProducto = Integer.parseInt(idParam);
    try (Connection conn = conexionDB.getConnection()) {
        String sql = "SELECT p.id_producto, p.nombre, p.descripcion, p.precio_venta, p.stock, " +
                     "p.imagen_url, c.nombre_categoria, pr.empresa AS proveedor " +
                     "FROM productos p " +
                     "JOIN categorias c ON p.id_categoria = c.id_categoria " +
                     "JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor " +
                     "WHERE p.id_producto = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idProducto);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String nombre = rs.getString("nombre");
                    String descripcion = rs.getString("descripcion");
                    double precio = rs.getDouble("precio_venta");
                    int stock = rs.getInt("stock");
                    String imagen = rs.getString("imagen_url");
                    String categoria = rs.getString("nombre_categoria");
                    String proveedor = rs.getString("proveedor");
%>

<div style="display:flex; gap:30px; margin:20px;">
    <!-- Imagen del producto -->
    <div>
        <% if (imagen != null && !imagen.trim().isEmpty()) { %>
            <img src="<%= request.getContextPath() %>/imagenes/<%= imagen %>" alt="<%= nombre %>" style="max-width:400px; max-height:400px;">
        <% } else { %>
            <div style="width:400px;height:400px;border:1px solid #ccc; display:flex; align-items:center; justify-content:center;">Sin imagen</div>
        <% } %>
    </div>

    <!-- Información del producto -->
    <div>
        <h2><%= nombre %></h2>
        <p><strong>Descripción:</strong> <%= descripcion %></p>
        <p><strong>Precio:</strong> $<%= precio %></p>
        <p><strong>Stock disponible:</strong> <%= stock %></p>
        <p><strong>Categoría:</strong> <%= categoria %></p>
        <p><strong>Proveedor:</strong> <%= proveedor %></p>

        <!-- Botón Añadir al carrito -->
        <form method="post" action="<%= request.getContextPath() %>/CarritoControlador" style="margin-top:10px;">
            <input type="hidden" name="id" value="<%= idProducto %>">
            <input type="hidden" name="nombre" value="<%= nombre %>">
            <input type="hidden" name="precio" value="<%= precio %>">
            <button type="submit" class="add-cart-btn">Añadir al carrito</button>
        </form>

        <!-- Botón Compartir -->
        <button class="share-btn" style="margin-top:10px;" onclick="compartirProducto('<%= idProducto %>', '<%= nombre %>')">Compartir</button>
    </div>
</div>

<%
                } else {
                    out.println("<p>Producto no encontrado.</p>");
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error al cargar el producto: " + e.getMessage() + "</p>");
    }
%>

<%@ include file="footer.jsp" %>

<script>
function compartirProducto(id, nombre) {
    const urlProducto = window.location.origin + "<%= request.getContextPath() %>/producto_detalle.jsp?id=" + encodeURIComponent(id);
    if (navigator.share) {
        navigator.share({
            title: "LUCA Opciones de Regalo",
            text: "Mira este producto: " + nombre,
            url: urlProducto
        }).catch(err => console.log("Error al compartir:", err));
    } else {
        navigator.clipboard.writeText(urlProducto).then(() => {
            alert("Enlace copiado al portapapeles:\n" + urlProducto);
        }).catch(err => {
            alert("Copia manualmente este enlace:\n" + urlProducto);
        });
    }
}
</script>
