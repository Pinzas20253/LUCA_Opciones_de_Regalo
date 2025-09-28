<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bienvenido - LUCA Opciones de Regalo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f9ff;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .navbar {
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
        }
        .navbar a:hover { color: #ff0000; }
        .logo { display: flex; align-items: center; }
        .logo img { height: 50px; margin-right: 10px; }
        .logo span { color: #ff0000; font-size: 24px; font-weight: bold; }

        .container {
            margin-top: 100px;
        }
        h1 {
            color: #003366;
        }
        p {
            color: #000;
            font-size: 18px;
        }
        a.boton {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #003366;
            color: #fff;
            font-weight: bold;
            text-decoration: none;
            border-radius: 6px;
        }
        a.boton:hover { background-color: #ff0000; }
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
        <a href="carrito.jsp">Carrito</a>
    </div>
</div>

<!-- Contenido de bienvenida -->
<div class="container">
    <h1>¡Bienvenido a LUCA Opciones de Regalo!</h1>
    <p>Has iniciado sesión correctamente 🎉</p>
    <a class="boton" href="index.jsp">Ir al Inicio</a>
</div>

</body>
</html>
