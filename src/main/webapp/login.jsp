<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - LUCA Opciones de Regalo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f9ff, #e0ecff);
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .navbar { background-color: #003366; }
        .navbar a { color: #fff !important; font-weight: bold; }
        .navbar a:hover { color: #ff0000 !important; }
        .login-container { margin-top: 120px; display: flex; justify-content: center; }
        .login-card {
            width: 100%; max-width: 420px; border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2); padding: 30px; background: #fff;
        }
        .login-card h2 { text-align: center; color: #003366; margin-bottom: 20px; }
        .btn-login {
            background-color: #003366; color: #fff; font-weight: bold; transition: 0.3s;
        }
        .btn-login:hover { background-color: #ff0000; color: #fff; }
        .error-message { color: #ff0000; text-align: center; margin-bottom: 15px; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center text-white" href="index.jsp">
            <img src="imagenes/logo.png" alt="Logo LUCA" style="height: 45px; margin-right: 10px;">
            <span>LUCA Opciones de Regalo</span>
        </a>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                <li class="nav-item"><a class="nav-link" href="catalogo.jsp">Catálogo</a></li>
                <li class="nav-item"><a class="nav-link" href="contacto.jsp">Contacto</a></li>
                <li class="nav-item"><a class="nav-link active" href="login.jsp">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="registro.jsp">Registro</a></li>
                <li class="nav-item">
                    <%
                        int totalProductos = 0;
                        List carrito = (List) session.getAttribute("carrito");
                        if(carrito != null){
                            for(Object obj : carrito){
                                modelo.Carrito c = (modelo.Carrito) obj;
                                totalProductos += c.getCantidad();
                            }
                        }
                    %>
                    <a class="nav-link" href="carrito.jsp">Carrito (<%= totalProductos %>)</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="login-container">
    <div class="login-card">
        <h2>Iniciar Sesión</h2>

        <% if(request.getAttribute("error") != null){ %>
            <div class="error-message"><%= request.getAttribute("error") %></div>
        <% } %>

        <!-- Formulario apunta al contexto para que funcione en cualquier ruta -->
        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="mb-3">
                <input type="email" class="form-control" name="email" placeholder="Correo electrónico" required>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" name="password" placeholder="Contraseña" required>
            </div>
            <button type="submit" class="btn btn-login w-100">Ingresar</button>
        </form>

        <p class="text-center mt-3">¿No tienes cuenta?
            <a href="registro.jsp" class="fw-bold" style="color:#003366;">Regístrate aquí</a>
        </p>
    </div>
</div>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
