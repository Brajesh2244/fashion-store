package com.fashionstore.dao;

import java.util.List;

import com.fashionstore.model.Order;

public interface OrderDAO {

    // Place Order
    int placeOrder(Order order);

    // Fetch Order
    Order getOrderById(int orderId);

    // Fetch All Orders of a User
    List<Order> getOrdersByUserId(int userId);

    // Fetch All Orders
    List<Order> getAllOrders();

    // Update Order Status
    boolean updateOrderStatus(int orderId, String status);

    // Cancel Order
    boolean cancelOrder(int orderId);

    // Delete Order
    boolean deleteOrder(int orderId);
}