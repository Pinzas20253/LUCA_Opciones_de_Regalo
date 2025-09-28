package modelo;

import java.io.Serializable;

public class Carrito implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idProducto;
    private String nombre;
    private double precio;
    private int cantidad;

    public Carrito() { }

    public Carrito(int idProducto, String nombre, double precio, int cantidad) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.precio = precio;
        this.cantidad = cantidad;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getSubtotal() {
        return precio * cantidad;
    }
}
