<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro - LUCA Opciones de Regalo</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0; 
            padding: 0; 
            background-color: #f5f9ff;
            color: #000;
        }

        .navbar { 
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            background-color: #003366;
            padding: 10px 20px; 
            display: flex; 
            align-items: center; 
            justify-content: space-between; 
        }

        .navbar a { 
            margin: 0 10px; 
            text-decoration: none; 
            color: #ffffff;
            font-weight: bold; 
            transition: color 0.3s;
        }

        .navbar a:hover { color: #ff0000; }

        .logo { display: flex; align-items: center; }
        .logo img { height: 50px; margin-right: 10px; }
        .logo span { color: #ff0000; font-size: 24px; font-weight: bold; }

        .main { 
            margin-top: 100px; 
            display: flex; 
            justify-content: center; 
        }

        .registro-form {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
        }

        .registro-form h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #003366;
        }

        .registro-form input[type="text"],
        .registro-form input[type="email"],
        .registro-form input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #003366;
            border-radius: 5px;
        }

        .registro-form button {
            width: 100%;
            padding: 10px;
            background-color: #003366;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }

        .registro-form button:hover {
            background-color: #ff0000;
        }

        .error-message {
            color: #ff0000;
            margin-bottom: 10px;
            text-align: center;
        }

        .registro-form p {
            text-align: center;
            margin-top: 15px;
        }

        .registro-form a {
            color: #003366;
            text-decoration: none;
            font-weight: bold;
        }

        .registro-form a:hover { color: #ff0000; }
    </style>
</head>
<body>

<!-- Barra de navegación -->
<div class="navbar">
    <div class="logo">
        <img src="imagenes/logo.png" alt="Logo LUCA">
        <span>LUCA Opciones de Regalo</span>
    </div>
    <div class="menu">
        <a href="index.jsp">Inicio</a>
        <a href="catalogo.jsp">Catálogo</a>
        <a href="contacto.jsp">Contacto</a>
        <a href="login.jsp">Login</a>
        <a href="registro.jsp">Registro</a>
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
        <a href="carrito.jsp">Carrito (<%= totalProductos %>)</a>
    </div>
</div>

<div class="main">
    <div class="registro-form">
        <h2>Registro de Usuario</h2>

        <% if(request.getAttribute("error") != null){ %>
            <div class="error-message"><%= request.getAttribute("error") %></div>
        <% } %>

        <form method="post" action="RegistroControlador">
            <input type="text" name="nombre" placeholder="Nombre completo" required>
            <input type="email" name="correo" placeholder="Correo electrónico" required>
            <input type="password" name="contraseña" placeholder="Contraseña" required>
            <input type="text" name="celular" placeholder="Celular">
            <input type="text" name="direccion" placeholder="Dirección">
            <button type="submit">Registrarse</button>
        </form>

        <p>¿Ya tienes cuenta? <a href="login.jsp">Inicia sesión</a></p>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
