<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contacto - LUCA Opciones de Regalo</title>
    <style>
        .contact-container {
            max-width: 600px;
            margin: 80px auto 40px;
            padding: 20px;
            background-color: #f0f8ff;
            border: 1px solid #003366;
            border-radius: 10px;
        }
        .contact-container h2 {
            color: #003366;
            margin-bottom: 20px;
        }
        .contact-container label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        .contact-container input, 
        .contact-container textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #003366;
            border-radius: 5px;
        }
        .contact-container button {
            background-color: #003366;
            color: #fff;
            padding: 10px 15px;
            margin-top: 15px;
            border: none;
            cursor: pointer;
            font-weight: bold;
            border-radius: 5px;
        }
        .contact-container button:hover {
            background-color: #ff0000;
        }
    </style>
</head>
<body>
<div class="contact-container">
    <h2>Contáctanos</h2>
    <form method="post" action="ContactoControlador">
        <label for="nombre">Nombre:</label>
        <input type="text" name="nombre" id="nombre" required>

        <label for="correo">Correo electrónico:</label>
        <input type="email" name="correo" id="correo" required>

        <label for="asunto">Asunto:</label>
        <input type="text" name="asunto" id="asunto">

        <label for="mensaje">Mensaje:</label>
        <textarea name="mensaje" id="mensaje" rows="5" required></textarea>

        <button type="submit">Enviar</button>
    </form>
</div>
</body>
</html>
<%@ include file="footer.jsp" %>
