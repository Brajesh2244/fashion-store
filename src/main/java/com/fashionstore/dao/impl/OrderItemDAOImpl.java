package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.OrderItemDAO;
import com.fashionstore.model.OrderItem;
import com.fashionstore.util.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

    // ===========================
    // SQL Queries
    // ===========================

    private static final String ADD_ORDER_ITEM_SQL =
            "INSERT INTO order_items(order_id, variant_id, quantity, price) VALUES(?,?,?,?)";

    private static final String GET_ORDER_ITEM_BY_ID_SQL =
            "SELECT * FROM order_items WHERE order_item_id=?";

    private static final String GET_ORDER_ITEMS_BY_ORDER_SQL =
            "SELECT * FROM order_items WHERE order_id=?";

    private static final String DELETE_ORDER_ITEM_SQL =
            "DELETE FROM order_items WHERE order_item_id=?";

    private static final String GET_ORDER_ITEM_VIEW_SQL =
            "SELECT oi.order_item_id, oi.order_id, oi.quantity, oi.price, " +
            "p.product_id, p.product_name, p.brand, p.image_url, " +
            "pv.variant_id, pv.size " +
            "FROM order_items oi " +
            "JOIN product_variants pv ON oi.variant_id = pv.variant_id " +
            "JOIN products p ON pv.product_id = p.product_id " +
            "WHERE oi.order_id = ?";
    
    @Override
    public boolean addOrderItem(OrderItem orderItem) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(ADD_ORDER_ITEM_SQL)) {

            preparedStatement.setInt(1, orderItem.getOrderId());
            preparedStatement.setInt(2, orderItem.getVariantId());
            preparedStatement.setInt(3, orderItem.getQuantity());
            preparedStatement.setBigDecimal(4, orderItem.getPrice());

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public OrderItem getOrderItemById(int orderItemId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDER_ITEM_BY_ID_SQL)) {

            preparedStatement.setInt(1, orderItemId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return mapResultSetToOrderItem(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {

        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDER_ITEMS_BY_ORDER_SQL)) {

            preparedStatement.setInt(1, orderId);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                orderItems.add(mapResultSetToOrderItem(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }

    @Override
    public boolean deleteOrderItem(int orderItemId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ORDER_ITEM_SQL)) {

            preparedStatement.setInt(1, orderItemId);

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<com.fashionstore.model.OrderItemView> getOrderItemView(int orderId) {

        List<com.fashionstore.model.OrderItemView> list = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDER_ITEM_VIEW_SQL)) {

            preparedStatement.setInt(1, orderId);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {

                com.fashionstore.model.OrderItemView view = new com.fashionstore.model.OrderItemView();

                view.setOrderItemId(rs.getInt("order_item_id"));
                view.setOrderId(rs.getInt("order_id"));
                view.setProductId(rs.getInt("product_id"));
                view.setVariantId(rs.getInt("variant_id"));
                view.setProductName(rs.getString("product_name"));
                view.setBrand(rs.getString("brand"));
                view.setImageUrl(rs.getString("image_url"));
                view.setSize(rs.getString("size"));
                view.setPrice(rs.getBigDecimal("price"));
                view.setQuantity(rs.getInt("quantity"));
                
                java.math.BigDecimal subtotal = view.getPrice().multiply(java.math.BigDecimal.valueOf(view.getQuantity()));
                view.setSubTotal(subtotal);

                list.add(view);

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    private OrderItem mapResultSetToOrderItem(ResultSet resultSet) throws SQLException {

        OrderItem orderItem = new OrderItem();

        orderItem.setOrderItemId(resultSet.getInt("order_item_id"));
        orderItem.setOrderId(resultSet.getInt("order_id"));
        orderItem.setVariantId(resultSet.getInt("variant_id"));
        orderItem.setQuantity(resultSet.getInt("quantity"));
        orderItem.setPrice(resultSet.getBigDecimal("price"));

        return orderItem;
    }

}