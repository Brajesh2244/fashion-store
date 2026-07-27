package com.fashionstore.dao;

import java.util.List;

import com.fashionstore.model.OrderItem;

public interface OrderItemDAO {

    // Add Order Item
    boolean addOrderItem(OrderItem orderItem);

    // Fetch Order Item
    OrderItem getOrderItemById(int orderItemId);

    // Fetch All Items of an Order
    List<OrderItem> getOrderItemsByOrderId(int orderId);

    // Delete Order Item
    boolean deleteOrderItem(int orderItemId);

    // Fetch Order Item View (Detailed)
    List<com.fashionstore.model.OrderItemView> getOrderItemView(int orderId);
}