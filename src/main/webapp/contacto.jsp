<%@ include file="header.jsp" %>   <%-- Incluye el archivo header.jsp al inicio de la página, normalmente contiene menú, cabecera o estilos comunes --%>
<!DOCTYPE html>   <%-- Declaración del tipo de documento HTML5 --%>
<html>
<head>
    <meta charset="UTF-8">   <%-- Define la codificación de caracteres en UTF-8 para admitir tildes y caracteres especiales --%>
    <title>Contacto - LUCA Opciones de Regalo</title>   <%-- Título que aparecerá en la pestaña del navegador --%>
    <style>
        /* Estilos CSS para dar formato a la sección de contacto */
        .contact-container {
            max-width: 600px;   /* Ancho máximo del contenedor */
            margin: 80px auto 40px;   /* Centrado horizontal y separación arriba/abajo */
            padding: 20px;   /* Espaciado interno */
            background-color: #f0f8ff;   /* Fondo celeste claro */
            border: 1px solid #003366;   /* Borde azul oscuro */
            border-radius: 10px;   /* Bordes redondeados */
        }
        .contact-container h2 {
            color: #003366;   /* Texto azul oscuro */
            margin-bottom: 20px;   /* Separación inferior */
        }
        .contact-container label {
            display: block;   /* Hace que cada etiqueta ocupe toda la línea */
            margin-top: 10px;   /* Separación superior */
            font-weight: bold;   /* Texto en negrita */
        }
        .contact-container input, 
        .contact-container textarea {
            width: 100%;   /* Los campos ocupan todo el ancho disponible */
            padding: 8px;   /* Espaciado interno */
            margin-top: 5px;   /* Separación superior */
            border: 1px solid #003366;   /* Borde azul oscuro */
            border-radius: 5px;   /* Bordes redondeados */
        }
        .contact-container button {
            background-color: #003366;   /* Fondo azul oscuro */
            color: #fff;   /* Texto blanco */
            padding: 10px 15px;   /* Espaciado interno */
            margin-top: 15px;   /* Separación superior */
            border: none;   /* Sin borde */
            cursor: pointer;   /* Cursor tipo mano */
            font-weight: bold;   /* Texto en negrita */
            border-radius: 5px;   /* Bordes redondeados */
        }
        .contact-container button:hover {
            background-color: #ff0000;   /* Al pasar el mouse, el fondo cambia a rojo */
        }
    </style>
</head>
<body>
<div class="contact-container">   <%-- Contenedor principal del formulario de contacto --%>
    <h2>Contáctanos</h2>   <%-- Título visible en la página --%>
    <form method="post" action="ContactoControlador">   <%-- Formulario que envía datos al servlet ContactoControlador por POST --%>
        <label for="nombre">Nombre:</label>   <%-- Etiqueta para el campo de nombre --%>
        <input type="text" name="nombre" id="nombre" required>   <%-- Campo de texto obligatorio para el nombre --%>

        <label for="correo">Correo electrónico:</label>   <%-- Etiqueta para correo --%>
        <input type="email" name="correo" id="correo" required>   <%-- Campo de email obligatorio --%>

        <label for="asunto">Asunto:</label>   <%-- Etiqueta para el asunto --%>
        <input type="text" name="asunto" id="asunto">   <%-- Campo de texto opcional para asunto --%>

        <label for="mensaje">Mensaje:</label>   <%-- Etiqueta para el mensaje --%>
        <textarea name="mensaje" id="mensaje" rows="5" required></textarea>   <%-- Área de texto obligatoria para el mensaje --%>

        <button type="submit">Enviar</button>   <%-- Botón que envía el formulario --%>
    </form>
</div>
</body>
</html>
<%@ include file="footer.jsp" %>   <%-- Incluye el archivo footer.jsp al final de la página, normalmente pie de página común --%>
