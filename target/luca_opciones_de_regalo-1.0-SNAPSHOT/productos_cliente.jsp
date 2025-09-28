<%@ page contentType="text/html;charset=UTF-8" language="java" %>  
<!-- Directiva JSP: define el tipo de contenido como HTML y la codificación UTF-8 -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!-- Importa la librería JSTL Core (etiquetas de control como forEach, if, etc.) con el prefijo "c" -->

<html>
<head>
    <title>Catálogo de Productos</title>  <!-- Título de la página -->

    <!-- Estilos CSS para el catálogo -->
    <style>
        body { font-family: Arial, sans-serif; } /* Fuente general */

        .producto {
            border: 1px solid #ccc;            /* Borde gris */
            border-radius: 8px;                /* Bordes redondeados */
            padding: 10px;                     /* Espaciado interno */
            margin: 10px;                      /* Espaciado externo */
            display: inline-block;             /* Se alinean en fila */
            text-align: center;                /* Centra contenido */
            width: 200px;                      /* Ancho fijo */
            box-shadow: 2px 2px 5px rgba(0,0,0,0.2); /* Sombra ligera */
        }

        .producto img {
            width: 150px;          /* Ancho de imagen */
            height: 150px;         /* Alto de imagen */
            object-fit: contain;   /* Ajusta la imagen sin deformarla */
            margin-bottom: 10px;   /* Espacio debajo de la imagen */
        }

        .precio {
            color: green;           /* Texto en verde */
            font-weight: bold;      /* Texto en negrilla */
            font-size: 1.2em;       /* Un poco más grande */
        }
    </style>
</head>
<body>
    <!-- Título visible de la página -->
    <h1>Catálogo de Juguetes</h1>

    <div>
        <!-- Bucle para recorrer la lista de productos (listaProductos) -->
        <c:forEach var="p" items="${listaProductos}">
            <!-- Cada producto se muestra en una tarjeta con clase "producto" -->
            <div class="producto">
                <!-- Imagen del producto -->
                <img src="${p.imagen}" alt="${p.nombre}"/>
                <!-- Nombre del producto -->
                <h3>${p.nombre}</h3>
                <!-- Precio del producto -->
                <p class="precio">$ ${p.precio}</p>
            </div>
        </c:forEach>
    </div>
</body>
</html>
