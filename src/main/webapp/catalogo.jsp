<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, conexion.conexionDB" %>
<%@ include file="header.jsp" %>

<style>
.products .product {
    border: 1px solid #ddd;
    padding: 10px;
    margin: 10px;
    display: inline-block;
    vertical-align: top;
    width: 200px;
    text-align: center;
    background: #fff;
    border-radius: 8px;
}
.products .product img {
    width: 100%;
    height: 150px;
    object-fit: contain;
}
.products .product h3 {
    font-size: 16px;
    margin: 5px 0;
}
.products .product p {
    font-weight: bold;
}
.add-cart-btn, .share-btn, .detail-btn {
    display: block;
    margin: 5px auto;
    padding: 6px 10px;
    border: none;
    cursor: pointer;
    border-radius: 4px;
    text-decoration: none;
    color: #fff;
    font-weight: bold;
}
.add-cart-btn { background: #007bff; }
.share-btn { background: #28a745; }
.detail-btn { background: #6c757d; }
</style>

<%
    String sqlCat = "SELECT id_categoria, nombre_categoria FROM categorias WHERE estado='Activa'";
    try (Connection conn = conexionDB.getConnection();
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
        String sqlProd = "SELECT id_producto, nombre, precio_venta, imagen_url FROM productos WHERE id_categoria=? AND estado='Activo' LIMIT 6";
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
            <img src="<%= request.getContextPath() %>/imagenes/<%= imagen != null ? imagen : "no_imagen.png" %>" alt="<%= nombre %>">
            <h3><%= nombre %></h3>
            <p>$<%= precio %></p>

            <!-- Añadir al carrito -->
            <form method="post" action="<%= request.getContextPath() %>/CarritoControlador">
                <input type="hidden" name="id" value="<%= idProd %>">
                <input type="hidden" name="nombre" value="<%= nombre %>">
                <input type="hidden" name="precio" value="<%= precio %>">
                <button type="submit" class="add-cart-btn">Añadir al carrito</button>
            </form>

            <!-- Compartir -->
            <button class="share-btn" onclick="compartirProducto('<%= idProd %>', '<%= nombre %>')">Compartir</button>

            <!-- Ver detalle -->
            <a href="producto_detalle.jsp?id=<%= idProd %>" class="detail-btn">Ver detalle</a>
        </div>
    <%
                }
            }
        }
    %>
    </div>
    <a href="catalogo.jsp?categoria=<%= idCategoria %>">Ver más</a>
</div>
<%
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p style='color:red;text-align:center;'>Error al cargar categorías/productos: " + e.getMessage() + "</p>");
    }
%>

<script>
function compartirProducto(id, nombre) {
    const url = window.location.origin + "<%= request.getContextPath() %>/producto_detalle.jsp?id=" + encodeURIComponent(id);
    if (navigator.share) {
        navigator.share({
            title: "LUCA Opciones de Regalo",
            text: "Mira este producto: " + nombre,
            url: url
        }).catch(err => console.log('Error compartir:', err));
    } else {
        alert("Copia el enlace: " + url);
        try { navigator.clipboard.writeText(url); } catch(e){ console.log(e); }
    }
}
</script>

<%@ include file="footer.jsp" %>
