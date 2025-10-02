<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, modelo.Producto" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Catálogo de Productos</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .producto {
            border:1px solid #ccc; border-radius:8px; padding:10px; margin:10px;
            display:inline-block; text-align:center; width:200px; box-shadow:2px 2px 5px rgba(0,0,0,0.2);
        }
        .producto img { width:150px; height:150px; object-fit:contain; margin-bottom:10px; }
        .precio { color:green; font-weight:bold; font-size:1.2em; }
    </style>
</head>
<body>
    <h1>Catálogo de Juguetes</h1>

    <c:forEach var="p" items="${listaProductos}">
        <div class="producto">
            <img src="${p.imagen}" alt="${p.nombre}" />
            <h3>${p.nombre}</h3>
            <p class="precio">$ ${p.precioVenta}</p>
            <a href="ProductoControlador?accion=detalle&id=${p.idProducto}">Ver Detalle</a>
        </div>
    </c:forEach>
</body>
</html>
