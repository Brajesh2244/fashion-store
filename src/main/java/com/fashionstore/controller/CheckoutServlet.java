package com.fashionstore.controller;

import java.io.IOException;
import java.util.List;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.CartItemDAO;
import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.dao.impl.CartItemDAOImpl;
import com.fashionstore.model.Cart;
import com.fashionstore.model.CartView;
import com.fashionstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO;
    private CartItemDAO cartItemDAO;

    @Override
    public void init() throws ServletException {

        cartDAO = new CartDAOImpl();
        cartItemDAO = new CartItemDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(request.getContextPath() + "/login");
            return;

        }

        User user = (User) session.getAttribute("loggedInUser");

        Cart cart = cartDAO.getCartByUserId(user.getUserId());

        if (cart == null) {

            response.sendRedirect(request.getContextPath() + "/cart");
            return;

        }

        List<CartView> cartItems =
                cartItemDAO.getCartView(cart.getCartId());

        double total =
                cartItemDAO.getCartTotal(cart.getCartId());

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", total);

        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp")
               .forward(request, response);

    }

}