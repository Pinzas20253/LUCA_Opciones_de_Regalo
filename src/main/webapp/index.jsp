<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%-- Configuración de la página JSP: tipo de contenido y lenguaje --%>
<%@ page import="java.sql.*" %> <%-- Importa las librerías necesarias para trabajar con SQL --%>
<%@ include file="header.jsp" %> <%-- Incluye el encabezado común en la página --%>

<style>
/* Estilos CSS para dar diseño a los productos */
.products {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}
.product {
    width: 200px;
    padding: 10px;
    border: 1px solid #ddd;
    text-align: center;
    background: #fff;
    border-radius: 8px;
}
.product img {
    width: 100%;
    height: 200px;
    object-fit: contain;
    margin-bottom: 5px;
}
.product h3 {
    font-size: 1.1em;
    margin: 5px 0;
}
.product p {
    font-weight: bold;
    margin: 5px 0;
}
.add-cart-btn, .share-btn, .detail-btn {
    display: inline-block;
    margin: 3px 2px;
    padding: 5px 10px;
    background-color: #003366;
    color: white;
    text-decoration: none;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}
.share-btn { background-color: #007bff; } /* Botón azul para compartir */
.detail-btn { background-color: #28a745; } /* Botón verde para ver detalles */
.category {
    margin-bottom: 40px;
}
.ver-mas {
    display: inline-block;
    margin-top: 10px;
    font-weight: bold;
    color: #003366;
}
</style>

<%
    // Consulta SQL para obtener las categorías activas
    String sqlCat = "SELECT id_categoria, nombre_categoria FROM categorias WHERE estado='Activa'";
    // Se establece la conexión y se ejecuta la consulta
    try (Connection conn = conexion.conexionDB.getConnection();
         PreparedStatement psCat = conn.prepareStatement(sqlCat);
         ResultSet rsCat = psCat.executeQuery()) {

        // Recorre todas las categorías activas
        while (rsCat.next()) {
            int idCategoria = rsCat.getInt("id_categoria"); // ID de la categoría
            String nombreCategoria = rsCat.getString("nombre_categoria"); // Nombre de la categoría
%>

<div class="category"> <%-- Contenedor para cada categoría --%>
    <h2><%= nombreCategoria %></h2> <%-- Muestra el nombre de la categoría --%>
    <div class="products"> <%-- Contenedor de los productos de la categoría --%>
    <%
        // Consulta SQL para obtener productos de la categoría (máximo 3)
        String sqlProd = "SELECT id_producto, nombre, precio_venta, imagen_url " +
                         "FROM productos WHERE id_categoria = ? AND estado='Activo' LIMIT 3";
        try (PreparedStatement psProd = conn.prepareStatement(sqlProd)) {
            psProd.setInt(1, idCategoria); // Se pasa el ID de categoría
            try (ResultSet rsProd = psProd.executeQuery()) {
                // Recorre todos los productos de la categoría
                while (rsProd.next()) {
                    int idProd = rsProd.getInt("id_producto"); // ID del producto
                    String nombre = rsProd.getString("nombre"); // Nombre del producto
                    String imagen = rsProd.getString("imagen_url"); // Imagen del producto
                    double precio = rsProd.getDouble("precio_venta"); // Precio del producto
    %>
        <div class="product"> <%-- Tarjeta de cada producto --%>
            <img src="<%= request.getContextPath() %>/imagenes/<%= imagen %>" alt="<%= nombre %>"> <%-- Imagen del producto --%>
            <h3><%= nombre %></h3> <%-- Nombre del producto --%>
            <p>$<%= precio %></p> <%-- Precio del producto --%>

            <%-- Formulario para añadir el producto al carrito --%>
            <form method="post" action="<%= request.getContextPath() %>/CarritoControlador" style="display:inline;">
                <input type="hidden" name="id" value="<%= idProd %>"> <%-- ID oculto --%>
                <input type="hidden" name="nombre" value="<%= nombre %>"> <%-- Nombre oculto --%>
                <input type="hidden" name="precio" value="<%= precio %>"> <%-- Precio oculto --%>
                <button type="submit" class="add-cart-btn">Añadir al carrito</button>
            </form>

            <%-- Botón para compartir el producto --%>
            <button class="share-btn" onclick="compartirProductoFromButton(this)">Compartir</button>
            
            <%-- Botón para ver detalle del producto --%>
            <a href="producto_detalle.jsp?id=<%= idProd %>" class="detail-btn">Ver detalle</a>
        </div>
    <%
                } // Fin while productos
            } // Fin ResultSet productos
        } // Fin PreparedStatement productos
    %>
    </div>
    <%-- Enlace para ver más productos de la categoría --%>
    <a class="ver-mas" href="catalogo.jsp?categoria=<%= idCategoria %>">Ver más</a>
</div>

<%
        } // Fin while categorías
    } catch (SQLException e) {
        // Captura y muestra error si algo falla en la base de datos
        e.printStackTrace();
        out.println("<p style='color:red;text-align:center;'>Error al cargar categorías/productos: " + e.getMessage() + "</p>");
    }
%>

<%@ include file="footer.jsp" %> <%-- Incluye el pie de página --%>

<script>
// Función para compartir un producto
function compartirProductoFromButton(btn) {
    const card = btn.closest('.product'); // Busca la tarjeta del producto
    if (!card) return;

    const nombreEl = card.querySelector('h3'); // Obtiene el nombre
    const idInput = card.querySelector('form input[name="id"]'); // Obtiene el ID

    const nombre = nombreEl ? nombreEl.innerText.trim() : "Producto"; // Nombre del producto
    const id = idInput ? idInput.value : ""; // ID del producto

    // Construye la URL del producto
    const urlProducto = window.location.origin + "<%= request.getContextPath() %>/producto_detalle.jsp?id=" + encodeURIComponent(id);

    // Usa la API de compartir del navegador si está disponible
    if (navigator.share) {
        navigator.share({
            title: "LUCA Opciones de Regalo",
            text: "Mira este producto: " + nombre,
            url: urlProducto
        }).catch(err => console.log("Error al compartir:", err));
    } else {
        // Si no soporta compartir, copia el enlace al portapapeles
        navigator.clipboard.writeText(urlProducto).then(() => {
            alert("Enlace copiado al portapapeles:\n" + urlProducto);
        }).catch(err => {
            alert("Copia manualmente este enlace:\n" + urlProducto);
        });
    }
}
</script>
