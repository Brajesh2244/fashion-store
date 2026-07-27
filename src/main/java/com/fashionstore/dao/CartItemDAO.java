package com.fashionstore.dao;

import java.util.List;

import com.fashionstore.model.CartItem;
import com.fashionstore.model.CartView;

public interface CartItemDAO {

    // Add Product To Cart
    boolean addToCart(CartItem cartItem);

    // Update Quantity Using Cart Item Id
    boolean updateQuantity(int cartItemId, int quantity);

    // Update Quantity Using Cart Id & Variant Id
    boolean updateQuantityByVariant(int cartId, int variantId, int quantity);

    // Remove Product
    boolean removeCartItem(int cartItemId);

    // Get Cart Item By Id
    CartItem getCartItemById(int cartItemId);

    // Get Cart Item By Cart & Variant
    CartItem getCartItem(int cartId, int variantId);

    // Get All Cart Items
    List<CartItem> getCartItems(int cartId);

    // Fetch Cart Details (Product + Variant + Cart)
    List<CartView> getCartView(int cartId);

    // Clear Cart
    boolean clearCart(int cartId);

    // Calculate Cart Total
    double getCartTotal(int cartId);

    // Check Product Already Exists
    boolean isProductInCart(int cartId, int variantId);

}