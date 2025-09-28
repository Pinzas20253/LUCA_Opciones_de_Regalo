<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%-- Configura la página JSP para que use UTF-8 y Java --%>
<%@ page import="java.sql.*, conexion.conexionDB" %> <%-- Importa librerías para conectarse a la base de datos y la clase conexionDB --%>
<%@ include file="header.jsp" %> <%-- Inserta el archivo header.jsp (barra de navegación, logo, etc.) --%>

<style>
/* ======== Estilos CSS para mostrar productos ======== */
.products .product {
    border: 1px solid #ddd; /* Borde alrededor del producto */
    padding: 10px; /* Espaciado interno */
    margin: 10px; /* Espaciado externo */
    display: inline-block; /* Se muestran en línea uno al lado del otro */
    vertical-align: top; /* Alineación superior */
    width: 200px; /* Ancho fijo */
    text-align: center; /* Centra el contenido */
    background: #fff; /* Fondo blanco */
    border-radius: 8px; /* Bordes redondeados */
}
.products .product img {
    width: 100%; /* Imagen ocupa todo el ancho */
    height: 150px; /* Altura fija */
    object-fit: contain; /* Ajusta la imagen sin deformarla */
}
.products .product h3 {
    font-size: 16px; /* Tamaño de texto */
    margin: 5px 0; /* Márgenes superior e inferior */
}
.products .product p {
    font-weight: bold; /* Texto en negrita */
}
/* Botones de acción: añadir, compartir, ver detalle */
.add-cart-btn, .share-btn, .detail-btn {
    display: block; /* Cada botón en una línea */
    margin: 5px auto; /* Centrado con márgenes */
    padding: 6px 10px; /* Espaciado interno */
    border: none; /* Sin borde */
    cursor: pointer; /* Manito al pasar el mouse */
    border-radius: 4px; /* Bordes redondeados */
    text-decoration: none; /* Sin subrayado */
    color: #fff; /* Texto blanco */
    font-weight: bold; /* Negrita */
}
.add-cart-btn { background: #007bff; } /* Azul */
.share-btn { background: #28a745; } /* Verde */
.detail-btn { background: #6c757d; } /* Gris */
</style>

<%
    // Consulta SQL para obtener las categorías activas
    String sqlCat = "SELECT id_categoria, nombre_categoria FROM categorias WHERE estado='Activa'";
    try (Connection conn = conexionDB.getConnection(); // Conexión a la base de datos
         PreparedStatement psCat = conn.prepareStatement(sqlCat); // Preparar consulta de categorías
         ResultSet rsCat = psCat.executeQuery()) { // Ejecutar consulta y obtener resultados

        // Recorrer todas las categorías activas
        while (rsCat.next()) {
            int idCategoria = rsCat.getInt("id_categoria"); // ID de la categoría
            String nombreCategoria = rsCat.getString("nombre_categoria"); // Nombre de la categoría
%>
<div class="category">
    <h2><%= nombreCategoria %></h2> <!-- Nombre de la categoría -->
    <div class="products">
    <%
        // Consulta SQL para obtener los productos de la categoría (máximo 6)
        String sqlProd = "SELECT id_producto, nombre, precio_venta, imagen_url FROM productos WHERE id_categoria=? AND estado='Activo' LIMIT 6";
        try (PreparedStatement psProd = conn.prepareStatement(sqlProd)) {
            psProd.setInt(1, idCategoria); // Asignar ID de categoría
            try (ResultSet rsProd = psProd.executeQuery()) {
                // Recorrer los productos de esta categoría
                while (rsProd.next()) {
                    int idProd = rsProd.getInt("id_producto"); // ID del producto
                    String nombre = rsProd.getString("nombre"); // Nombre del producto
                    String imagen = rsProd.getString("imagen_url"); // Imagen del producto
                    double precio = rsProd.getDouble("precio_venta"); // Precio del producto
    %>
        <!-- Mostrar cada producto -->
        <div class="product">
            <!-- Imagen del producto (si no tiene, muestra una por defecto) -->
            <img src="<%= request.getContextPath() %>/imagenes/<%= imagen != null ? imagen : "no_imagen.png" %>" alt="<%= nombre %>">
            
            <!-- Nombre del producto -->
            <h3><%= nombre %></h3>
            
            <!-- Precio del producto -->
            <p>$<%= precio %></p>

            <!-- Formulario para añadir el producto al carrito -->
            <form method="post" action="<%= request.getContextPath() %>/CarritoControlador">
                <input type="hidden" name="id" value="<%= idProd %>"> <!-- ID oculto -->
                <input type="hidden" name="nombre" value="<%= nombre %>"> <!-- Nombre oculto -->
                <input type="hidden" name="precio" value="<%= precio %>"> <!-- Precio oculto -->
                <button type="submit" class="add-cart-btn">Añadir al carrito</button>
            </form>

            <!-- Botón para compartir el producto -->
            <button class="share-btn" onclick="compartirProducto('<%= idProd %>', '<%= nombre %>')">Compartir</button>

            <!-- Enlace para ver detalle del producto -->
            <a href="producto_detalle.jsp?id=<%= idProd %>" class="detail-btn">Ver detalle</a>
        </div>
    <%
                } // Fin while productos
            } // Fin ResultSet productos
        } // Fin PreparedStatement productos
    %>
    </div>
    <!-- Enlace para ver más productos de la categoría -->
    <a href="catalogo.jsp?categoria=<%= idCategoria %>">Ver más</a>
</div>
<%
        } // Fin while categorías
    } catch (SQLException e) {
        // Manejo de error en caso de problema con la base de datos
        e.printStackTrace();
        out.println("<p style='color:red;text-align:center;'>Error al cargar categorías/productos: " + e.getMessage() + "</p>");
    }
%>

<script>
// Función de JavaScript para compartir el producto
function compartirProducto(id, nombre) {
    // Construir la URL del detalle del producto
    const url = window.location.origin + "<%= request.getContextPath() %>/producto_detalle.jsp?id=" + encodeURIComponent(id);
    
    // Si el navegador soporta la función de compartir
    if (navigator.share) {
        navigator.share({
            title: "LUCA Opciones de Regalo", // Título de la app
            text: "Mira este producto: " + nombre, // Texto que acompaña al link
            url: url // Enlace al producto
        }).catch(err => console.log('Error compartir:', err));
    } else {
        // Si no soporta compartir, muestra el enlace y lo copia al portapapeles
        alert("Copia el enlace: " + url);
        try { 
            navigator.clipboard.writeText(url); 
        } catch(e){ 
            console.log(e); 
        }
    }
}
</script>

<%@ include file="footer.jsp" %> <%-- Inserta el pie de página común --%>
