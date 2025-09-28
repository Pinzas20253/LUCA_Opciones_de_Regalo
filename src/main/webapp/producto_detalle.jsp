<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<!-- Directiva que indica que la página JSP devuelve contenido HTML en UTF-8 -->

<%@ page import="java.sql.*, conexion.conexionDB" %> 
<!-- Importa las clases necesarias para trabajar con JDBC (java.sql) 
     y la clase personalizada conexionDB para conectarse a la base de datos -->

<%@ include file="header.jsp" %> 
<!-- Incluye el archivo header.jsp (encabezado común para todas las páginas) -->

<%
    // Captura el parámetro "id" enviado en la URL (?id=...)
    String idParam = request.getParameter("id");
    if (idParam == null) {
        // Si no se recibe un ID, se muestra un mensaje y se detiene la ejecución
        out.println("<p>Producto no especificado.</p>");
        return;
    }

    // Convierte el parámetro recibido a número entero
    int idProducto = Integer.parseInt(idParam);

    // Intenta conectarse a la base de datos
    try (Connection conn = conexionDB.getConnection()) {

        // Consulta SQL para obtener los datos del producto junto con su categoría y proveedor
        String sql = "SELECT p.id_producto, p.nombre, p.descripcion, p.precio_venta, p.stock, " +
                     "p.imagen_url, c.nombre_categoria, pr.empresa AS proveedor " +
                     "FROM productos p " +
                     "JOIN categorias c ON p.id_categoria = c.id_categoria " +
                     "JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor " +
                     "WHERE p.id_producto = ?";

        // Prepara la consulta para evitar inyección SQL
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idProducto); // Asigna el ID recibido al parámetro de la consulta

            // Ejecuta la consulta
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Si se encontró el producto, obtiene sus datos
                    String nombre = rs.getString("nombre");
                    String descripcion = rs.getString("descripcion");
                    double precio = rs.getDouble("precio_venta");
                    int stock = rs.getInt("stock");
                    String imagen = rs.getString("imagen_url");
                    String categoria = rs.getString("nombre_categoria");
                    String proveedor = rs.getString("proveedor");
%>

<!-- Contenedor principal del detalle de producto -->
<div style="display:flex; gap:30px; margin:20px;">

    <!-- Sección: Imagen del producto -->
    <div>
        <% if (imagen != null && !imagen.trim().isEmpty()) { %>
            <!-- Si el producto tiene imagen, se muestra -->
            <img src="<%= request.getContextPath() %>/imagenes/<%= imagen %>" 
                 alt="<%= nombre %>" 
                 style="max-width:400px; max-height:400px;">
        <% } else { %>
            <!-- Si no tiene imagen, se muestra un cuadro gris -->
            <div style="width:400px;height:400px;border:1px solid #ccc; 
                        display:flex; align-items:center; justify-content:center;">
                Sin imagen
            </div>
        <% } %>
    </div>

    <!-- Sección: Información del producto -->
    <div>
        <h2><%= nombre %></h2>
        <p><strong>Descripción:</strong> <%= descripcion %></p>
        <p><strong>Precio:</strong> $<%= precio %></p>
        <p><strong>Stock disponible:</strong> <%= stock %></p>
        <p><strong>Categoría:</strong> <%= categoria %></p>
        <p><strong>Proveedor:</strong> <%= proveedor %></p>

        <!-- Formulario para añadir producto al carrito -->
        <form method="post" action="<%= request.getContextPath() %>/CarritoControlador" style="margin-top:10px;">
            <!-- Se envían datos ocultos del producto al controlador -->
            <input type="hidden" name="id" value="<%= idProducto %>">
            <input type="hidden" name="nombre" value="<%= nombre %>">
            <input type="hidden" name="precio" value="<%= precio %>">
            <button type="submit" class="add-cart-btn">Añadir al carrito</button>
        </form>

        <!-- Botón para compartir producto -->
        <button class="share-btn" style="margin-top:10px;" 
                onclick="compartirProducto('<%= idProducto %>', '<%= nombre %>')">
            Compartir
        </button>
    </div>
</div>

<%
                } else {
                    // Si no se encuentra el producto con el ID dado
                    out.println("<p>Producto no encontrado.</p>");
                }
            }
        }
    } catch (SQLException e) {
        // Manejo de errores en caso de problemas con la base de datos
        e.printStackTrace();
        out.println("<p style='color:red;'>Error al cargar el producto: " + e.getMessage() + "</p>");
    }
%>

<%@ include file="footer.jsp" %> 
<!-- Incluye el pie de página común (footer.jsp) -->

<script>
/**
 * Función para compartir el producto
 * Utiliza la API de compartir nativa (navigator.share) si está disponible
 * Si no, copia el enlace al portapapeles
 */
function compartirProducto(id, nombre) {
    // Construye la URL del detalle del producto
    const urlProducto = window.location.origin + "<%= request.getContextPath() %>/producto_detalle.jsp?id=" + encodeURIComponent(id);

    // Si el navegador soporta compartir nativamente
    if (navigator.share) {
        navigator.share({
            title: "LUCA Opciones de Regalo",
            text: "Mira este producto: " + nombre,
            url: urlProducto
        }).catch(err => console.log("Error al compartir:", err));
    } else {
        // Si no soporta, copia el enlace al portapapeles
        navigator.clipboard.writeText(urlProducto).then(() => {
            alert("Enlace copiado al portapapeles:\n" + urlProducto);
        }).catch(err => {
            alert("Copia manualmente este enlace:\n" + urlProducto);
        });
    }
}
</script>
