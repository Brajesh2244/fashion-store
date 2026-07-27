package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.model.Cart;
import com.fashionstore.util.DBConnection;

public class CartDAOImpl implements CartDAO {

    private static final String CREATE_CART_SQL =
            "INSERT INTO cart(user_id) VALUES(?)";

    private static final String GET_CART_BY_USER_SQL =
            "SELECT * FROM cart WHERE user_id=?";

    private static final String GET_CART_BY_ID_SQL =
            "SELECT * FROM cart WHERE cart_id=?";

    private static final String GET_CART_ID_SQL =
            "SELECT cart_id FROM cart WHERE user_id=?";

    private static final String CHECK_CART_SQL =
            "SELECT COUNT(*) FROM cart WHERE user_id=?";

    private static final String DELETE_CART_SQL =
            "DELETE FROM cart WHERE cart_id=?";

    @Override
    public boolean createCart(int userId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(CREATE_CART_SQL)) {

            ps.setInt(1, userId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Cart getCartByUserId(int userId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_CART_BY_USER_SQL)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return mapResultSetToCart(rs);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return null;
    }

    @Override
    public Cart getCartById(int cartId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_CART_BY_ID_SQL)) {

            ps.setInt(1, cartId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return mapResultSetToCart(rs);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return null;
    }

    @Override
    public int getCartIdByUserId(int userId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_CART_ID_SQL)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return rs.getInt("cart_id");

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return 0;
    }

    @Override
    public boolean cartExists(int userId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(CHECK_CART_SQL)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return rs.getInt(1) > 0;

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return false;
    }

    @Override
    public boolean deleteCart(int cartId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(DELETE_CART_SQL)) {

            ps.setInt(1, cartId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return false;
    }

    private Cart mapResultSetToCart(ResultSet rs) throws SQLException {

        Cart cart = new Cart();

        cart.setCartId(rs.getInt("cart_id"));
        cart.setUserId(rs.getInt("user_id"));
        cart.setCreatedAt(rs.getTimestamp("created_at"));

        return cart;
    }

}