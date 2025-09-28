package modelo;

public class Producto {
    private int idProducto;
    private String nombre;
    private String descripcion;
    private String codigoBarras;
    private double precioCompra;
    private double precioVenta;
    private int stock;
    private String imagenUrl;
    private String estado;
    private int idCategoria;
    private int idProveedor;

    public Producto() {}

    public Producto(int idProducto, String nombre, String descripcion, String codigoBarras,
                    double precioCompra, double precioVenta, int stock, String imagenUrl,
                    String estado, int idCategoria, int idProveedor) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.codigoBarras = codigoBarras;
        this.precioCompra = precioCompra;
        this.precioVenta = precioVenta;
        this.stock = stock;
        this.imagenUrl = imagenUrl;
        this.estado = estado;
        this.idCategoria = idCategoria;
        this.idProveedor = idProveedor;
    }

    // Getters y Setters
    public int getIdProducto() { return idProducto; }
    public void setIdProducto(int idProducto) { this.idProducto = idProducto; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getCodigoBarras() { return codigoBarras; }
    public void setCodigoBarras(String codigoBarras) { this.codigoBarras = codigoBarras; }

    public double getPrecioCompra() { return precioCompra; }
    public void setPrecioCompra(double precioCompra) { this.precioCompra = precioCompra; }

    public double getPrecioVenta() { return precioVenta; }
    public void setPrecioVenta(double precioVenta) { this.precioVenta = precioVenta; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getImagenUrl() { return imagenUrl; }
    public void setImagenUrl(String imagenUrl) { this.imagenUrl = imagenUrl; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public int getIdCategoria() { return idCategoria; }
    public void setIdCategoria(int idCategoria) { this.idCategoria = idCategoria; }

    public int getIdProveedor() { return idProveedor; }
    public void setIdProveedor(int idProveedor) { this.idProveedor = idProveedor; }
}
