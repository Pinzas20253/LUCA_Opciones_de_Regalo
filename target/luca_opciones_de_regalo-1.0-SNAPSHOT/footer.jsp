</div> <!-- cierre de main -->

<footer style="background-color:#003366; color:white; text-align:center; padding:15px; margin-top:20px;">
    &copy; 2025 LUCA Opciones de Regalo. Todos los derechos reservados.
</footer>

<script>
function compartirProducto(id, nombre) {
    const url = window.location.origin + "/LUCA/detalleProducto.jsp?producto=" + id;
    if (navigator.share) {
        navigator.share({
            title: "LUCA Opciones de Regalo",
            text: "Mira este producto: " + nombre,
            url: url
        });
    } else {
        const opciones = `Copia el enlace: ${url}`;
        alert(opciones);
        navigator.clipboard.writeText(url);
    }
}
</script>
</body>
</html>
