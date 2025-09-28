<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, modelo.Carrito" %>
<%@ include file="header.jsp" %>

<div class="main">
    <h2 style="text-align: center;">🛒 Carrito de Compras</h2>

    <%
        List<Carrito> carrito = (List<Carrito>) session.getAttribute("carrito");
        double total = 0;
    %>

    <% if (carrito != null && !carrito.isEmpty()) { %>
        <table style="width: 80%; border-collapse: collapse; margin: 20px auto; text-align:center;">
            <thead style="background-color:#f8f9fa;">
                <tr>
                    <th style="padding:10px; border:1px solid #ccc;">Producto</th>
                    <th style="padding:10px; border:1px solid #ccc;">Precio</th>
                    <th style="padding:10px; border:1px solid #ccc;">Cantidad</th>
                    <th style="padding:10px; border:1px solid #ccc;">Subtotal</th>
                    <th style="padding:10px; border:1px solid #ccc;">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% for (Carrito c : carrito) {
                       double subtotal = c.getPrecio() * c.getCantidad();
                       total += subtotal;
                %>
                <tr>
                    <td style="padding:10px; border:1px solid #ccc;"><%= c.getNombre() %></td>
                    <td style="padding:10px; border:1px solid #ccc;">$<%= String.format("%,.2f", c.getPrecio()) %></td>
                    <td style="padding:10px; border:1px solid #ccc;">
                        <form action="ActualizarCarritoControlador" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= c.getIdProducto() %>">
                            <input type="number" name="cantidad" value="<%= c.getCantidad() %>" min="1" style="width:60px; text-align:center;">
                            <input type="submit" value="Actualizar" style="margin:2px; padding:5px 10px; background-color:#007bff; color:white; border:none; border-radius:5px; cursor:pointer;">
                        </form>
                    </td>
                    <td style="padding:10px; border:1px solid #ccc;">$<%= String.format("%,.2f", subtotal) %></td>
                    <td style="padding:10px; border:1px solid #ccc;">
                        <a href="EliminarCarritoControlador?id=<%= c.getIdProducto() %>" 
                           style="margin:2px; padding:5px 10px; background-color:#dc3545; color:white; text-decoration:none; border-radius:5px;"
                           onclick="return confirm('¿Seguro que deseas eliminar este producto del carrito?');">
                           Eliminar
                        </a>
                    </td>
                </tr>
                <% } %>
            </tbody>
            <tfoot style="background-color:#f1f1f1;">
                <tr>
                    <td colspan="3" style="padding:10px; border:1px solid #ccc; text-align:right;"><strong>Total</strong></td>
                    <td colspan="2" style="padding:10px; border:1px solid #ccc; text-align:left;"><strong>$<%= String.format("%,.2f", total) %></strong></td>
                </tr>
            </tfoot>
        </table>

        <div style="text-align:center; margin-top:20px;">
            <a href="checkout.jsp" style="padding:10px 20px; background-color:#28a745; color:white; text-decoration:none; border-radius:8px;">Finalizar Compra ✅</a>
        </div>

    <% } else { %>
        <p style="text-align:center; font-size:1.2em; color:#555;">⚠️ Tu carrito está vacío.</p>
    <% } %>

    <div style="text-align:center; margin-top:20px;">
        <a href="catalogo.jsp" style="text-decoration:none; color:#007bff; font-weight:bold;">⬅️ Seguir Comprando</a>
    </div>
</div>

<%@ include file="footer.jsp" %>
