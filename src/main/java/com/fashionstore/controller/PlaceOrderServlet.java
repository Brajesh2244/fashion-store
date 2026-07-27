package com.fashionstore.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.CartItemDAO;
import com.fashionstore.dao.OrderDAO;
import com.fashionstore.dao.OrderItemDAO;
import com.fashionstore.dao.ProductVariantDAO;

import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.dao.impl.CartItemDAOImpl;
import com.fashionstore.dao.impl.OrderDAOImpl;
import com.fashionstore.dao.impl.OrderItemDAOImpl;
import com.fashionstore.dao.impl.ProductVariantDAOImpl;

import com.fashionstore.model.Cart;
import com.fashionstore.model.CartView;
import com.fashionstore.model.Order;
import com.fashionstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO;
    private CartItemDAO cartItemDAO;
    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private ProductVariantDAO productVariantDAO;

    @Override
    public void init() throws ServletException {

        cartDAO = new CartDAOImpl();
        cartItemDAO = new CartItemDAOImpl();
        orderDAO = new OrderDAOImpl();
        orderItemDAO = new OrderItemDAOImpl();
        productVariantDAO = new ProductVariantDAOImpl();

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(request.getContextPath() + "/login");
            return;

        }

        User user =
                (User) session.getAttribute("loggedInUser");

        Cart cart =
                cartDAO.getCartByUserId(user.getUserId());

        if (cart == null) {

            response.sendRedirect(request.getContextPath() + "/cart");
            return;

        }

        List<CartView> cartItems =
                cartItemDAO.getCartView(cart.getCartId());

        if (cartItems == null || cartItems.isEmpty()) {

            response.sendRedirect(request.getContextPath() + "/cart");
            return;

        }

        String address =
                request.getParameter("address");

        String paymentMethod =
                request.getParameter("paymentMethod");

        BigDecimal totalAmount = BigDecimal.ZERO;

        for (CartView item : cartItems) {

            totalAmount =
                    totalAmount.add(item.getSubTotal());

        }

        Order order = new Order();

        order.setUserId(user.getUserId());
        order.setTotalAmount(totalAmount);
        order.setShippingAddress(address);
        order.setPaymentMethod(paymentMethod);
        order.setStatus("PLACED");

        int orderId =
                orderDAO.placeOrder(order);

        if (orderId == 0) {

            response.sendRedirect(
                    request.getContextPath() + "/checkout");

            return;

        }
        
        // Save Order Items & Update Stock

        for (CartView item : cartItems) {

            int availableStock =
                    productVariantDAO.getAvailableStock(
                            item.getVariantId());

            if (availableStock < item.getQuantity()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/checkout?error=stock");

                return;

            }

            com.fashionstore.model.OrderItem orderItem =
                    new com.fashionstore.model.OrderItem();

            orderItem.setOrderId(orderId);

            orderItem.setVariantId(item.getVariantId());

            orderItem.setQuantity(item.getQuantity());

            orderItem.setPrice(item.getPrice());

            orderItemDAO.addOrderItem(orderItem);

            int newStock =
                    availableStock - item.getQuantity();

            productVariantDAO.updateStock(
                    item.getVariantId(),
                    newStock);

        }

        // Clear Cart

        cartItemDAO.clearCart(cart.getCartId());

        // Redirect To Order Success Page

        response.sendRedirect(
                request.getContextPath()
                + "/order-success?orderId=" + orderId);

    }

}

