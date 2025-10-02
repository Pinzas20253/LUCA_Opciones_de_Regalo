<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<div class="container mt-5">
    <h2 class="text-center mb-4">Agregar Nuevo Producto</h2>

    <%-- Mensajes de error o éxito --%>
    <% if(request.getParameter("msg") != null){ %>
        <div class="alert alert-success text-center"><%= request.getParameter("msg") %></div>
    <% } %>
    <% if(request.getParameter("error") != null){ %>
        <div class="alert alert-danger text-center"><%= request.getParameter("error") %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/agregarProducto" method="post">
        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" class="form-control" name="nombre" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Descripción</label>
            <textarea class="form-control" name="descripcion" rows="3" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Código de Barras</label>
            <input type="text" class="form-control" name="codigoBarras" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Precio de Compra</label>
            <input type="number" class="form-control" name="precioCompra" step="0.01" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Precio de Venta</label>
            <input type="number" class="form-control" name="precioVenta" step="0.01" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Stock</label>
            <input type="number" class="form-control" name="stock" required>
        </div>
        <div class="mb-3">
            <label class="form-label">URL de Imagen</label>
            <input type="text" class="form-control" name="imagenUrl" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Estado</label>
            <select class="form-select" name="estado" required>
                <option value="Activo" selected>Activo</option>
                <option value="Inactivo">Inactivo</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Categoría</label>
            <select class="form-select" name="idCategoria" required>
                <%-- Aquí puedes cargar las categorías desde la BD --%>
                <%
                    try (Connection conn = conexion.conexionDB.getConnection();
                         PreparedStatement ps = conn.prepareStatement("SELECT id_categoria, nombre_categoria FROM categorias WHERE estado='Activa'");
                         ResultSet rs = ps.executeQuery()) {
                        while(rs.next()) {
                %>
                    <option value="<%= rs.getInt("id_categoria") %>"><%= rs.getString("nombre_categoria") %></option>
                <%
                        }
                    } catch(Exception e) {
                        out.println("<option value='0'>Error cargando categorías</option>");
                    }
                %>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Proveedor</label>
            <select class="form-select" name="idProveedor" required>
                <%-- Aquí puedes cargar los proveedores desde la BD --%>
                <%
                    try (Connection conn = conexion.conexionDB.getConnection();
                         PreparedStatement ps = conn.prepareStatement("SELECT id_proveedor, nombre_proveedor FROM proveedores");
                         ResultSet rs = ps.executeQuery()) {
                        while(rs.next()) {
                %>
                    <option value="<%= rs.getInt("id_proveedor") %>"><%= rs.getString("nombre_proveedor") %></option>
                <%
                        }
                    } catch(Exception e) {
                        out.println("<option value='0'>Error cargando proveedores</option>");
                    }
                %>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Agregar Producto</button>
    </form>
</div>

<%@ include file="footer.jsp" %>
