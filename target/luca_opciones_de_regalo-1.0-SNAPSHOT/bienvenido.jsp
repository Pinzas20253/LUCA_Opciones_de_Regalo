<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%-- Configuración inicial de la página JSP --%>
<!DOCTYPE html> <%-- Declaración del tipo de documento HTML5 --%>
<html>
<head>
    <meta charset="UTF-8"> <%-- Configuración de codificación de caracteres --%>
    <title>Bienvenido - LUCA Opciones de Regalo</title> <%-- Título que aparece en la pestaña del navegador --%>
    <style>
        /* Estilos generales de la página */
        body {
            font-family: Arial, sans-serif; /* Fuente del texto */
            background-color: #f5f9ff; /* Color de fondo */
            margin: 0;
            padding: 0;
            text-align: center; /* Centrar el texto */
        }
        /* Estilos de la barra de navegación */
        .navbar {
            background-color: #003366; /* Azul oscuro */
            padding: 10px 20px;
            display: flex; /* Para organizar en fila */
            align-items: center; /* Centrar verticalmente */
            justify-content: space-between; /* Espacio entre logo y menú */
        }
        /* Estilos de los enlaces del menú */
        .navbar a {
            margin: 0 10px;
            text-decoration: none; /* Quitar subrayado */
            color: #ffffff; /* Texto blanco */
            font-weight: bold;
        }
        .navbar a:hover { color: #ff0000; } /* Cambia a rojo cuando pasas el mouse */
        
        /* Estilo del logo */
        .logo { display: flex; align-items: center; }
        .logo img { height: 50px; margin-right: 10px; } /* Imagen del logo */
        .logo span { color: #ff0000; font-size: 24px; font-weight: bold; } /* Texto al lado del logo */

        /* Contenedor central */
        .container {
            margin-top: 100px; /* Separación desde arriba */
        }
        h1 {
            color: #003366; /* Azul oscuro */
        }
        p {
            color: #000;
            font-size: 18px; /* Tamaño del texto */
        }
        /* Botón personalizado */
        a.boton {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #003366; /* Azul oscuro */
            color: #fff;
            font-weight: bold;
            text-decoration: none;
            border-radius: 6px; /* Bordes redondeados */
        }
        a.boton:hover { background-color: #ff0000; } /* Se vuelve rojo al pasar el mouse */
    </style>
</head>
<body>

<!-- Barra de navegación superior -->
<div class="navbar">
    <!-- Logo con imagen y texto -->
    <div class="logo">
        <img src="imagenes/logo.png" alt="Logo LUCA"> <%-- Logo de la tienda --%>
        <span>LUCA Opciones de Regalo</span> <%-- Texto al lado del logo --%>
    </div>
    <!-- Menú de navegación -->
    <div class="menu">
        <a href="index.jsp">Inicio</a>
        <a href="catalogo.jsp">Catálogo</a>
        <a href="contacto.jsp">Contacto</a>
        <a href="carrito.jsp">Carrito</a>
    </div>
</div>

<!-- Contenido principal de bienvenida -->
<div class="container">
    <h1>¡Bienvenido a LUCA Opciones de Regalo!</h1> <%-- Mensaje de bienvenida --%>
    <p>Has iniciado sesión correctamente 🎉</p> <%-- Confirmación de inicio de sesión --%>
    <a class="boton" href="index.jsp">Ir al Inicio</a> <%-- Botón para volver a la página de inicio --%>
</div>

</body>
</html>
