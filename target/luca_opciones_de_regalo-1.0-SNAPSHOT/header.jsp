<%@ page contentType="text/html;charset=UTF-8" language="java" %>  <%-- Configura el tipo de contenido y el lenguaje de la página JSP --%>
<%@ page import="java.util.*, modelo.Carrito" %>  <%-- Importa utilidades de Java y la clase Carrito para manejar el carrito en la sesión --%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>LUCA Opciones de Regalo</title>
    <style>
        /* ===== Estilos generales ===== */
        body { 
            font-family: Arial, sans-serif; 
            margin: 0; padding: 0; 
            background-color: #f5f9ff; 
            color: #000;
        }
        /* Barra de navegación superior */
        .navbar { 
            position: fixed; top: 0; left: 0; right: 0; 
            z-index: 1000; background-color: #003366; 
            padding: 10px 20px; display: flex; 
            align-items: center; justify-content: space-between; 
        }
        .navbar a { 
            margin: 0 10px; text-decoration: none; 
            color: #fff; font-weight: bold; 
            transition: color 0.3s; 
        }
        .navbar a:hover { color: #ff0000; }
        .logo { display: flex; align-items: center; }
        .logo img { height: 50px; margin-right: 10px; }
        .logo span { color: #ff0000; font-size: 24px; font-weight: bold; }

        /* Margen superior para no tapar el contenido con la barra fija */
        .main { margin-top: 80px; }

        /* Estilo para el contador en el carrito */
        .menu a span {
            background-color: #ff0000; 
            color: #fff; 
            padding: 2px 6px; 
            border-radius: 50%; 
            font-weight: bold; 
            margin-left: 4px;
        }

        /* ===== Estilos para categorías y productos ===== */
        .category { margin: 20px; }
        .products { 
            display: grid; 
            grid-template-columns: repeat(3, 1fr); 
            gap: 20px; 
        }
        .product { 
            border: 1px solid #003366; 
            padding: 10px; 
            text-align: center; 
            background-color: #f0f8ff; 
            transition: transform 0.3s; 
        }
        .product:hover { 
            transform: scale(1.05); 
            border-color: #ff0000; 
        }
        .product img { 
            width: 100%; height: 200px; 
            object-fit: contain; 
            background-color: white; 
            border-bottom: 1px solid #003366; 
            margin-bottom: 5px; 
        }
        .product h3 { margin: 5px 0; color: #000; }
        .product p { color: #ff0000; font-weight: bold; }

        /* Botón: añadir al carrito */
        .add-cart-btn { 
            background-color: #003366; 
            color: #fff; border: none; 
            padding: 8px 12px; cursor: pointer; 
            margin-top: 5px; font-weight: bold; 
            transition: background 0.3s; 
        }
        .add-cart-btn:hover { background-color: #ff0000; }

        /* Botón: compartir */
        .share-btn { 
            background-color: #25d366; 
            color: white; border: none; 
            padding: 6px 10px; cursor: pointer; 
            margin-top: 5px; font-weight: bold; 
            border-radius: 5px; 
            transition: background 0.3s; 
        }
        .share-btn:hover { background-color: #128c7e; }

        /* Botón: ver detalle */
        .detail-btn { 
            background-color: #ff9900; 
            color: white; border: none; 
            padding: 6px 10px; cursor: pointer; 
            margin-top: 5px; font-weight: bold; 
            border-radius: 5px; 
            transition: background 0.3s; 
            text-decoration: none; display: inline-block; 
        }
        .detail-btn:hover { background-color: #cc7a00; }

        /* Enlace: ver más productos */
        .ver-mas { 
            display: block; margin-top: 10px; 
            text-decoration: none; 
            color: #003366; 
            font-weight: bold; 
        }
        .ver-mas:hover { color: #ff0000; }

        /* Responsivo para tablets y móviles */
        @media (max-width: 900px) { .products { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 600px) { .products { grid-template-columns: 1fr; } }
    </style>
</head>
<body>

<!-- Barra de navegación -->
<div class="navbar">
    <!-- Logo de la tienda -->
    <div class="logo">
        <img src="imagenes/logo.png" alt="Logo LUCA">
        <span>LUCA Opciones de Regalo</span>
    </div>
    <!-- Menú de navegación -->
    <div class="menu">
        <a href="index.jsp">Inicio</a>
        <a href="catalogo.jsp">Catálogo</a>
        <a href="contacto.jsp">Contacto</a>
        <a href="login.jsp">Login</a>
        <a href="registro.jsp">Registro</a>

        <%-- Cálculo del total de productos en el carrito (obtenido de la sesión) --%>
        <%
            int totalProductos = 0;
            List<?> carritoHeader = (List<?>) session.getAttribute("carrito");
            if (carritoHeader != null) {
                for (Object o : carritoHeader) {
                    modelo.Carrito c = (modelo.Carrito) o;
                    totalProductos += c.getCantidad();   // Suma la cantidad de cada producto
                }
            }
        %>
        <!-- Enlace al carrito mostrando la cantidad total de productos -->
        <a href="carrito.jsp">Carrito (<%= totalProductos %>)</a>
    </div>
</div>

<!-- Contenido principal (se abre aquí, se cerrará en otros JSP con </div>) -->
<div class="main">
