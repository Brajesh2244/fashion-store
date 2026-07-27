package com.fashionstore.controller;

import java.io.IOException;
import java.util.List;

import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.dao.impl.ProductVariantDAOImpl;
import com.fashionstore.model.Product;
import com.fashionstore.model.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/product")
public class ProductDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAOImpl productDAO;
    private ProductVariantDAOImpl variantDAO;

    @Override
    public void init() throws ServletException {

        productDAO = new ProductDAOImpl();
        variantDAO = new ProductVariantDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null) {

            response.sendRedirect("products");
            return;

        }

        int productId = Integer.parseInt(id);

        Product product = productDAO.getProductById(productId);

        List<ProductVariant> variants =
                variantDAO.getVariantsByProduct(productId);

        request.setAttribute("product", product);
        request.setAttribute("variants", variants);

        request.getRequestDispatcher("/WEB-INF/views/product-details.jsp")
               .forward(request, response);

    }

}