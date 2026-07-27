package com.fashionstore.dao;

import com.fashionstore.model.Cart;

public interface CartDAO {

    // Create Cart
    boolean createCart(int userId);

    // Get Cart By User
    Cart getCartByUserId(int userId);

    // Get Cart By Cart Id
    Cart getCartById(int cartId);

    // Get Cart Id By User
    int getCartIdByUserId(int userId);

    // Check Cart Exists
    boolean cartExists(int userId);

    // Delete Cart
    boolean deleteCart(int cartId);

}