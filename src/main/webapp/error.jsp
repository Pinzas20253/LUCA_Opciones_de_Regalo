<%@ page contentType="text/html;charset=UTF-8" language="java" %>   <%-- Configura el contenido de la página como HTML con codificación UTF-8 y lenguaje Java --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">   <%-- Define la codificación de caracteres como UTF-8 --%>
    <title>Error de inicio de sesión</title>   <%-- Título de la pestaña del navegador --%>
    <style>
        /* Estilos generales */
        body {
            font-family: Arial, sans-serif;   /* Fuente de la página */
            background-color: #fff0f0;       /* Fondo rosado claro para indicar error */
            margin: 0;
            padding: 0;
            text-align: center;              /* Centra el texto */
        }

        /* Barra de navegación superior */
        .navbar {
            background-color: #003366;       /* Azul oscuro corporativo */
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
        .navbar a:hover { color: #ff0000; }   /* Cambio a rojo al pasar el mouse */
        
        /* Logo */
        .logo { display: flex; align-items: center; }
        .logo img { height: 50px; margin-right: 10px; }   /* Imagen del logo */
        .logo span { color: #ff0000; font-size: 24px; font-weight: bold; }   /* Nombre LUCA en rojo */

        /* Contenedor principal del mensaje */
        .container {
            margin-top: 100px;   /* Espacio desde arriba */
        }
        h1 {
            color: #cc0000;      /* Rojo fuerte para resaltar el error */
        }
        p {
            color: #000;
            font-size: 18px;
        }

        /* Botón de volver */
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
        a.boton:hover { background-color: #ff0000; }   /* Cambio de color al pasar el mouse */
    </style>
</head>
<body>

<!-- Barra de navegación -->
<div class="navbar">
    <div class="logo">
        <img src="imagenes/logo.png" alt="Logo LUCA">   <%-- Logo de la tienda --%>
        <span>LUCA Opciones de Regalo</span>   <%-- Nombre de la tienda --%>
    </div>
    <div class="menu">
        <a href="index.jsp">Inicio</a>      <%-- Enlace a la página de inicio --%>
        <a href="catalogo.jsp">Catálogo</a> <%-- Enlace al catálogo --%>
        <a href="contacto.jsp">Contacto</a> <%-- Enlace a la página de contacto --%>
    </div>
</div>

<!-- Contenido de error -->
<div class="container">
    <h1>❌ Usuario o clave incorrectos</h1>   <%-- Mensaje de error principal --%>
    <p>Por favor, inténtalo de nuevo.</p>   <%-- Texto explicativo --%>
    <a class="boton" href="login.jsp">Volver al login</a>   <%-- Botón para regresar al formulario de login --%>
</div>

</body>
</html>
