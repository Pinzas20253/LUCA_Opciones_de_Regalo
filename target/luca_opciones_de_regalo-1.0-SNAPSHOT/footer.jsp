</div> <!-- cierre de main -->   <%-- Cierra el contenedor principal "main" abierto en otra parte del código --%>

<!-- Pie de página -->
<footer style="background-color:#003366; color:white; text-align:center; padding:15px; margin-top:20px;">
    &copy; 2025 LUCA Opciones de Regalo. Todos los derechos reservados.   <%-- Texto de derechos reservados en el footer --%>
</footer>

<script>
/* Función para compartir un producto */
function compartirProducto(id, nombre) {
    // Construye la URL del detalle del producto
    const url = window.location.origin + "/LUCA/detalleProducto.jsp?producto=" + id;

    // Verifica si el navegador soporta la API de compartir (navigator.share)
    if (navigator.share) {
        navigator.share({
            title: "LUCA Opciones de Regalo",   // Título del recurso compartido
            text: "Mira este producto: " + nombre,   // Texto que acompaña al enlace
            url: url   // URL del producto
        });
    } else {
        // Si no soporta navigator.share, muestra un mensaje con la URL
        const opciones = `Copia el enlace: ${url}`;
        alert(opciones);

        // Copia la URL al portapapeles
        navigator.clipboard.writeText(url);
    }
}
</script>

</body>
</html>
