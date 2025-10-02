<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String usuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");

    if (usuario == null || !"administrador".equalsIgnoreCase(rol)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Administración - LUCA Opciones de Regalo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">LUCA Admin</a>
        <div class="d-flex">
            <span class="navbar-text text-white me-3">
                Bienvenido, <strong><%= usuario %></strong>
            </span>
            <a href="logout.jsp" class="btn btn-outline-light btn-sm">Cerrar sesión</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h1 class="mb-4 text-center">Panel de Administración</h1>
    <div class="row g-4">
        
        <!-- Opción productos -->
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Administrar Productos</h5>
                    <p class="card-text">Agregar, editar o eliminar productos de la tienda.</p>
                    <a href="administrar_productos.jsp" class="btn btn-primary">Ir a productos</a>
                </div>
            </div>
        </div>
        
        <!-- Opción usuarios -->
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Administrar Usuarios</h5>
                    <p class="card-text">Gestione las cuentas de los clientes y administradores.</p>
                    <a href="#" class="btn btn-primary disabled">Ir a usuarios</a>
                </div>
            </div>
        </div>
        
        <!-- Opción pedidos -->
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5 class="card-title">Pedidos</h5>
                    <p class="card-text">Ver y actualizar el estado de los pedidos.</p>
                    <a href="#" class="btn btn-primary disabled">Ir a pedidos</a>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
