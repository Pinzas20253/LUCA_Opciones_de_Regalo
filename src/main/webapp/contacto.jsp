<%@ include file="header.jsp" %>   <%-- Incluye el archivo header.jsp al inicio de la p�gina, normalmente contiene men�, cabecera o estilos comunes --%>
<!DOCTYPE html>   <%-- Declaraci�n del tipo de documento HTML5 --%>
<html>
<head>
    <meta charset="UTF-8">   <%-- Define la codificaci�n de caracteres en UTF-8 para admitir tildes y caracteres especiales --%>
    <title>Contacto - LUCA Opciones de Regalo</title>   <%-- T�tulo que aparecer� en la pesta�a del navegador --%>
    <style>
        /* Estilos CSS para dar formato a la secci�n de contacto */
        .contact-container {
            max-width: 600px;   /* Ancho m�ximo del contenedor */
            margin: 80px auto 40px;   /* Centrado horizontal y separaci�n arriba/abajo */
            padding: 20px;   /* Espaciado interno */
            background-color: #f0f8ff;   /* Fondo celeste claro */
            border: 1px solid #003366;   /* Borde azul oscuro */
            border-radius: 10px;   /* Bordes redondeados */
        }
        .contact-container h2 {
            color: #003366;   /* Texto azul oscuro */
            margin-bottom: 20px;   /* Separaci�n inferior */
        }
        .contact-container label {
            display: block;   /* Hace que cada etiqueta ocupe toda la l�nea */
            margin-top: 10px;   /* Separaci�n superior */
            font-weight: bold;   /* Texto en negrita */
        }
        .contact-container input, 
        .contact-container textarea {
            width: 100%;   /* Los campos ocupan todo el ancho disponible */
            padding: 8px;   /* Espaciado interno */
            margin-top: 5px;   /* Separaci�n superior */
            border: 1px solid #003366;   /* Borde azul oscuro */
            border-radius: 5px;   /* Bordes redondeados */
        }
        .contact-container button {
            background-color: #003366;   /* Fondo azul oscuro */
            color: #fff;   /* Texto blanco */
            padding: 10px 15px;   /* Espaciado interno */
            margin-top: 15px;   /* Separaci�n superior */
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
    <h2>Cont�ctanos</h2>   <%-- T�tulo visible en la p�gina --%>
    <form method="post" action="ContactoControlador">   <%-- Formulario que env�a datos al servlet ContactoControlador por POST --%>
        <label for="nombre">Nombre:</label>   <%-- Etiqueta para el campo de nombre --%>
        <input type="text" name="nombre" id="nombre" required>   <%-- Campo de texto obligatorio para el nombre --%>

        <label for="correo">Correo electr�nico:</label>   <%-- Etiqueta para correo --%>
        <input type="email" name="correo" id="correo" required>   <%-- Campo de email obligatorio --%>

        <label for="asunto">Asunto:</label>   <%-- Etiqueta para el asunto --%>
        <input type="text" name="asunto" id="asunto">   <%-- Campo de texto opcional para asunto --%>

        <label for="mensaje">Mensaje:</label>   <%-- Etiqueta para el mensaje --%>
        <textarea name="mensaje" id="mensaje" rows="5" required></textarea>   <%-- �rea de texto obligatoria para el mensaje --%>

        <button type="submit">Enviar</button>   <%-- Bot�n que env�a el formulario --%>
    </form>
</div>
</body>
</html>
<%@ include file="footer.jsp" %>   <%-- Incluye el archivo footer.jsp al final de la p�gina, normalmente pie de p�gina com�n --%>
