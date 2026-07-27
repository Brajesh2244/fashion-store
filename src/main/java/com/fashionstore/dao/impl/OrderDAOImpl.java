package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.OrderDAO;
import com.fashionstore.model.Order;
import com.fashionstore.util.DBConnection;

public class OrderDAOImpl implements OrderDAO {

    // ===========================
    // SQL Queries
    // ===========================

    private static final String PLACE_ORDER_SQL =
            "INSERT INTO orders(user_id, total_amount, shipping_address, payment_method, status) VALUES(?,?,?,?,?)";

    private static final String GET_ORDER_BY_ID_SQL =
            "SELECT * FROM orders WHERE order_id=?";

    private static final String GET_ORDERS_BY_USER_SQL =
            "SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC";

    private static final String GET_ALL_ORDERS_SQL =
            "SELECT * FROM orders ORDER BY order_date DESC";

    private static final String UPDATE_ORDER_STATUS_SQL =
            "UPDATE orders SET status=? WHERE order_id=?";

    private static final String CANCEL_ORDER_SQL =
            "UPDATE orders SET status='CANCELLED' WHERE order_id=?";

    private static final String DELETE_ORDER_SQL =
            "DELETE FROM orders WHERE order_id=?";
    @Override
    public int placeOrder(Order order) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(PLACE_ORDER_SQL, PreparedStatement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setBigDecimal(2, order.getTotalAmount());
            preparedStatement.setString(3, order.getShippingAddress());
            preparedStatement.setString(4, order.getPaymentMethod());
            preparedStatement.setString(5, order.getStatus());

            int affectedRows = preparedStatement.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = preparedStatement.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public Order getOrderById(int orderId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDER_BY_ID_SQL)) {

            preparedStatement.setInt(1, orderId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return mapResultSetToOrder(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {

        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDERS_BY_USER_SQL)) {

            preparedStatement.setInt(1, userId);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                orders.add(mapResultSetToOrder(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    @Override
    public List<Order> getAllOrders() {

        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_ORDERS_SQL)) {

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                orders.add(mapResultSetToOrder(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }
    
    @Override
    public boolean updateOrderStatus(int orderId, String status) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ORDER_STATUS_SQL)) {

            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, orderId);

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean cancelOrder(int orderId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(CANCEL_ORDER_SQL)) {

            preparedStatement.setInt(1, orderId);

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean deleteOrder(int orderId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ORDER_SQL)) {

            preparedStatement.setInt(1, orderId);

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private Order mapResultSetToOrder(ResultSet resultSet) throws SQLException {

        Order order = new Order();

        order.setOrderId(resultSet.getInt("order_id"));
        order.setUserId(resultSet.getInt("user_id"));
        order.setTotalAmount(resultSet.getBigDecimal("total_amount"));
        order.setShippingAddress(resultSet.getString("shipping_address"));
        order.setPaymentMethod(resultSet.getString("payment_method"));
        order.setStatus(resultSet.getString("status"));
        order.setOrderDate(resultSet.getTimestamp("order_date"));

        return order;
    }

}
