<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<style>
/* Estilos de productos */
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
.share-btn { background-color: #007bff; }
.detail-btn { background-color: #28a745; }
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
    String sqlCat = "SELECT id_categoria, nombre_categoria FROM categorias WHERE estado='Activa'";
    try (Connection conn = conexion.conexionDB.getConnection();
         PreparedStatement psCat = conn.prepareStatement(sqlCat);
         ResultSet rsCat = psCat.executeQuery()) {

        while (rsCat.next()) {
            int idCategoria = rsCat.getInt("id_categoria");
            String nombreCategoria = rsCat.getString("nombre_categoria");
%>

<div class="category">
    <h2><%= nombreCategoria %></h2>
    <div class="products">
    <%
        String sqlProd = "SELECT id_producto, nombre, precio_venta, imagen_url " +
                         "FROM productos WHERE id_categoria = ? AND estado='Activo' LIMIT 3";
        try (PreparedStatement psProd = conn.prepareStatement(sqlProd)) {
            psProd.setInt(1, idCategoria);
            try (ResultSet rsProd = psProd.executeQuery()) {
                while (rsProd.next()) {
                    int idProd = rsProd.getInt("id_producto");
                    String nombre = rsProd.getString("nombre");
                    String imagen = rsProd.getString("imagen_url");
                    double precio = rsProd.getDouble("precio_venta");
    %>
        <div class="product">
            <img src="<%= request.getContextPath() %>/imagenes/<%= imagen %>" alt="<%= nombre %>">
            <h3><%= nombre %></h3>
            <p>$<%= precio %></p>

            <form method="post" action="<%= request.getContextPath() %>/CarritoControlador" style="display:inline;">
                <input type="hidden" name="id" value="<%= idProd %>">
                <input type="hidden" name="nombre" value="<%= nombre %>">
                <input type="hidden" name="precio" value="<%= precio %>">
                <button type="submit" class="add-cart-btn">Añadir al carrito</button>
            </form>

            <button class="share-btn" onclick="compartirProductoFromButton(this)">Compartir</button>
            <a href="producto_detalle.jsp?id=<%= idProd %>" class="detail-btn">Ver detalle</a>
        </div>
    <%
                }
            }
        }
    %>
    </div>
    <a class="ver-mas" href="catalogo.jsp?categoria=<%= idCategoria %>">Ver más</a>
</div>

<%
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p style='color:red;text-align:center;'>Error al cargar categorías/productos: " + e.getMessage() + "</p>");
    }
%>

<%@ include file="footer.jsp" %>

<script>
function compartirProductoFromButton(btn) {
    const card = btn.closest('.product');
    if (!card) return;

    const nombreEl = card.querySelector('h3');
    const idInput = card.querySelector('form input[name="id"]');

    const nombre = nombreEl ? nombreEl.innerText.trim() : "Producto";
    const id = idInput ? idInput.value : "";

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
