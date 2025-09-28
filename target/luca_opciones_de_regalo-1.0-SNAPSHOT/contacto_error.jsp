<%@ include file="header.jsp" %>   <%-- Incluye el archivo header.jsp al inicio, para mantener la misma cabecera en todas las páginas --%>

<div style="max-width: 600px; margin: 100px auto; text-align: center;">   <%-- Contenedor centrado, con ancho máximo de 600px y margen superior para separación --%>
    <h2>Error al enviar el mensaje</h2>   <%-- Título principal que informa al usuario del error --%>
    <p>Hubo un problema al procesar tu solicitud. Por favor, intenta de nuevo.</p>   <%-- Mensaje explicativo para el usuario --%>
    <a href="contacto.jsp" style="color:#003366; font-weight:bold;">Volver al formulario</a>   <%-- Enlace que redirige al formulario de contacto para que el usuario lo intente de nuevo --%>
</div>

<%@ include file="footer.jsp" %>   <%-- Incluye el archivo footer.jsp al final de la página, que contiene el pie de página común --%>
