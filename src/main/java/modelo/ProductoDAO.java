package modelo;

import java.sql.*;
import java.util.*;
import conexion.conexionDB;

public class ProductoDAO {

    // Listar todos los productos
    public List<Producto> listar() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos ORDER BY id_producto DESC";

        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecioCompra(rs.getDouble("precio_compra"));
                p.setPrecioVenta(rs.getDouble("precio_venta"));
                p.setStock(rs.getInt("stock"));
                p.setImagenUrl(rs.getString("imagen_url"));
                p.setIdCategoria(rs.getInt("id_categoria"));
                p.setIdProveedor(rs.getInt("id_proveedor"));
                p.setEstado(rs.getString("estado"));

                lista.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    // Agregar un nuevo producto
    public void agregar(Producto p) {
        String sql = "INSERT INTO productos (nombre, descripcion, precio_compra, precio_venta, stock, imagen_url, id_categoria, id_proveedor, estado) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecioCompra());
            ps.setDouble(4, p.getPrecioVenta());
            ps.setInt(5, p.getStock());
            ps.setString(6, p.getImagenUrl());
            ps.setInt(7, p.getIdCategoria());
            ps.setInt(8, p.getIdProveedor());
            ps.setString(9, p.getEstado());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Actualizar un producto existente
    public void actualizar(Producto p) {
        String sql = "UPDATE productos SET nombre=?, descripcion=?, precio_compra=?, precio_venta=?, stock=?, imagen_url=?, id_categoria=?, id_proveedor=?, estado=? WHERE id_producto=?";

        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecioCompra());
            ps.setDouble(4, p.getPrecioVenta());
            ps.setInt(5, p.getStock());
            ps.setString(6, p.getImagenUrl());
            ps.setInt(7, p.getIdCategoria());
            ps.setInt(8, p.getIdProveedor());
            ps.setString(9, p.getEstado());
            ps.setInt(10, p.getIdProducto());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Eliminar un producto por ID
    public void eliminar(int id) {
        String sql = "DELETE FROM productos WHERE id_producto=?";
        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Obtener un producto por ID
    public Producto obtenerPorId(int id) {
        Producto p = null;
        String sql = "SELECT * FROM productos WHERE id_producto=?";

        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Producto();
                    p.setIdProducto(rs.getInt("id_producto"));
                    p.setNombre(rs.getString("nombre"));
                    p.setDescripcion(rs.getString("descripcion"));
                    p.setPrecioCompra(rs.getDouble("precio_compra"));
                    p.setPrecioVenta(rs.getDouble("precio_venta"));
                    p.setStock(rs.getInt("stock"));
                    p.setImagenUrl(rs.getString("imagen_url"));
                    p.setIdCategoria(rs.getInt("id_categoria"));
                    p.setIdProveedor(rs.getInt("id_proveedor"));
                    p.setEstado(rs.getString("estado"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return p;
    }
}
