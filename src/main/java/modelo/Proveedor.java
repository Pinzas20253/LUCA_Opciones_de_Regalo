package modelo;

public class Proveedor {
    private int idProveedor;
    private String nombreContacto;
    private String empresa;
    private String telefono;
    private String email;
    private String direccion;
    private String estado;

    public Proveedor() {}

    public Proveedor(int idProveedor, String nombreContacto, String empresa, String telefono,
                     String email, String direccion, String estado) {
        this.idProveedor = idProveedor;
        this.nombreContacto = nombreContacto;
        this.empresa = empresa;
        this.telefono = telefono;
        this.email = email;
        this.direccion = direccion;
        this.estado = estado;
    }

    // Getters y setters
    public int getIdProveedor() { return idProveedor; }
    public void setIdProveedor(int idProveedor) { this.idProveedor = idProveedor; }

    public String getNombreContacto() { return nombreContacto; }
    public void setNombreContacto(String nombreContacto) { this.nombreContacto = nombreContacto; }

    public String getEmpresa() { return empresa; }
    public void setEmpresa(String empresa) { this.empresa = empresa; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
