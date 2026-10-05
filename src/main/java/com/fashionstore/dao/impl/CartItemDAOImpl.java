package com.fashionstore.dao.impl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.CartItemDAO;
import com.fashionstore.model.CartItem;
import com.fashionstore.model.CartView;
import com.fashionstore.util.DBConnection;

public class CartItemDAOImpl implements CartItemDAO {

    private static final String ADD_TO_CART_SQL =
            "INSERT INTO cart_items(cart_id, variant_id, quantity) VALUES(?,?,?)";

    private static final String UPDATE_QUANTITY_SQL =
            "UPDATE cart_items SET quantity=? WHERE cart_item_id=?";

    private static final String UPDATE_QUANTITY_BY_VARIANT_SQL =
            "UPDATE cart_items SET quantity=? WHERE cart_id=? AND variant_id=?";

    private static final String REMOVE_CART_ITEM_SQL =
            "DELETE FROM cart_items WHERE cart_item_id=?";

    private static final String GET_CART_ITEM_BY_ID_SQL =
            "SELECT * FROM cart_items WHERE cart_item_id=?";

    private static final String GET_CART_ITEM_SQL =
            "SELECT * FROM cart_items WHERE cart_id=? AND variant_id=?";

    private static final String GET_CART_ITEMS_SQL =
            "SELECT * FROM cart_items WHERE cart_id=?";

    private static final String CLEAR_CART_SQL =
            "DELETE FROM cart_items WHERE cart_id=?";

    private static final String GET_CART_TOTAL_SQL =
            "SELECT SUM(ci.quantity * p.price) AS total "
          + "FROM cart_items ci "
          + "JOIN product_variants pv ON ci.variant_id = pv.variant_id "
          + "JOIN products p ON pv.product_id = p.product_id "
          + "WHERE ci.cart_id=?";

    private static final String CHECK_PRODUCT_IN_CART_SQL =
            "SELECT COUNT(*) FROM cart_items WHERE cart_id=? AND variant_id=?";

    private static final String GET_CART_VIEW_SQL =
            "SELECT ci.cart_item_id, " +
            "p.product_id, " +
            "pv.variant_id, " +
            "p.product_name, " +
            "p.brand, " +
            "p.image_url, " +
            "pv.size, " +
            "p.price, " +
            "ci.quantity " +
            "FROM cart_items ci " +
            "JOIN product_variants pv ON ci.variant_id = pv.variant_id " +
            "JOIN products p ON pv.product_id = p.product_id " +
            "WHERE ci.cart_id=?";
    
    @Override
    public boolean addToCart(CartItem cartItem) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(ADD_TO_CART_SQL)) {

            ps.setInt(1, cartItem.getCartId());
            ps.setInt(2, cartItem.getVariantId());
            ps.setInt(3, cartItem.getQuantity());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return false;
    }

    @Override
    public boolean updateQuantity(int cartItemId, int quantity) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_QUANTITY_SQL)) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return false;
    }

    @Override
    public boolean updateQuantityByVariant(int cartId,
                                           int variantId,
                                           int quantity) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps =
                     connection.prepareStatement(UPDATE_QUANTITY_BY_VARIANT_SQL)) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            ps.setInt(3, variantId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return false;
    }

    @Override
    public boolean removeCartItem(int cartItemId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(REMOVE_CART_ITEM_SQL)) {

            ps.setInt(1, cartItemId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return false;
    }

    @Override
    public CartItem getCartItemById(int cartItemId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps =
                     connection.prepareStatement(GET_CART_ITEM_BY_ID_SQL)) {

            ps.setInt(1, cartItemId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return mapResultSetToCartItem(rs);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return null;
    }

    @Override
    public CartItem getCartItem(int cartId, int variantId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps =
                     connection.prepareStatement(GET_CART_ITEM_SQL)) {

            ps.setInt(1, cartId);
            ps.setInt(2, variantId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return mapResultSetToCartItem(rs);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return null;
    }

    @Override
    public List<CartItem> getCartItems(int cartId) {

        List<CartItem> list = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps =
                     connection.prepareStatement(GET_CART_ITEMS_SQL)) {

            ps.setInt(1, cartId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(mapResultSetToCartItem(rs));

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return list;
    }

    @Override
    public boolean clearCart(int cartId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps =
                     connection.prepareStatement(CLEAR_CART_SQL)) {

            ps.setInt(1, cartId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return false;
    }

    @Override
    public double getCartTotal(int cartId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps =
                     connection.prepareStatement(GET_CART_TOTAL_SQL)) {

            ps.setInt(1, cartId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return rs.getDouble("total");

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return 0;
    }

    @Override
    public boolean isProductInCart(int cartId, int variantId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps =
                     connection.prepareStatement(CHECK_PRODUCT_IN_CART_SQL)) {

            ps.setInt(1, cartId);
            ps.setInt(2, variantId);

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
    public List<CartView> getCartView(int cartId) {

        List<CartView> list = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_CART_VIEW_SQL)) {

            ps.setInt(1, cartId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                CartView view = new CartView();

                view.setCartItemId(rs.getInt("cart_item_id"));
                view.setProductId(rs.getInt("product_id"));
                view.setVariantId(rs.getInt("variant_id"));
                view.setProductName(rs.getString("product_name"));
                view.setBrand(rs.getString("brand"));
                view.setImageUrl(rs.getString("image_url"));
                view.setSize(rs.getString("size"));
                view.setPrice(rs.getBigDecimal("price"));
                view.setQuantity(rs.getInt("quantity"));

                BigDecimal subtotal =
                        view.getPrice().multiply(
                                BigDecimal.valueOf(view.getQuantity()));

                view.setSubTotal(subtotal);

                list.add(view);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return list;
    }

    private CartItem mapResultSetToCartItem(ResultSet rs) throws SQLException {

        CartItem item = new CartItem();

        item.setCartItemId(rs.getInt("cart_item_id"));
        item.setCartId(rs.getInt("cart_id"));
        item.setVariantId(rs.getInt("variant_id"));
        item.setQuantity(rs.getInt("quantity"));

        return item;
    }

    @Override
    public int getCartItemCount(int cartId) {
        String sql = "SELECT COUNT(*) FROM cart_items WHERE cart_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}