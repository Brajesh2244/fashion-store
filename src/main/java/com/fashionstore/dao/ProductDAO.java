package com.fashionstore.dao;

import java.util.List;

import com.fashionstore.model.Product;

public interface ProductDAO {

    // Add Product
    boolean addProduct(Product product);

    // Update Product
    boolean updateProduct(Product product);

    // Delete Product
    boolean deleteProduct(int productId);

    // Fetch Product
    Product getProductById(int productId);

    // Fetch All Products
    List<Product> getAllProducts();

    // Search Products
    List<Product> searchProducts(String keyword);

    // Category Filter
    List<Product> getProductsByCategory(int categoryId);

    // Price Filter
    List<Product> getProductsByPrice(double minPrice, double maxPrice);

    // Brand Filter
    List<Product> getProductsByBrand(String brand);

    // Sorting
    List<Product> sortByPriceLowToHigh();

    List<Product> sortByPriceHighToLow();

    List<Product> sortByNewest();
}