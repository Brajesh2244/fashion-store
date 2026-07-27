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

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAOImpl productDAO;
    private CategoryDAOImpl categoryDAO;

    @Override
    public void init() throws ServletException {

        productDAO = new ProductDAOImpl();
        categoryDAO = new CategoryDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");
        String sort = request.getParameter("sort");

        List<Product> products;

        if (keyword != null && !keyword.trim().isEmpty()) {

            products = productDAO.searchProducts(keyword);

        } else if (category != null && !category.isEmpty()) {

            products = productDAO.getProductsByCategory(Integer.parseInt(category));

        } else if ("low".equals(sort)) {

            products = productDAO.sortByPriceLowToHigh();

        } else if ("high".equals(sort)) {

            products = productDAO.sortByPriceHighToLow();

        } else if ("latest".equals(sort)) {

            products = productDAO.sortByNewest();

        } else {

            products = productDAO.getAllProducts();

        }

        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/WEB-INF/views/products.jsp")
               .forward(request, response);

    }

}