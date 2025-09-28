<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%-- Configuración de la página: UTF-8 y lenguaje Java --%>
<%@ page import="java.util.*, modelo.Carrito" %> <%-- Importa las clases necesarias: listas y el modelo Carrito --%>
<%@ include file="header.jsp" %> <%-- Incluye el encabezado común a todas las páginas --%>

<div class="main">
    <h2 style="text-align: center;">🛒 Carrito de Compras</h2> <!-- Título centrado -->

    <%
        // Recupera el carrito desde la sesión y crea variable para el total
        List<Carrito> carrito = (List<Carrito>) session.getAttribute("carrito");
        double total = 0;
    %>

    <% if (carrito != null && !carrito.isEmpty()) { %> <%-- Si el carrito existe y no está vacío --%>
        <table style="width: 80%; border-collapse: collapse; margin: 20px auto; text-align:center;">
            <thead style="background-color:#f8f9fa;">
                <tr>
                    <!-- Encabezados de la tabla -->
                    <th style="padding:10px; border:1px solid #ccc;">Producto</th>
                    <th style="padding:10px; border:1px solid #ccc;">Precio</th>
                    <th style="padding:10px; border:1px solid #ccc;">Cantidad</th>
                    <th style="padding:10px; border:1px solid #ccc;">Subtotal</th>
                    <th style="padding:10px; border:1px solid #ccc;">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% 
                   // Recorre la lista de productos en el carrito
                   for (Carrito c : carrito) {
                       double subtotal = c.getPrecio() * c.getCantidad(); // Calcula el subtotal de cada producto
                       total += subtotal; // Acumula al total general
                %>
                <tr>
                    <!-- Nombre del producto -->
                    <td style="padding:10px; border:1px solid #ccc;"><%= c.getNombre() %></td>

                    <!-- Precio formateado -->
                    <td style="padding:10px; border:1px solid #ccc;">$<%= String.format("%,.2f", c.getPrecio()) %></td>

                    <!-- Formulario para actualizar la cantidad -->
                    <td style="padding:10px; border:1px solid #ccc;">
                        <form action="ActualizarCarritoControlador" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= c.getIdProducto() %>"> <%-- ID oculto del producto --%>
                            <input type="number" name="cantidad" value="<%= c.getCantidad() %>" min="1" style="width:60px; text-align:center;"> <%-- Cantidad editable --%>
                            <input type="submit" value="Actualizar" style="margin:2px; padding:5px 10px; background-color:#007bff; color:white; border:none; border-radius:5px; cursor:pointer;"> <%-- Botón actualizar --%>
                        </form>
                    </td>

                    <!-- Subtotal del producto -->
                    <td style="padding:10px; border:1px solid #ccc;">$<%= String.format("%,.2f", subtotal) %></td>

                    <!-- Botón eliminar producto -->
                    <td style="padding:10px; border:1px solid #ccc;">
                        <a href="EliminarCarritoControlador?id=<%= c.getIdProducto() %>" 
                           style="margin:2px; padding:5px 10px; background-color:#dc3545; color:white; text-decoration:none; border-radius:5px;"
                           onclick="return confirm('¿Seguro que deseas eliminar este producto del carrito?');">
                           Eliminar
                        </a>
                    </td>
                </tr>
                <% } %> <%-- Fin del bucle for --%>
            </tbody>
            <tfoot style="background-color:#f1f1f1;">
                <tr>
                    <!-- Fila de total acumulado -->
                    <td colspan="3" style="padding:10px; border:1px solid #ccc; text-align:right;"><strong>Total</strong></td>
                    <td colspan="2" style="padding:10px; border:1px solid #ccc; text-align:left;"><strong>$<%= String.format("%,.2f", total) %></strong></td>
                </tr>
            </tfoot>
        </table>

        <!-- Botón para finalizar la compra -->
        <div style="text-align:center; margin-top:20px;">
            <a href="checkout.jsp" style="padding:10px 20px; background-color:#28a745; color:white; text-decoration:none; border-radius:8px;">Finalizar Compra ✅</a>
        </div>

    <% } else { %> <%-- Si el carrito está vacío --%>
        <p style="text-align:center; font-size:1.2em; color:#555;">⚠️ Tu carrito está vacío.</p>
    <% } %>

    <!-- Botón para volver al catálogo -->
    <div style="text-align:center; margin-top:20px;">
        <a href="catalogo.jsp" style="text-decoration:none; color:#007bff; font-weight:bold;">⬅️ Seguir Comprando</a>
    </div>
</div>

<%@ include file="footer.jsp" %> <%-- Incluye el pie de página --%>
