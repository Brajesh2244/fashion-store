package com.fashionstore.util;

import java.util.List;

import com.fashionstore.dao.impl.CategoryDAOImpl;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.dao.impl.ProductVariantDAOImpl;
import com.fashionstore.model.Category;
import com.fashionstore.model.Product;
import com.fashionstore.model.ProductVariant;

public class DAOTest {

    public static void main(String[] args) {

        System.out.println("====================================");
        System.out.println("   FASHION STORE DAO TEST STARTED");
        System.out.println("====================================");

        testCategoryDAO();

        testProductDAO();

        testProductVariantDAO();

        System.out.println("\n====================================");
        System.out.println("        TEST COMPLETED");
        System.out.println("====================================");
    }

    private static void testCategoryDAO() {

        System.out.println("\n----- CATEGORY DAO TEST -----");

        CategoryDAOImpl categoryDAO = new CategoryDAOImpl();

        List<Category> categories = categoryDAO.getAllCategories();

        for (Category category : categories) {
            System.out.println(
                    category.getCategoryId() + " - "
                    + category.getCategoryName());
        }
    }

    private static void testProductDAO() {

        System.out.println("\n----- PRODUCT DAO TEST -----");

        ProductDAOImpl productDAO = new ProductDAOImpl();

        List<Product> products = productDAO.getAllProducts();

        for (Product product : products) {

            System.out.println(
                    product.getProductId() + " | "
                    + product.getProductName() + " | "
                    + product.getBrand() + " | ₹"
                    + product.getPrice());

        }

    }

    private static void testProductVariantDAO() {

        System.out.println("\n----- PRODUCT VARIANT DAO TEST -----");

        ProductVariantDAOImpl variantDAO = new ProductVariantDAOImpl();

        List<ProductVariant> variants = variantDAO.getVariantsByProduct(1);

        for (ProductVariant variant : variants) {

            System.out.println(
                    "Variant ID : " + variant.getVariantId()
                    + "  Size : " + variant.getSize()
                    + "  Stock : " + variant.getStock());

        }

    }

}