<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestión de Productos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            color: #333;
        }
        form {
            margin-top: 20px;
        }
        label {
            display: block;
            margin: 8px 0 4px;
        }
        input[type="text"], input[type="number"] {
            width: 250px;
            padding: 6px;
            margin-bottom: 10px;
            border: 1px solid #aaa;
            border-radius: 4px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        /* Estilos mensajes */
        .mensaje {
            margin: 15px 0;
            padding: 12px;
            border-radius: 5px;
            font-weight: bold;
        }
        .exito {
            background-color: #d4edda;
            border: 1px solid #28a745;
            color: #155724;
        }
        .error {
            background-color: #f8d7da;
            border: 1px solid #dc3545;
            color: #721c24;
        }
        .advertencia {
            background-color: #fff3cd;
            border: 1px solid #ffc107;
            color: #856404;
        }
    </style>
</head>
<body>

<h2>Agregar Nuevo Producto</h2>

<%-- Bloque para mostrar mensajes desde el servlet --%>
<%
    String mensaje = (String) request.getAttribute("mensaje");
    if (mensaje != null) {
        String clase = "advertencia"; // por defecto

        if (mensaje.contains("✅")) {
            clase = "exito";
        } else if (mensaje.contains("❌")) {
            clase = "error";
        } else if (mensaje.contains("⚠️")) {
            clase = "advertencia";
        }
%>
    <div class="mensaje <%= clase %>">
        <%= mensaje %>
    </div>
<%
    }
%>

<form action="agregarProducto" method="post">
    <label for="nombre">Nombre del Producto:</label>
    <input type="text" id="nombre" name="nombre" required>

    <label for="precio">Precio:</label>
    <input type="number" step="0.01" id="precio" name="precio" required>

    <label for="stock">Stock:</label>
    <input type="number" id="stock" name="stock" required>

    <button type="submit">Agregar Producto</button>
</form>

</body>
</html>
