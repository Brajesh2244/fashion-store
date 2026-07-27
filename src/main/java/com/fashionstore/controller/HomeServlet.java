package com.fashionstore.controller;

import java.io.IOException;
import java.util.List;

import com.fashionstore.dao.impl.CategoryDAOImpl;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Category;
import com.fashionstore.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CategoryDAOImpl categoryDAO;
    private ProductDAOImpl productDAO;

    @Override
    public void init() throws ServletException {

        categoryDAO = new CategoryDAOImpl();
        productDAO = new ProductDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories = categoryDAO.getAllCategories();

        List<Product> products = productDAO.getAllProducts();

        request.setAttribute("categories", categories);

        request.setAttribute("products", products);

        request.getRequestDispatcher("/WEB-INF/views/home.jsp")
        .forward(request, response);
    }

}