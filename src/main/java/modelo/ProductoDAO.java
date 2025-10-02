package modelo;

import conexion.conexionDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    // Listar todos los productos
    public List<Producto> listarProductos() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT p.id_producto, p.nombre, p.descripcion, p.precio_venta, p.stock, p.imagen_url, " +
                     "c.id_categoria, c.nombre_categoria, pr.id_proveedor, pr.empresa " +
                     "FROM productos p " +
                     "JOIN categorias c ON p.id_categoria = c.id_categoria " +
                     "JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor " +
                     "WHERE p.estado='Activo'";
        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecioVenta(rs.getDouble("precio_venta"));
                p.setStock(rs.getInt("stock"));
                p.setImagen(rs.getString("imagen_url"));

                // Categoria
                Categoria c = new Categoria();
                c.setIdCategoria(rs.getInt("id_categoria"));
                c.setNombreCategoria(rs.getString("nombre_categoria"));
                p.setCategoria(c);

                // Proveedor
                Proveedor pr = new Proveedor();
                pr.setIdProveedor(rs.getInt("id_proveedor"));
                pr.setEmpresa(rs.getString("empresa"));
                p.setProveedor(pr);

                lista.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Obtener un producto por su ID
    public Producto obtenerProductoPorId(int id) {
        Producto producto = null;
        String sql = "SELECT p.id_producto, p.nombre, p.descripcion, p.precio_venta, p.stock, p.imagen_url, " +
                     "c.id_categoria, c.nombre_categoria, pr.id_proveedor, pr.empresa, p.estado " +
                     "FROM productos p " +
                     "JOIN categorias c ON p.id_categoria = c.id_categoria " +
                     "JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor " +
                     "WHERE p.id_producto=?";
        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    producto = new Producto();
                    producto.setIdProducto(rs.getInt("id_producto"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecioVenta(rs.getDouble("precio_venta"));
                    producto.setStock(rs.getInt("stock"));
                    producto.setImagen(rs.getString("imagen_url"));
                    producto.setEstado(rs.getString("estado"));

                    Categoria c = new Categoria();
                    c.setIdCategoria(rs.getInt("id_categoria"));
                    c.setNombreCategoria(rs.getString("nombre_categoria"));
                    producto.setCategoria(c);

                    Proveedor pr = new Proveedor();
                    pr.setIdProveedor(rs.getInt("id_proveedor"));
                    pr.setEmpresa(rs.getString("empresa"));
                    producto.setProveedor(pr);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return producto;
    }

    // Listar categorías activas
    public List<Categoria> listarCategorias() {
        List<Categoria> lista = new ArrayList<>();
        String sql = "SELECT * FROM categorias WHERE estado='Activa'";
        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Categoria c = new Categoria();
                c.setIdCategoria(rs.getInt("id_categoria"));
                c.setNombreCategoria(rs.getString("nombre_categoria"));
                lista.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Listar proveedores activos
    public List<Proveedor> listarProveedores() {
        List<Proveedor> lista = new ArrayList<>();
        String sql = "SELECT * FROM proveedores WHERE estado='Activo'";
        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Proveedor p = new Proveedor();
                p.setIdProveedor(rs.getInt("id_proveedor"));
                p.setEmpresa(rs.getString("empresa"));
                lista.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Agregar nuevo producto
    public boolean agregarProducto(Producto p) {
        String sql = "INSERT INTO productos(nombre, descripcion, precio_venta, stock, imagen_url, id_categoria, id_proveedor, estado) " +
                     "VALUES(?,?,?,?,?,?,?,?)";
        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecioVenta());
            ps.setInt(4, p.getStock());
            ps.setString(5, p.getImagen());
            ps.setInt(6, p.getCategoria().getIdCategoria());
            ps.setInt(7, p.getProveedor().getIdProveedor());
            ps.setString(8, p.getEstado());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Actualizar producto existente
    public boolean actualizarProducto(Producto p) {
        String sql = "UPDATE productos SET nombre=?, descripcion=?, precio_venta=?, stock=?, imagen_url=?, id_categoria=?, id_proveedor=?, estado=? " +
                     "WHERE id_producto=?";
        try (Connection conn = conexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecioVenta());
            ps.setInt(4, p.getStock());
            ps.setString(5, p.getImagen());
            ps.setInt(6, p.getCategoria().getIdCategoria());
            ps.setInt(7, p.getProveedor().getIdProveedor());
            ps.setString(8, p.getEstado());
            ps.setInt(9, p.getIdProducto());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
