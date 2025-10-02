package modelo;

public class Usuario {
    private int idUsuario;   // coincide con id_usuario en la BD
    private String nombre;
    private String correo;
    private String password;
    private String celular;
    private String direccion;
    private String rol;

    // Constructor vacío
    public Usuario() {}

    // Constructor con parámetros (completo)
    public Usuario(int idUsuario, String nombre, String correo, String password, 
                   String celular, String direccion, String rol) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.correo = correo;
        this.password = password;
        this.celular = celular;
        this.direccion = direccion;
        this.rol = rol;
    }

    // Getters y Setters
    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getCelular() { return celular; }
    public void setCelular(String celular) { this.celular = celular; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }
}
